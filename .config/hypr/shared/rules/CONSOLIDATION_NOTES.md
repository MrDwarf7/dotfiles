# Window Rules — Consolidation Notes

## Shape Categories

### Shape A: Simple Float + Size (18 files)

Single rule, match by class, float + center + fixed size.

| File                   | Class                                                  | Size                                      |
| ---------------------- | ------------------------------------------------------ | ----------------------------------------- |
| `ag_blueman.lua`       | `blueman-manager`                                      | 1000x650                                  |
| `ag_pulse_pavu.lua`    | `org.pulseaudio.pavucontrol`                           | 1000x650                                  |
| `ag_qalculate.lua`     | `io.github.Qalculate.qalculate-qt`                     | 600x900                                   |
| `ag_qt5ct.lua`         | `qt5ct`                                                | 960x540                                   |
| `appimagelauncher.lua` | `AppImageLauncherSettings`                             | 1450x1000                                 |
| `polychromatic.lua`    | `polychromatic`                                        | 1050x950 (+ device-info sub-rule 200x400) |
| `showmethekey.lua`     | `one.alynx.showmethekey\|showmethekey-gtk`             | float+pin                                 |
| `solaar.lua`           | `solaar` + title `Solaar`                              | 1000x650 (+ rule-editor 600x500)          |
| `swappy.lua`           | `swappy`                                               | 2560x1200                                 |
| `thunar.lua`           | `thunar\|nemo\|dolphin`                                | 1450x1000                                 |
| `viewnoir.lua`         | `viewnior`                                             | 2560x1200                                 |
| `waypaper.lua`         | `waypaper`                                             | 1450x1000                                 |
| `webapp-manager.lua`   | `webapp-manager.py` + title `Web Apps`                 | 1000x650 (+ generic WebApp-\*)            |
| `wezterm.lua`          | `org.wezfurlong.wezterm`                               | 2280x1000                                 |
| `zmk-studio.lua`       | `zmk-studio`                                           | 1450x1000                                 |
| `signal.lua`           | `signal`                                               | 1600x1250                                 |
| `ag_mpv.lua`           | title `imv\|mpv\|danmufloat\|termfloat\|nemo\|ncmpcpp` | 960x540, centered 25%                     |
| `feh.lua`              | `feh`                                                  | float+center (tag+float pattern)          |

**Consolidation target**: Single file `ag_float_size.lua` with ~18 rules.

---

### Shape B: Tag → Effect (tag-and-style) (12 files)

Match by class/title → assign tag → second rule matches tag → apply effects (opacity, float, size, workspace).

| File                             | Tag                                             | Effects                                                                 |
| -------------------------------- | ----------------------------------------------- | ----------------------------------------------------------------------- |
| `affine.lua`                     | `+affine`                                       | opacity 1.0, workspace 5 silent, persistent_size                        |
| `davinici-panels.lua`            | `+daviniciPanels`                               | opacity 1.0, float+center 1280x720                                      |
| `ghostty.lua`                    | `+ghostty`                                      | size 2560x1330, persistent_size, border_size 0                          |
| `obsidian.lua`                   | `+obsidian`                                     | opacity 1.0, workspace 2 silent, persistent_size                        |
| `rimworld.lua`                   | `+rimworld`                                     | opacity 1.0, persistent_size, border_size 0, size 5120x1440, fullscreen |
| `thunderbird.lua`                | `+thunderbird-write` / `+thunderbird-workspace` | opacity, float+center 1600x900, workspace 3 silent                      |
| `ueberzugpp.lua`                 | `+ueberzugpp_nvim`                              | opacity 1.0, no_initial_focus, persistent_size                          |
| `xdg-portal.lua`                 | `+portal_xdg`                                   | float+center 1680x1080                                                  |
| `youtube-music_ytm_yt_music.lua` | `+ytm`                                          | workspace 8 silent, center+size 1250x850, maximize, persistent_size     |
| `ytm__pear.lua`                  | `+ytm`                                          | **IDENTICAL to youtube-music_ytm_yt_music.lua — exact duplicate**       |
| `zathura.lua`                    | `+zathura`                                      | opacity 1.0, persistent_size, float+size 1100x1300                      |
| `zed-editor.lua`                 | `+zedEditor` / `+zedEditorSettings`             | workspace 3 silent, size 2950x1350, opacity, float settings 1050x1050   |

**Consolidation target**: Single file `ag_tag_effects.lua` with ~12 tag+effect pairs.

