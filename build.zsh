#!/usr/bin/env zsh

# penguin build script

# custom pacman conf must include penguin repo
#build_cfg="/etc/aurutils/pacman-chroot.conf"
# 
# output directory
#out_db="penguin"
#out_dir="/path/to/output/"
# 
# publish?
#publish=false
# 
# webhost login
#ssh_user="username"
#ssh_host="example.com"
#
# remote directory
#remote_dir="/path/to/www/"

. BUILD_VARS || exit 1

function main() {
  if test -n $@ && test -d $1
  then
    echo "build package: ${1:t}"
    confirm || exit 1
    cd $1 || return 1
    test -f .git && submodule_update
    build_package
    cd .. || return 1
  else
    echo "build all packages"
    confirm || exit 1
    for d in */PKGBUILD
    do
      cd ${d:h} || return 1
      test -f .git && submodule_update
      build_package
      cd .. || return 1
    done
  fi

  [[ $publish == true ]] || return
  echo "publish packages"
  cd $out_dir && echo $(pwd)
  if _push_repo
  then
    _sync_remote
  fi
}

function submodule_update() { git submodule update --init }

function build_package() {
  updpkgsums || return 1
  makepkg --printsrcinfo > .SRCINFO || return 2
  aur build \
    -d $out_db \
    --root=$out_dir \
    --pacman-conf $build_cfg \
    --chroot --force --no-sync \
    || return 3
}

function _push_repo() {
  git add .
  git commit -m "Build $(date)"
  git push
}

function _sync_remote() {
  ssh -t $ssh_user@$ssh_host \
    "cd $remote_dir; sudo git pull"
}

function confirm() {
  vared -cp "Confirm (y/n)? " ans
  [[ "$ans" =~ ^[Yy]$ ]] || return 1
}

main $@

exit 0

# vim: ft=zsh tw=2 sw=2 et ai:
