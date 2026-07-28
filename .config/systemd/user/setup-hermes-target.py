#!/usr/bin/env python3
"""Wire hermes-gateway services to hermes.target.

Order of operations matters -- hermes gateway install / systemctl enable
rewrites the .service files, so we enable FIRST, then patch WantedBy.

Usage:
    python3 setup-hermes-target.py          # interactive
    python3 setup-hermes-target.py --yes    # skip prompts
"""  # noqa: CPY001

from __future__ import annotations

import argparse
import subprocess
import sys
from typing import Self
from enum import Enum, auto
from pathlib import Path

# -- Paths ----------------------------------------------------------------

SYSTEMD_DIR = Path.home() / ".config" / "systemd" / "user"
PROFILES_DIR = Path.home() / ".hermes" / "profiles"
HERMES_TARGET = SYSTEMD_DIR / "hermes.target"
DEFAULT_TARGET_WANTS = SYSTEMD_DIR / "default.target.wants"

# -- Template strings -----------------------------------------------------

HERMES_TARGET_TEMPLATE = (
    "[Unit]\n"
    "Description=Hermes Agent Gateway Services Target\n"
    "After=graphical.target network-online.target network.target\n"
    "Wants=graphical.target network-online.target network.target\n"
    "\n"
    "[Install]\n"
    "WantedBy=default.target\n"
)

WANTEDBY_DEFAULT = "WantedBy=default.target"
WANTEDBY_HERMES = "WantedBy=hermes.target"

# -- Profiles to skip (not actual hermes agent profiles) ------------------

SKIP_PROFILES = {"cleanup_sessions.sh"}


# -- Helpers ---------------------------------------------------------------


def run_silent(cmd: list[str]) -> subprocess.CompletedProcess:
    """Run a command, suppress output, don't raise on non-zero exit."""
    return subprocess.run(cmd, check=False, capture_output=True, text=True)


def ask_confirm(prompt: str) -> bool:
    resp = input(prompt).strip().lower()
    return resp in ("", "y", "yes")


# -- Phase tracking --------------------------------------------------------


class Phase(Enum):
    """Tracks which installation step we're on.

    Transitions are linear -- each phase has exactly one successor.
    The installer's step() method validates + advances automatically.
    """

    INIT = auto()
    TARGET_READY = auto()
    PROFILES_DISCOVERED = auto()
    SERVICES_INSTALLED = auto()
    SERVICES_ENABLED = auto()
    PATCHED = auto()
    CLEANED = auto()
    RELOADED = auto()
    DONE = auto()


# Build transition map from enum member order: each phase -> the next one.
# Linear pipeline -- no branching, no cycles.
_MEMBERS = list(Phase)
VALID_TRANSITIONS: dict[Phase, Phase] = {
    _MEMBERS[i]: _MEMBERS[i + 1] for i in range(len(_MEMBERS) - 1)
}


# -- Installer ------------------------------------------------------------


