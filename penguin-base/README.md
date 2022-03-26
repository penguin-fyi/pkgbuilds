## penguin-base

Extends Arch `base` with bootloader, networking, and shell tools.

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
* sudo
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
* etc/default/useradd
* etc/makepkg.conf
* etc/pacman.conf

### Hooks
* usr/share/libaplm/hooks/90-penguin-config-patch.hook

### Scripts
* usr/share/libaplm/scipts/penguin-config-patch

### Services
* NetworkManager
* sshd
* ufw
* fstrim

