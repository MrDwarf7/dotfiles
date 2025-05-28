# pylint: disable=C0111
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401

# pylint: disable=C0111
config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103
c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103


def bind_chained(key, *commands):
    config.bind(key, " ;; ".join(commands))


def alias_chained(key, *commands):
    c.aliases[key] = " ;; ".join(commands)


# Aliases
c.aliases["q"] = "tab-close"
c.aliases["wa"] = "session-save"
# c.aliases["ls"] = "cmd-set-text -s :session-load"
alias_chained("wq", "session-save", "tab-close")


# config.bind("<Ctrl+e>", ":cmd-run-with-count 1 scroll down")
# config.bind("<Ctrl+y>", ":cmd-run-with-count 1 scroll up")


config.bind("<Ctrl+y>", "scroll-px 0 -25")
config.bind("<Ctrl+e>", "scroll-px 0 25")

config.bind("k", "scroll-px 0 -150")
config.bind("j", "scroll-px 0 150")


config.bind("t", "cmd-set-text -s :open !g")
config.bind("T", "cmd-set-text -s :open -t !g ")

config.bind("o", "cmd-set-text :open {url:pretty}")
config.bind("O", "cmd-set-text :open -t -r {url:pretty}")
config.bind("<HOME>", ":home")
config.bind("<Ctrl+h>", "nop")
config.bind("<Ctrl+b>", ":bookmark-list")


config.bind("b", "cmd-set-text -sr :tab-focus")

config.bind("gs", "cmd-set-text -s :session-load")

config.bind("'", "cmd-set-text -s :quickmark-load")
config.bind('"', "cmd-set-text -s :quickmark-load -t")

config.bind("cs", "config-source")

config.bind("zi", "zoom-in")
config.bind("zo", "zoom-out")
config.bind("zz", "zoom 100%")
config.bind("zn", "clear-messages")
config.bind("cn", "clear-messages")


config.bind(">", "tab-move +")
config.bind("<", "tab-move -")


config.bind("K", "tab-prev")
config.bind("J", "tab-next")


config.bind("<Ctrl+Shift+Tab>", "tab-prev")
config.bind("<Ctrl+Tab>", "tab-next")


config.bind("yi", "tab-clone")
config.bind(":q", "tab-close")


config.bind("<Ctrl+o>", "back")
config.bind("<Ctrl+i>", "forward")


# keybinding changes
# config.bind('=', 'cmd-set-text -s :open')
# config.bind('h', 'history')
# config.bind("cs", "cmd-set-text -s :config-source")

# config.bind('tH', 'config-cycle tabs.show multiple never')
# config.bind('sH', 'config-cycle statusbar.show always never')
# config.bind('T', 'hint links tab')
# config.bind('pP', 'open -- {primary}')
# config.bind('pp', 'open -- {clipboard}')
# config.bind('pt', 'open -t -- {clipboard}')
# config.bind('qm', 'macro-record')
# config.bind('<ctrl-y>', 'spawn --userscript ytdl.sh')
# config.bind('tT', 'config-cycle tabs.position top left')
# config.bind('gJ', 'tab-move +')
# config.bind('gK', 'tab-move -')
# config.bind('gm', 'tab-move')


#### Original binds
# config.bind("tsh", "config-cycle -p -t -u *://{url:host}/* content.javascript.enabled ;; reload")
# config.bind("tSh", "config-cycle -p -u *://{url:host}/* content.javascript.enabled ;; reload")
# config.bind("tsH", "config-cycle -p -t -u *://*.{url:host}/* content.javascript.enabled ;; reload")
# config.bind("tSH", "config-cycle -p -u *://*.{url:host}/* content.javascript.enabled ;; reload")
# config.bind("tsu", "config-cycle -p -t -u {url} content.javascript.enabled ;; reload")
# config.bind("tSu", "config-cycle -p -u {url} content.javascript.enabled ;; reload")
# config.bind("tph", "config-cycle -p -t -u *://{url:host}/* content.plugins ;; reload")
# config.bind("tPh", "config-cycle -p -u *://{url:host}/* content.plugins ;; reload")
# config.bind("tpH", "config-cycle -p -t -u *://*.{url:host}/* content.plugins ;; reload")
# config.bind("tPH", "config-cycle -p -u *://*.{url:host}/* content.plugins ;; reload")
# config.bind("tpu", "config-cycle -p -t -u {url} content.plugins ;; reload")
# config.bind("tPu", "config-cycle -p -u {url} content.plugins ;; reload")
# config.bind("tih", "config-cycle -p -t -u *://{url:host}/* content.images ;; reload")
# config.bind("tIh", "config-cycle -p -u *://{url:host}/* content.images ;; reload")
# config.bind("tiH", "config-cycle -p -t -u *://*.{url:host}/* content.images ;; reload")
# config.bind("tIH", "config-cycle -p -u *://*.{url:host}/* content.images ;; reload")
# config.bind("tiu", "config-cycle -p -t -u {url} content.images ;; reload")
# config.bind("tIu", "config-cycle -p -u {url} content.images ;; reload")
# config.bind("tch", "config-cycle -p -t -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload")
# config.bind("tCh", "config-cycle -p -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload")
# config.bind("tcH", "config-cycle -p -t -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload")
# config.bind("tCH", "config-cycle -p -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload")
# config.bind("tcu", "config-cycle -p -t -u {url} content.cookies.accept all no-3rdparty never ;; reload")
# config.bind("tCu", "config-cycle -p -u {url} content.cookies.accept all no-3rdparty never ;; reload")