class ServiceInstaller:
    """Manages discovery, installation, and patching of hermes-gateway services.

    All phase methods return self for chaining. The pipeline is enforced by
    _require() (asserts expected phase) + step() (advances to next phase).
    """

    def __init__(
        self, systemd_dir: Path, profiles_dir: Path, skip_prompts: bool
    ):
        self.systemd_dir = systemd_dir
        self.profiles_dir = profiles_dir
        self.target_path = systemd_dir / "hermes.target"
        self.wants_dir = systemd_dir / "default.target.wants"
        self.skip_prompts = skip_prompts
        self.profiles: list[str] = []
        self.phase = Phase.INIT

    def step(self) -> Self:
        """Advance to the next phase in the pipeline.
        Raises RuntimeError if already at terminal phase."""
        next_phase = VALID_TRANSITIONS.get(self.phase)
        if next_phase is None:
            raise RuntimeError(
                f"Phase violation: {self.phase.name} is terminal, no next step"
            )
        self.phase = next_phase
        return self

    def _require(self, expected: Phase) -> Self:
        """Assert we're in the expected phase before doing work.
        Returns self for chaining: self._require(Phase.X).step()"""
        if self.phase is not expected:
            raise RuntimeError(
                f"Phase violation: expected {expected.name}, "
                f"currently in {self.phase.name}"
            )
        return self

    # -- discovery ---------------------------------------------------------

    def discover_profiles(self) -> Self:
        self._require(Phase.TARGET_READY).step()  # -> PROFILES_DISCOVERED

        if not self.profiles_dir.is_dir():
            self.profiles = []
        else:
            self.profiles = sorted(
                p.name
                for p in self.profiles_dir.iterdir()
                if p.is_dir() and p.name not in SKIP_PROFILES
            )
        return self

    def print_profiles(self) -> Self:
        print(
            f"\n--- Discovered profiles: "
            f"{', '.join(self.profiles) or '(none)'} ---"
        )
        return self

    def service_name(self, profile: str | None) -> str:
        if profile is None:
            return "hermes-gateway.service"
        return f"hermes-gateway-{profile}.service"

    def service_path(self, profile: str | None) -> Path:
        return self.systemd_dir / self.service_name(profile)

    def all_service_names(self) -> list[str]:
        return [self.service_name(None)] + [
            self.service_name(p) for p in self.profiles
        ]

    # -- target ------------------------------------------------------------

    def ensure_target(self) -> Self:
        """Create hermes.target if missing."""
        self._require(Phase.INIT)

        if self.target_path.exists():
            print(f"  [ok] {self.target_path} already exists")
            self.step()
            return self

        print(f"\n  hermes.target not found at {self.target_path}")
        if not self.skip_prompts and not ask_confirm("  Create it? [Y/n] "):
            print("  Aborting -- hermes.target is required.")
            sys.exit(1)

        self.target_path.write_text(HERMES_TARGET_TEMPLATE)
        print(f"  [ok] Created {self.target_path}")
        self.step()
        return self

    # -- install missing ---------------------------------------------------

    def install_missing_service(self, profile: str | None) -> bool:
        """Run hermes gateway install for a profile missing its .service file.
        Returns True if installation was performed.
        Caller must hold Phase.PROFILES_DISCOVERED (install_all_missing does)."""
        svc_path = self.service_path(profile)
        if svc_path.exists():
            return False

        label = profile or "default"
        print(f"\n  Service file for '{label}' not found at {svc_path}")

        if not self.skip_prompts and not ask_confirm(
            f"  Run 'hermes gateway install' for '{label}'? [Y/n] "
        ):
            print(f"  Skipping '{label}'")
            return False

        cmd = [
            "hermes",
            "gateway",
            "install",
            "--start-now",
            "--start-on-login",
        ]
        if profile:
            cmd.extend(["--profile", profile])

        print(f"  Running: {' '.join(cmd)}")
        result = run_silent(cmd)
        if result.returncode != 0:
            print(f"  [warn] install exited {result.returncode}")
            if result.stdout:
                print(f"  stdout: {result.stdout.strip()}")
            if result.stderr:
                print(f"  stderr: {result.stderr.strip()}")
            return False

        print(f"  [ok] Installed {self.service_name(profile)}")
        return True

    def install_all_missing(self) -> Self:
        """Install missing services for default + every discovered profile."""
        self._require(Phase.PROFILES_DISCOVERED).step()  # -> SERVICES_INSTALLED

        print("\n--- Checking for missing service files ---")
        self.install_missing_service(profile=None)
        for profile in self.profiles:
            self.install_missing_service(profile=profile)
        return self

    # -- enable ------------------------------------------------------------

    def enable_all(self) -> Self:
        """Enable (and start) each service."""
        self._require(Phase.SERVICES_INSTALLED).step()  # -> SERVICES_ENABLED

        print("\n--- Enabling services ---")
        for name in self.all_service_names():
            svc_path = self.systemd_dir / name
            if not svc_path.exists():
                print(f"  [skip] {name} (file not found)")
                continue

            print(f"  enabling {name} ...")
            result = run_silent(
                ["systemctl", "--user", "enable", "--now", name]
            )
            if result.returncode == 0:
                print(f"  [ok] {name}")
            else:
                print(
                    f"  [warn] {name} enable exited {result.returncode}: "
                    f"{result.stderr.strip()}"
                )
        return self

    # -- patch -------------------------------------------------------------

    def patch_wanted_by(self) -> Self:
        """Rewrite WantedBy=default.target -> WantedBy=hermes.target."""
        self._require(Phase.SERVICES_ENABLED).step()  # -> PATCHED

        print("\n--- Patching WantedBy to hermes.target ---")
        for name in self.all_service_names():
            svc_path = self.systemd_dir / name
            if not svc_path.exists():
                print(f"  [skip] {name} (file not found)")
                continue

            content = svc_path.read_text()
            if WANTEDBY_HERMES in content:
                print(f"  [ok] {name} (already patched)")
                continue

            if WANTEDBY_DEFAULT not in content:
                print(
                    f"  [warn] {name} -- no {WANTEDBY_DEFAULT} found, skipping"
                )
                continue

            svc_path.write_text(
                content.replace(WANTEDBY_DEFAULT, WANTEDBY_HERMES)
            )
            print(f"  [ok] {name} -- {WANTEDBY_HERMES}")
        return self

    # -- cleanup -----------------------------------------------------------

    def cleanup_default_wants(self) -> Self:
        """Remove stale symlinks from default.target.wants/ for hermes services."""
        self._require(Phase.PATCHED).step()  # -> CLEANED

        print("\n--- Cleaning default.target.wants/ ---")
        if not self.wants_dir.is_dir():
            print("  [skip] default.target.wants/ not found")
            return self

        for name in self.all_service_names():
            link = self.wants_dir / name
            if link.is_symlink():
                link.unlink()
                print(f"  [ok] Removed {link}")
            else:
                print(f"  [skip] {name} (no symlink)")
        return self

    # -- daemon-reload -----------------------------------------------------

    def daemon_reload(self) -> Self:
        self._require(Phase.CLEANED).step()  # -> RELOADED

        print("\n--- daemon-reload ---")
        run_silent(["systemctl", "--user", "daemon-reload"])
        print("  [ok] daemon-reload done")
        return self

    # -- status ------------------------------------------------------------

    def show_status(self) -> Self:
        self._require(Phase.RELOADED).step()  # -> DONE

        print("\n--- Status ---")
        result = run_silent(
            ["systemctl", "--user", "status", "hermes.target", "--no-pager"]
        )
        print(result.stdout)
        return self

    # -- orchestration -----------------------------------------------------

    def run(self) -> Self:
        print("=== Hermes Target Setup ===\n")

        print("--- Checking hermes.target ---")
        return (
            self
            # -
            .ensure_target()
            .discover_profiles()
            .print_profiles()
            .install_all_missing()
            .enable_all()
            .patch_wanted_by()
            .cleanup_default_wants()
            .daemon_reload()
            .show_status()
        )


# -- Entry point -----------------------------------------------------------


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Wire hermes services to hermes.target"
    )
    parser.add_argument(
        "--yes", "-y", action="store_true", help="Skip all prompts"
    )
    args = parser.parse_args()

    installer = ServiceInstaller(
        systemd_dir=SYSTEMD_DIR,
        profiles_dir=PROFILES_DIR,
        skip_prompts=args.yes,
    )
    installer.run()

    print("Done. Services should now start via hermes.target at boot.")
    print(
        "Hyprland trigger: "
        "hl.exec_cmd('sleep 3 && systemctl --user start hermes.target')"
    )


if __name__ == "__main__":
    main()
