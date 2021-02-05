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

Extends Arch `base` with bootloader, networking, and shell tools. Does not include kernel, microcode, or video drivers.

### Depends
* base
* curl
* efibootmgr
* fail2ban
* git
* gnupg
* grub
* linux-firmware
* man-db
* man-pages
* networkmanager
* openssh
* pass
* patch
* pwgen
* reflector
* sudo
* tlp
* tmux
* ufw
* unzip
* vi
* vim
* w3m
* zip
* zsh

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
* alacritty
* awesome-git ***!!***
* awesome-freedesktop-git ***!!***
* blueman
* fontconfig
* dex
* feh
* ffmpeg
* gvfs
* htop
* imagemagick
* lightdm
* lightdm-gtk-greeter
* lightdm-gtk-greeter-settings
* light-locker
* lxappearance-gtk3
* mailcap
* mpc
* mpd
* mpv
* ncmpcpp
* neomutt
* netsurf
* network-manager-applet
* newsboat
* numlockx
* pasystray
* pavucontrol
* pcmanfm-gtk3
* picom
* polkit-gnome
* pulseaudio
* pulseaudio-alsa
* qt5ct
* qt5-styleplugins ***!!***
* qutebrowser
* ranger
* rofi
* tuir ***!!***
* unclutter-xfixes-git ***!!***
* urlscan
* weechat
* xarchiver
* xclip
* xdg-user-dirs
* xdg-utils
* xfce4-power-manager
* xorg-server
* xorg-xset
* xorg-xsetroot
* xorg-xrdb
* xorg-xrandr
* xorg-xdpyinfo
* xterm
* zathura
* zathura-pdf-mupdf

### Services
* lightdm

### Autostart
* numlockx
* pcmanfm
* picom
* polkit-gnome
* unclutter
* xdg-user-dirs


## penguin-desktop-scripts

Provides extra tools and custom scripts for Penguin Desktop

### Depends
* maim
* mpnotd-zsh ***!***
* clipmenu
* rofi-calc
* rofi-pass
* walsh ***!***

### Opt Depends
* cava ***!!***
* aurutils ***!!***

### Autostart
* update-notify

### Scripts
* usr/bin/update-notify
* usr/bin/screen-capture
* usr/bin/touchpad-toggle


## penguin-desktop-themes

Provides Antsy artwork

### Depends
* antsy-gtk-theme ***!***
* antsy-icon-theme ***!***
* antsy-wallpaper ***!***
* nerd-fonts-hack *!**!***
* noto-fonts-emoji
* xcursor-neutral