**Note**: `ytm__pear.lua` is a complete duplicate of `youtube-music_ytm_yt_music.lua`. One should be deleted.

---

### Shape C: Workspace Assignment (5 files)

Match by class → assign to workspace, sometimes with no_initial_focus.

| File           | Class                                         | Workspace | Extra                                                  |
| -------------- | --------------------------------------------- | --------- | ------------------------------------------------------ |
| `chromium.lua` | `chromium`                                    | 1 silent  | size 2660x1300, persistent_size (+ devtools sub-rules) |
| `discord.lua`  | `discord\|armcord\|webcord\|vencord\|vesktop` | 9 silent  | maximize, opacity 0.90/0.60                            |
| `docker.lua`   | `Docker Desktop`                              | 7 silent  | no_initial_focus                                       |
| `spotify.lua`  | `spotify`                                     | 8 silent  | maximize                                               |
| `telegram.lua` | `QQ\|Telegram\|org.telegram.desktop`          | 6 silent  | center, persistent_size, opacity 1.0                   |

**Consolidation target**: Single file `ag_workspace.lua` with 5 rules.

---

### Shape D: Complex / Unique (5 files)

These have unique structures that don't fit cleanly into the above shapes.

| File             | Description                                                                                                                                                                                                   |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `ag_popups.lua`  | 6 rules: file dialogs, xdg portals, polkit agents, zenity, stay-focused for pinentry + polkit. Could stay separate as `ag_popups.lua` — it's already a group.                                                 |
| `ag_pip.lua`     | 3 rules: Picture-in-Picture for librewolf + empty class. Uses `hl.window_rule()` direct call instead of `return {}`.                                                                                          |
| `alecaframe.lua` | 6 rules: 3 tags + 3 effects for overwolf.exe (quick launcher, spawn window, alecaframe). Complex matching.                                                                                                    |
| `calendly.lua`   | 2 rules: vivaldi webapp calendly — tag + float+size.                                                                                                                                                          |
| `steam.lua`      | 8 rules: updater, signin, main, settings, special offers — each with tag + effect.                                                                                                                            |
| `vivaldi.lua`    | 10 rules: init class/title, settings, webapp matching. Most complex file.                                                                                                                                     |
| `zen.lua`        | 3 rules: browser tag, workspace, opacity. (Note: first rule has no effects — tag only, no match for tag effects on workspace/opacity lines — possible bug: workspace and opacity rules have no `match` block) |
| `code.lua`       | 1 rule: opacity 1.0 for `code` class. Trivial.                                                                                                                                                                |
| `a_generic.lua`  | 1 rule: suppress_event maximize for all windows. Global.                                                                                                                                                      |
| `jetbrains.lua`  | 7 rules: IDE project tool windows, popups, splash, etc. Complex matching by title patterns.                                                                                                                   |

**Consolidation target**: These can stay as-is or be grouped into `ag_complex.lua` if desired. `code.lua` and `a_generic.lua` are trivial enough to merge anywhere.

---

## Duplicates

- **`ytm__pear.lua`** is **identical** to **`youtube-music_ytm_yt_music.lua`**. Delete one.

## Summary

| Category          | Files          | Rules   | Target File              |
| ----------------- | -------------- | ------- | ------------------------ |
| A: Float + Size   | 18             | ~18     | `ag_float_size.lua`      |
| B: Tag → Effect   | 12 (11 unique) | ~24     | `ag_tag_effects.lua`     |
| C: Workspace      | 5              | ~5      | `ag_workspace.lua`       |
| D: Complex/Unique | 10             | ~40     | keep or `ag_complex.lua` |
| **Total**         | **50**         | **~87** | **~4-5 files**           |

## init.lua Changes Needed

The module list in `init.lua` would shrink from 50 entries to ~10-12. Each `require` is a separate file open + Lua parse, so this cuts cold-start I/O by ~75%.

## Notes

- `ag_pip.lua` uses `hl.window_rule({...})` direct call instead of `return {}`. Inconsistent with the loader which expects `return {}`. Works because the loader checks `if type(rules) == "table"` — the direct call returns nil, so it's silently skipped. **Bug**: the rules in `ag_pip.lua` are never actually applied.
- `zen.lua` workspace and opacity rules have no `match` block — they'll apply to ALL windows. Probably a bug.
- `code.lua` sets `opacity = 1.00` (number) while most others use `opacity = "1.0 override 1.0 override"` (string). Inconsistent format.
