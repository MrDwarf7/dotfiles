# Window Rules Audit

Cross-referenced 3 sources:

- `shared/rules/` (PROD/LIVE -- current staging files)
- `shared/rules/.prev/rules/` (original 52 individual files before consolidation)
- `__fixing/old_before_consolidation/` (registry + generators that were actually running)

**Rule: items from `old_before_consolidation/` take precedence over most things.**

---

## Section 1: MISSING from PROD (were in old_before_consolidation registry)

These apps had rules in the registry that are NOT in any current prod file.

### 1a. float_center missing entries

The registry `M.float_center` had these apps that are NOT in `float_center.lua`:

| App                    | Class                         | Size                                | Notes                           |
| ---------------------- | ----------------------------- | ----------------------------------- | ------------------------------- |
| KeePassXC              | `org.keepassxc.KeePassXC`     | `1450 850`                          | Was in registry, not in prod    |
| FreeDownloadManager    | `org.kde.freedownloadmanager` | `1280 720`                          | Tagged `kt` in registry         |
| DMS                    | `com.danklinux.dms`           | `(monitor_w*0.50) (monitor_h*0.55)` | Tagged `dms` in registry        |
| feh                    | `[fF]eh`                      | (none, just tag)                    | Tagged `feh` in registry        |
| xdg-desktop-portal-gtk | `xdg-desktop-portal-gtk`      | `1680 1080`                         | Tagged `portal_xdg` in registry |

**TODO: [missing] : Add KeePassXC, FreeDownloadManager, DMS, feh, xdg-desktop-portal-gtk to float_center.lua or appropriate file**

### 1b. special_float missing entries

The registry `M.special_float` had these that are NOT in prod:

| Name                       | Match                                        | Effects                | Notes                                                          |
| -------------------------- | -------------------------------------------- | ---------------------- | -------------------------------------------------------------- |
| center-wezterm             | class `org.wezfurlong.wezterm`               | center, size 2280x1000 | NOT in misc_rules                                              |
| float-webapp-manager-title | class `webapp-manager.py` + title `Web Apps` | float, size 1000x650   | Partially covered by float_center but title match is different |

**TODO: [missing] : Add wezterm center rule to misc_rules.lua**
**TODO: [missing] : Add webapp-manager title-specific rule (float_center covers class but not title)**

### 1c. tags missing entries

The registry `M.tags` had these that are NOT in tag_effects or individual files:

| App            | Tag                                  | Workspace  | Notes                                         |
| -------------- | ------------------------------------ | ---------- | --------------------------------------------- |
| Spotify        | `[sS]potify`                         | `8 silent` | Was in `M.workspace` (no tag, just workspace) |
| Docker Desktop | `Docker Desktop`                     | `7 silent` | Was in `M.workspace`                          |
| Telegram/QQ    | `QQ\|Telegram\|org.telegram.desktop` | `6 silent` | Was in `M.workspace`                          |
| Signal         | `[sS]ignal`                          | `6 silent` | Was in `M.workspace`                          |
| Vivaldi Webapp | `vivaldi-.*-[dD]efault`              | (none)     | Tag `vivaldiWebapp` -- was in `M.tags`        |

**TODO: [missing] : Add Spotify workspace rule (workspace 8 silent, maximize, persist)**
**TODO: [missing] : Add Docker Desktop workspace rule (workspace 7 silent, no_initial_focus, persist)**
**TODO: [missing] : Add Telegram/QQ workspace rule (workspace 6 silent, size 1000x900, center, no_initial_focus, persist, opacity)**
**TODO: [missing] : Add Signal workspace rule (workspace 6 silent, size 1600x1250, center, float=false, no_initial_focus, persist)**
**TODO: [missing] : Add Vivaldi Webapp tag rule (class vivaldi-.\*-[dD]efault, tag vivaldiWebapp, persist, opacity, float)**

### 1d. Special float entries already added by user

These were already added to misc_rules.lua by the user:

- `float-showmethekey` -- DONE
- `float-media-players` -- DONE

---

## Section 2: MISSING from PROD (were in .prev but NOT in registry)

