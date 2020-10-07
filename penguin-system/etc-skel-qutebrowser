# qutebrowser/config.py

import subprocess


# Xresources colors
def read_xresources(prefix):
    props = {}
    x = subprocess.run(["xrdb", "-query"], stdout=subprocess.PIPE)
    lines = x.stdout.decode().split("\n")

    for line in filter(lambda l: l.startswith(prefix), lines):
        prop, _, value = line.partition(":\t")
        props[prop] = value

    return props


xres = read_xresources("*")

c.url.start_pages = ["https://start.duckduckgo.com/"]
c.url.default_page = "about:blank"
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "d": "https://duckduckgo.com/?q={}",
    "g": "https://www.google.com/search?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
}
c.confirm_quit = ["downloads"]
c.auto_save.session = False
c.hints.mode = "letter"
c.window.title_format = "{perc}{current_title}"
c.completion.height = "30%"
c.colors.webpage.bg = xres["*color7"]
c.hints.border = "0px solid " + xres["*color0"]

c.colors.completion.category.bg = xres["*color0"]
c.colors.completion.category.border.bottom = xres["*color8"]
c.colors.completion.category.border.top = xres["*color0"]
c.colors.completion.category.fg = xres["*color15"]
c.colors.completion.even.bg = xres["*color0"]
c.colors.completion.fg = xres["*color7"]
c.colors.completion.item.selected.bg = xres["*color12"]
c.colors.completion.item.selected.border.bottom = xres["*color0"]
c.colors.completion.item.selected.border.top = xres["*color0"]
c.colors.completion.item.selected.fg = xres["*color0"]
c.colors.completion.match.fg = xres["*color11"]
c.colors.completion.odd.bg = xres["*color0"]
c.colors.completion.scrollbar.bg = xres["*color0"]
c.colors.completion.scrollbar.fg = xres["*color8"]

c.colors.downloads.bar.bg = xres["*color0"]
c.colors.downloads.error.bg = xres["*color9"]
c.colors.downloads.error.fg = xres["*color0"]
c.colors.downloads.start.bg = xres["*color14"]
c.colors.downloads.start.fg = xres["*color0"]
c.colors.downloads.stop.bg = xres["*color10"]
c.colors.downloads.stop.fg = xres["*color0"]
c.colors.downloads.system.bg = "none"
c.colors.downloads.system.fg = "none"

c.colors.hints.bg = "rgba(0, 0, 0, 90%)"
c.colors.hints.fg = xres["*color15"]
c.colors.hints.match.fg = xres["*color14"]

c.colors.keyhint.bg = "rgba(0, 0, 0, 90%)"
c.colors.keyhint.fg = xres["*color15"]
c.colors.keyhint.suffix.fg = xres["*color11"]

c.colors.messages.error.bg = xres["*color9"]
c.colors.messages.error.border = xres["*color0"]
c.colors.messages.error.fg = xres["*color0"]
c.colors.messages.info.bg = xres["*color14"]
c.colors.messages.info.border = xres["*color0"]
c.colors.messages.info.fg = xres["*color0"]
c.colors.messages.warning.bg = xres["*color11"]
c.colors.messages.warning.border = xres["*color0"]
c.colors.messages.warning.fg = xres["*color0"]

c.colors.prompts.bg = xres["*color0"]
c.colors.prompts.border = "1px solid " + xres["*color8"]
c.colors.prompts.fg = xres["*color7"]
c.colors.prompts.selected.bg = xres["*color12"]

c.colors.statusbar.caret.bg = xres["*color14"]
c.colors.statusbar.caret.fg = xres["*color0"]
c.colors.statusbar.caret.selection.bg = xres["*color14"]
c.colors.statusbar.caret.selection.fg = xres["*color0"]
c.colors.statusbar.command.bg = xres["*color0"]
c.colors.statusbar.command.fg = xres["*color7"]
c.colors.statusbar.command.private.bg = xres["*color8"]
c.colors.statusbar.command.private.fg = xres["*color0"]
c.colors.statusbar.insert.bg = xres["*color15"]
c.colors.statusbar.insert.fg = xres["*color0"]
c.colors.statusbar.normal.bg = xres["*color0"]
c.colors.statusbar.normal.fg = xres["*color7"]
c.colors.statusbar.passthrough.bg = xres["*color14"]
c.colors.statusbar.passthrough.fg = xres["*color0"]
c.colors.statusbar.private.bg = xres["*color8"]
c.colors.statusbar.private.fg = xres["*color0"]
c.colors.statusbar.progress.bg = xres["*color10"]
c.colors.statusbar.url.error.fg = xres["*color9"]
c.colors.statusbar.url.fg = xres["*color7"]
c.colors.statusbar.url.hover.fg = xres["*color14"]
c.colors.statusbar.url.success.http.fg = xres["*color7"]
c.colors.statusbar.url.success.https.fg = xres["*color10"]
c.colors.statusbar.url.warn.fg = xres["*color9"]

c.colors.tabs.bar.bg = xres["*color0"]
c.colors.tabs.even.bg = xres["*color0"]
c.colors.tabs.even.fg = xres["*color7"]
c.colors.tabs.indicator.error = xres["*color9"]
c.colors.tabs.indicator.start = xres["*color10"]
c.colors.tabs.indicator.stop = xres["*color10"]
c.colors.tabs.indicator.system = "none"
c.colors.tabs.odd.bg = xres["*color0"]
c.colors.tabs.odd.fg = xres["*color7"]
c.colors.tabs.selected.even.bg = xres["*color12"]
c.colors.tabs.selected.even.fg = xres["*color0"]
c.colors.tabs.selected.odd.bg = xres["*color12"]
c.colors.tabs.selected.odd.fg = xres["*color0"]

c.fonts.completion.category = "bold 10pt monospace"
c.fonts.completion.entry = "10pt monospace"
c.fonts.debug_console = "10pt monospace"
c.fonts.downloads = "10pt monospace"
c.fonts.hints = "bold 12pt monospace"
c.fonts.keyhint = "10pt monospace"
c.fonts.messages.error = "bold 10pt monospace"
c.fonts.messages.info = "bold 10pt monospace"
c.fonts.messages.warning = "bold 10pt monospace"
c.fonts.default_family = "Hack Nerd Font Mono"
c.fonts.prompts = "10pt monospace"
c.fonts.statusbar = "10pt monospace"

c.tabs.show = "multiple"
c.downloads.position = "bottom"


# vim: set ft=python :
