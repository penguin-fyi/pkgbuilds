## penguin-base

Extends Arch `base` with bootloader, networking, and shell tools.

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
* etc/default/grub
* etc/issue
* etc/pacman.conf
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