These were individual .prev files that had no equivalent in the registry and are NOT in prod.

| .prev File          | Rules                                                                 | Status                               |
| ------------------- | --------------------------------------------------------------------- | ------------------------------------ |
| calendly.lua        | 2 rules (tag vivaldi-webapp-calendly, float tagged)                   | LOST -- not in registry or prod      |
| davinici-panels.lua | 3 rules (tag, tagged, float tagged)                                   | LOST -- not in registry or prod      |
| kt.lua              | 3 rules (tag kitty, float tagged, float tagged no-border)             | LOST -- not in registry or prod      |
| thunderbird.lua     | 5 rules (tag write, workspace, tagged write, workspace, float tagged) | DISABLED in registry (commented out) |
| webapp-grok.lua     | 2 rules (tag vivaldi-webapp-grok, vivaldi-webapp-grok)                | LOST -- not in registry or prod      |

**TODO: [missing] : Review calendly rules -- were they intentional?**
**TODO: [missing] : Review davinici-panels rules -- were they intentional?**
**TODO: [missing] : Review kitty (kt) rules -- were they intentional?**
**TODO: [missing] : Review thunderbird rules -- was intentionally disabled in registry, confirm still wanted**
**TODO: [missing] : Review webapp-grok rules -- were they intentional?**

---

## Section 3: BROUGHT FROM a_yoinked.lua (UNREVIEWED)

The `a_yoinked.lua` file contained rules that were added without full review.
Some have been added to prod, some haven't. Items marked `[yoinked]` need review.

### 3a. Already in prod (reviewed or partially reviewed)

| Rule                                                    | File              | Status               |
| ------------------------------------------------------- | ----------------- | -------------------- |
| File dialog floats (Open File, Select a File, etc.)     | title_dialogs.lua | In prod              |
| Screen sharing (float, pin, position)                   | misc_rules.lua    | In prod              |
| Tearing (wine, minecraft, steam_app)                    | misc_rules.lua    | In prod              |
| KDE floats (plasmawindowed, kcm, bluedevilwizard, etc.) | misc_rules.lua    | In prod              |
| Zotero                                                  | misc_rules.lua    | In prod              |
| PiP                                                     | pip.lua           | In prod              |
| showmethekey                                            | misc_rules.lua    | In prod (user added) |
| media-players                                           | misc_rules.lua    | In prod (user added) |

### 3b. BROKE CONFIG -- removed/commented

| Rule                                     | Issue                                                                  | Status                                                             |
| ---------------------------------------- | ---------------------------------------------------------------------- | ------------------------------------------------------------------ |
| `namespace = "gtk4-layer-shell"` no_anim | Broke config. In misc_rules.lua but `no_anim = true` is commented out. | Commented out -- needs decision: keep rule body or delete entirely |

**TODO: [yoinked] : Decide on gtk4-layer-shell rule -- delete entirely or fix and re-enable?**

### 3c. In a_yoinked but NOT in prod (unreviewed)

| Rule                                   | Match                                  | Effects                                                 | Notes                                                                                                |
| -------------------------------------- | -------------------------------------- | ------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| Choose wallpaper size                  | title `^(Choose wallpaper)(.*)$`       | size `(monitor_w*0.60) (monitor_h*0.65)`                | title_dialogs has float+center but NOT size                                                          |
| pavucontrol (duplicate)                | class `^(pavucontrol)$`                | float, center, size                                     | float_center has pavucontrol but class is `org.pulseaudio.pavucontrol` -- this is the old class name |
| org.pulseaudio.pavucontrol (duplicate) | class `^(org.pulseaudio.pavucontrol)$` | float, center, size                                     | float_center already covers this                                                                     |
| nm-connection-editor size              | class `^(nm-connection-editor)$`       | float, center, size `(monitor_w*0.45) (monitor_h*0.45)` | misc_rules has this -- already covered                                                               |

**TODO: [yoinked] : Review Choose wallpaper size rule -- add size to title_dialogs?**
**TODO: [yoinked] : Review pavucontrol old class name -- keep both class patterns or just new one?**

---

## Section 4: RULES IN PROD -- verification checklist

