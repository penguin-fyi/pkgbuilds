#!/usr/bin/env zsh
# penguin build script

# The pacman.conf file used inside the container
#build_cfg="$(pwd)/pacman-chroot.conf"
# 
# The local repo name and path
#out_db="custom"
#out_dir="$HOME/Packages"
# 
# Publish repo on remote server?
#publish=false
# 
# Remote server SSH credentials (only key auth supported)
#ssh_user="username"
#ssh_host="example.com"
#
# Path to repo on remote host
#remote_dir="/path/to/www/"

# Load BUILD_VARS or else
. $(pwd)/BUILD_VARS || exit 1

function main() {
  local complete=false

  if test -n $@ && test -d $1
  then
    build_single $1 && complete=true
  elif test -z $@
  then
    build_all && complete=true
  else
    usage && exit 1
  fi

  if [[ $complete == true ]] && [[ $publish == true ]]
  then
    cd $out_dir || return 1
    _push_to_repo && _sync_remote
  fi
}

function build_single() {
  local pkgdir=$1

  echo "Building package: ${pkgdir:t}"
  confirm || exit 1

  cd $pkgdir || { echo "Invalid path: $pkgdir"; exit 1 }
  build_package

  cd .. || return 1
}

function build_all() {
  echo "build all"
  local pkgdir

  echo "Building all packages!"
  confirm || exit 1

  for pkgdir in */PKGBUILD
  do
    echo "Building package: ${pkgdir:t}"

    cd $pkgdir || { echo "Invalid path: $pkgdir"; exit 1 }
    build_package

    cd .. || return 1
  done
}

function build_package() {

  [[ is_pkgbuild ]] \
    || { echo "PKGBUILD not found! Aborting!"; exit 1 }

  [[ is_submodule ]] \
    && { echo "Submodule found! Updating!"; update_submodule }

  [[ update_pkgsums ]] \
    || { echo "Failed to update checksums! Aborting!"; exit 1 }

  [[ update_srcinfo ]] \
    || { echo "Failed to update .SRCINFO! Aborting!"; exit 1 }

  aur build \
    -d $out_db \
    --root=$out_dir \
    --pacman-conf $build_cfg \
    --chroot --force --no-sync \
    --margs -s -r -c\
    || { echo "Failed to build '${$(pwd):t}'! Aborting!"; exit 1 }
}

function is_submodule() { test -f .git || return 1 }

function update_submodule() { git submodule update --init --recursive || return 1 }

function is_pkgbuild() { test -f PKGBUILD || return 1 }

function update_pkgsums() { updpkgsums || return 1 }

function update_srcinfo() { makepkg --printsrcinfo > .SRCINFO || return 1 }

function _push_to_repo() {
  local message="Build $(date)"
  git add . || return 1
  git commit -m $message || return 2
  git push || return 3
}

function _sync_remote() {
  ssh -t $ssh_user@$ssh_host \
    "cd $remote_dir; sudo git pull" \
    || { echo "Failed to sync remote repo!"; exit 1 }
}

function confirm() {
  vared -cp "Confirm (y/n)? " ans
  [[ "$ans" =~ ^[Yy]$ ]] || return 1
}

function usage() {
  echo "Usage: build.zsh [<PATH>]"
}

main $@

echo "Done"
exit 0

# vim: ft=zsh ts=2 sw=0 et:
