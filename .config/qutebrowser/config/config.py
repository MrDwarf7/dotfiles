import subprocess
import os
from urllib.request import urlopen

# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401

# pylint: disable=C0111
config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103
c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103

c.colors.statusbar.normal.bg = "#00000000"
c.colors.statusbar.command.bg = "#00000000"

# c.url.start_pages = ""
# c.url.default_page = ""

c.tabs.title.format = "{audio}{current_title}"
c.fonts.web.size.default = 20

# c.hints.mode = ""


c.scrolling.smooth = False  # smooth scrolling -- NOTE smooth scrolling does not work with the :scroll-px command.
# c.scroll_px = 100


c.url.default_page = "https://www.google.com"
c.url.start_pages = ["https://www.google.com/"]
# c.url.default_page = "about:blank"

c.content.javascript.clipboard = "access-paste"

c.url.searchengines = {
    # note - if you use duckduckgo, you can make use of its built in bangs, of which there are many! https://duckduckgo.com/bangs
    # "DEFAULT": "https://duckduckgo.com/?q={}",
    "DEFAULT": "https://www.google.com/?q={}",
    "!g": "https://www.google.com/search?q={}",
    "!aw": "https://wiki.archlinux.org/?search={}",
    "!apkg": "https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=",
    "!gh": "https://github.com/search?o=desc&q={}&s=stars",
    "!yt": "https://www.youtube.com/results?search_query={}",
    "!drs": "https://docs.rs/releases/search?query={}",
    "!crates": "https://crates.io/search?q={}",
}

c.completion.shrink = True

c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "bookmarks",
    "history",
    "filesystem",
]
c.editor.command = ["neovide", '+"normal! {line}G{column}|"', "{file}"]
# ["neovide", "+'{line}G{column}|'", "{file}"]


config.load_autoconfig(False)

c.auto_save.session = True


if os.path.exists(config.configdir / "binds.py"):
    config.source(str(config.configdir / "binds.py"))


def add_to_sorted_lst(ext_list, new_vals):
    return sorted(ext_list + new_vals)


c.input.insert_mode.auto_load = True

config.set("input.insert_mode.leave_on_load", True, "https://github.com")


# additional_zoom_levels = [105, 115, 120, 130, 135, 140, 145]
# new_list = add_to_sorted_lst(c.zoom.levels, additional_zoom_levels)
# c.zoom.levels = new_list

c.zoom.levels = [
    25,
    33,
    50,
    67,
    75,
    90,
    100,
    110,
    120,
    130,
    140,
    150,
    160,
    170,
    180,
    190,
    200,
    210,
    220,
    250,
    300,
    350,
    400,
    450,
    500,
]
# Darkmode settings
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.policy.images = "never"
config.set("colors.webpage.darkmode.enabled", False, "file://*")


# Styles/cosmetic

if not os.path.exists(config.configdir / "theme.py"):
    theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
    with urlopen(theme) as themehtml:
        with open(config.configdir / "theme.py", "a") as file:
            file.writelines(themehtml.read().decode("utf-8"))

if os.path.exists(config.configdir / "theme.py"):
    import theme

    theme.setup(c, "macchiato", False)


c.tabs.position = "left"
c.tabs.padding = {"top": 4, "bottom": 4, "left": 9, "right": 9}
c.tabs.indicator.width = 2  # tab indicators (little line thing)
c.tabs.width = "10%"


# Fonts
c.fonts.default_family = []
c.fonts.default_size = "12pt"
c.fonts.hints = "bold 14pt monospace"  # hint size / hint font
c.fonts.web.family.fixed = "monospace"
c.fonts.web.family.sans_serif = "monospace"
c.fonts.web.family.serif = "monospace"
c.fonts.web.family.standard = "monospace"


# Privacy
c.completion.cmd_history_max_items = 1
# config.set("completion.cmd_history_max_items", 1)
c.content.private_browsing = False
# config.set("content.private_browsing", True)

config.set("content.webgl", False, "*")
c.content.canvas_reading = False
# config.set("content.canvas_reading", False)
c.content.geolocation = False
# config.set("content.geolocation", False)
c.content.webrtc_ip_handling_policy = "default-public-interface-only"
# config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
c.content.cookies.accept = "all"
# config.set("content.cookies.accept", "all")
# c.content.cookies.store = True
config.set("content.cookies.store", True)
c.content.javascript.enabled = True
# config.set("content.javascript.enabled", True)  #### Setup keybinds

c.content.blocking.enabled = True
c.content.blocking.method = "adblock"

c.content.blocking.adblock.lists = [
    # "https://github.com/ewpratten/youtube_ad_blocklist/blob/master/blocklist.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2025.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",
]