### 4a. globals.lua -- OK

- suppress-event (maximize) -- from registry
- no-floating-border -- from a_yoinked

### 4b. float_center.lua -- PARTIAL

Present: blueman, pavucontrol, qalculate, qt5ct, appimagelauncher, swappy, keymapp, webapp-manager, WebApp-.*, zmk-studio, viewnior
Missing: keepassxc, freedownloadmanager, dms, feh, xdg-desktop-portal-gtk, waypaper, solaar, polychromatic, limo, zathura

**TODO: [missing] : Add missing float_center entries from registry**

### 4c. tag_effects.lua -- PARTIAL

Present: discord, affine, qBittorrent, ytm, ueberzugpp, rimworld, zen
Missing: spotify (workspace only), docker (workspace only), telegram (workspace only), signal (workspace only), vivaldi-webapp

**TODO: [missing] : Add missing workspace-only apps to tag_effects or create workspace_effects.lua**

### 4d. misc_rules.lua -- MOSTLY OK

Present: file-managers, screen-share, tearing, KDE floats, zotero, blueberry, guifetch, nm-editor, showmethekey, media-players
Needs review: gtk4-layer-shell (commented out)
Missing: wezterm center rule

**TODO: [missing] : Add wezterm center rule**
**TODO: [yoinked] : Resolve gtk4-layer-shell rule**

### 4e. popups.lua -- OK

Portals, polkit, pinentry, polkit stay_focused -- all present

### 4f. pip.lua -- OK

PiP rules from a_yoinked -- all present

### 4g. steam.lua -- OK

All 10 rules present (5 tag + 5 effect)

### 4h. vivaldi.lua -- OK

All 11 rules present

### 4i. jetbrains.lua -- OK

All 5 rules present (including 3 workaround rules)

### 4j. alecaframe.lua -- OK

All 6 rules present

### 4k. chromium.lua -- OK

All 4 rules present

### 4l. obsidian.lua -- OK

All 4 rules present

### 4m. zed.lua -- OK

All 4 rules present

### 4n. ghostty.lua -- OK

All 2 rules present

### 4o. code.lua -- OK

1 rule present

---

## Section 5: SUMMARY -- items to action

### High priority (missing from prod, were actively running)

1. **Spotify** -- workspace 8 silent, maximize, persist
2. **Docker Desktop** -- workspace 7 silent, no_initial_focus, persist
3. **Telegram/QQ** -- workspace 6 silent, size 1000x900, center, no_initial_focus, persist, opacity
4. **Signal** -- workspace 6 silent, size 1600x1250, center, float=false, no_initial_focus, persist
5. **KeePassXC** -- float center, size 1450x850
6. **wezterm** -- center, size 2280x1000
7. **Vivaldi Webapp** -- tag vivaldiWebapp, persist, opacity, float

### Medium priority (were in registry, may be intentional drops)

1. **FreeDownloadManager** -- float, size 1280x720, tag kt
2. **DMS** -- float, size monitor-relative, tag dms
3. **feh** -- just tag feh (no effects)
4. **xdg-desktop-portal-gtk** -- float, size 1680x1080, tag portal_xdg
5. **waypaper** -- float, size 1450x1000, persist
6. **solaar** -- float, size 1000x650, subs (Solaar Rule Editor 600x500)
7. **polychromatic** -- float, size 1050x950, opacity, subs (Device Information 200x400)
8. **limo** -- float, size 600x900, subs (Install Mod 800x600)
9. **zathura** -- float, size 1100x1300, opacity

### Low priority (lost .prev files, need review)

 1. **calendly** -- vivaldi webapp calendly rules
 2. **davinici-panels** -- DaVinci Control Panels Setup rules
 3. **kitty** -- tag, float, no-border rules
 4. **thunderbird** -- intentionally disabled in registry
 5. **webapp-grok** -- vivaldi webapp grok rules

### To decide

 1. **gtk4-layer-shell** -- delete entirely or fix?
 2. **Choose wallpaper size** -- add size to title_dialogs?
 3. **pavucontrol old class** -- keep both class patterns?
