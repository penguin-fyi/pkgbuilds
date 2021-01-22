# penguin-system

This is a split `PKGBUILD` for building the Penguin Desktop.

*Please note*: we do not provide a kernel, video driver, or microcode!

```
pacstrap /mnt penguin-defaults linux vulkan-radeon amd-ucode
```


* [penguin-base](#penguin-base) - base system
* [penguin-desktop](#penguin-desktop) - desktop packages
* [penguin-themes](#penguin-themes) - Antsy artwork
* [penguin-scripts](#penguin-scripts) - custom scripts
* [penguin-defaults](#penguin-defaults) - default configs
* [penguin-dev-tools](#penguin-dev-tools) - extra tools

***!*** indicates core packages
***!!*** indicates packages sourced from [AUR](https://aur.archlinux.org)

## penguin-base

Extends Arch `base` with bootloader, networking, and shell tools

### Depends
* base
* linux-firmware
* tlp
* grub
* efibootmgr
* networkmanager
* openssh
* ufw
* fail2ban
* reflector
* zsh
* vim
* curl
* tmux
* w3m
* git
* patch
* sudo
* man-db
* man-pages

### Configs
* etc/sudoers.d/10-wheel

### Patches
* etc/default/grub
* etc/issue
* etc/makepkg.conf
* etc/pacman.conf
* etc/xdg/reflector/reflector.conf
* etc/default/useradd

### Hooks
* usr/share/libaplm/hooks/90-penguin-config-patch.hook

### Scripts
* usr/share/libaplm/scipts/penguin-config-patch

### Services
* NetworkManager
* sshd
* ufw
* fstrim
* reflector


## penguin-desktop

Provides all desktop packages

### Depends
* penguin-base ***!***
* penguin-scripts ***!***
* xorg-server
* xorg-xset
* xorg-xsetroot
* xorg-xrdb
* xorg-xrandr
* xorg-xdpyinfo
* lightdm
* lightdm-gtk-greeter
* lightdm-gtk-greeter-settings
* light-locker
* awesome-git ***!!***
* awesome-freedesktop-git ***!!***
* dex
* xdg-user-dirs
* xdg-utils
* pcmanfm-gtk3
* gvfs
* xarchiver
* picom
* rofi
* rofi-pass
* xclip
* numlockx
* network-manager-applet
* blueman
* polkit-gnome
* xfce4-power-manager
* pulseaudio
* pulseaudio-alsa
* pavucontrol
* pasystray
* unclutter-xfixes-git ***!!***
* lxappearance-gtk3
* qt5ct
* qt5-styleplugins ***!!***
* fontconfig
* alacritty
* xterm
* ranger
* htop
* mailcap
* vivid
* qutebrowser
* netsurf
* weechat
* neomutt
* newsboat
* tuir ***!!***
* neofetch
* mpd
* mpc
* ncmpcpp
* mpv
* zathura
* zathura-pdf-mupdf
* feh
* ffmpeg
* imagemagick
* rsync
* urlscan
* maim
* vi
* bat
* jq
* fzf
* dialog
* fd
* tree
* unzip
* zip
* lsof
* pass
* pwgen
* gnupg

### Services
* lightdm

### Autostart
* numlockx
* pcmanfm
* picom
* polkit-gnome
* unclutter
* xdg-user-dirs


## penguin-themes

Provides Antsy artwork

### Depends
* antsy-gtk-theme ***!***
* antsy-icon-theme ***!***
* antsy-wallpaper ***!***
* xcursor-openzone ***!!***
* ttf-hack
* nerd-fonts-hack *!**!***
* noto-fonts-emoji


## penguin-scripts

Provides custom scripts for Penguin Desktop

### Depends
* maim

### Opt Depends
* cava ***!!***
* aurutils ***!!***

### Autostart
* mpd-notifications
* update-notify
* wallpaper-shuffler

### Scripts
* usr/bin/mpd-notifications.fyi
* usr/bin/update-notify.fyi
* usr/bin/wallpaper-shuffler.fyi
* usr/bin/screen-capture.fyi
* usr/bin/touchpad-toggle.fyi


## penguin-defaults

Provides full Penguin Desktop with custom default configuration

### Depends
* penguin-desktop ***!***
* penguin-themes ***!***
* zsh-autosuggestions
* zsh-completions
* zsh-syntax-highlighting
* bash-completion

### Configs
* etc/skel/.config/alacritty/alacritty.yml
* etc/skel/.config/awesome/rc.lua
* etc/skel/.config/awesome/themes/antsy/theme.lua
* etc/skel/.gtkrc-2.0
* etc/skel/.config/gtk-3.0/settings.ini
* etc/skel/.config/picom/picom.conf
* etc/skel/.config/pcmanfm/default/pcmanfm.conf
* etc/skel/.config/qutebrowser/config.py
* etc/skel/.config/qt5ct/qt5ct.conf
* etc/skel/.config/rofi/config.rasi
* etc/skel/.config/rofi/themes/antsy.rasi
* etc/skel/.tmux.conf
* etc/skel/.vim/vimrc
* etc/skel/.Xresources
* etc/skel/.xsession
* etc/skel/.zshrc
* etc/skel/.zshrc.prompt

### Patches
* etc/lightdm/lightdm-gtk-greeter.conf


## penguin-dev-tools

Extra tools for hacking Penguin

### Depends
* archiso
* autopep8
* cmake
* ctags
* eslint
* flake8
* gitea-tea ***!!***
* github-cli
* ipython
* luacheck ***!!***
* oomox ***!!***
* pacman-contrib
* pacutils
* python-black
* python-isort
* python-pyflakes
* python-virtualenv
* python-virtualenvwrapper
* shellcheck-bin ***!!***
* yapf

