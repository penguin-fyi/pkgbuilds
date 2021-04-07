#!/usr/bin/env zsh

# penguin build script

# put these options in ./BUILD_VARS and uncomment as needed
# repo name (required)
#out_db="custom"
# repo path (required)
#out_dir="$HOME/Packages"
# repo architecture (required)
#out_dir="x86_64"
# pacman conf (required)
#build_cfg="$(pwd)/pacman-chroot.conf"
# build lists (required for --all, order matters)
#build_lists=('packages-aur' 'packages-core' 'packages-custom')
# GPG key to sign packages (required)
#gpg_key="<key>
# push and sync packages (required)
#publish=false
# webhost user (optional)
#ssh_user="username"
# webhost server (optional)
#ssh_host="example.com"
# webhost path (optional)
#remote_dir="/path/to/www/"

set -e

# load BUILD_VARS or else
. $(pwd)/BUILD_VARS \
  || { echo "BUILD_VARS not found!"; exit 1 }

# check for PKGBUILD, git pull, updpkgsums, and SRCINFO
function prepare() {
  local pkg=$1

  echo "Preparing '$pkg'..."

  cd $pkg || return 1

  test -f PKGBUILD \
    || { echo "PKGBUILD not found! Aborting!"; return 1 }

  test -f .git \
    && { echo "Updating PKGBUILD..."; git pull }

  updpkgsums \
    || { echo "Failed to update checksums! Aborting!"; return 1 }

  makepkg --printsrcinfo >! .SRCINFO \
    || { echo "Failed to update .SRCINFO! Aborting!"; return 1 }

  cd .. || return 1

  return
}

# build single package
function build_package() {
  local pkg=$1

  echo "Building package: ${pkg:t}"
  confirm || exit 1

  # prep pkg
  prepare $pkg

  cd $pkg || return 1

  # build
  GPGKEY=$gpg_key \
  aur build \
    -d $out_db \
    --root=$out_dir/$out_arch \
    --pacman-conf $pacman_cfg \
    --chroot \
    --temp \
    --gpg-sign \
    --force \
    --namcap \
    --checkpkg \
    --margs \
      --noconfirm \
      --syncdeps \
      --rmdeps \
      --verify \
      --clean \
      --log \
    || { echo "Failed to build '${pkg:t}'! Aborting!"; exit 1 }

  cd .. || return 1
  complete=true
}

# build from list of packages
function build_list() {
  local pkglist=$1
  local pkg

  echo "Building package list: ${pkglist:t}"
  cat $pkglist
  confirm || exit 1

  # prep pkgs in list
  while read pkg
  do
    prepare $pkg
  done < $pkglist

  # build list
  GPGKEY=$gpg_key \
  aur build \
    --arg-file=$pkglist \
    --database $out_db \
    --root=$out_dir/$out_arch \
    --pacman-conf $pacman_cfg \
    --chroot \
    --temp \
    --gpg-sign \
    --force \
    --namcap \
    --checkpkg \
    --margs \
      --noconfirm \
      --syncdeps \
      --rmdeps \
      --verify \
      --clean \
      --log \
    || { echo "Failed to build! Aborting!"; exit 1 }

  complete=true
}

# build from array of package lists
function build_all () {
  local list

  echo "Building package lists: $build_lists"
  for list in $build_lists
  do
    test -f $list.txt || { echo "could not locate $list.txt!"; return 1 }
    build_list $list.txt
  done

  return
}

# publish repo
function upload() {
  rsync -auv \
    $out_dir/ \
    $ssh_user@$ssh_host:$remote_dir \
    || { echo "Failed to sync remote repo!"; exit 1 }
}

# yes or no dialog
function confirm() {
  vared -cp "Confirm (y/N)? " ans
  [[ "$ans" =~ ^[Yy]$ ]] || return 1
}

# help
function usage() {
  echo "Usage: ${ZSH_ARGZERO:t} [-o <PATH>|-l <PATH>|-h]"
  echo
  echo "arguments: (one required)"
  echo "  -p, --pkg  <DIR>      build single package"
  echo "  -l, --list <FILE>     list of packages to build"
  echo "  -h, --help            show this help message and quit"
  echo
}

local complete=false

# need args
(( $# )) \
  || { echo "need arguments!"; usage; exit 1 }

# parse arguments
for arg in $@
do
  case $arg in
    -h | --help)
      usage
      exit 0;;
    -p | --pkg)
      test -d $2 \
        || { echo "invalid path: $2"; exit 1 }
      build_package $2
      break;;
    -l | --list)
      test -f $2 \
        || { echo "invalid file: $2"; exit 1 }
      build_list $2
      break;;
    -a | --all)
      (( ${+build_lists} )) \
        || { echo "'build_lists' not defined!"; exit 1 }
      build_all
      break;;
    * | ?)
      echo "unknown argument: $1"
      usage
      exit 1;;
  esac
done

# publish packages
if [[ $complete == true ]] && [[ $publish == true ]]
then
  echo "Publishing builds..."
  cd $out_dir || return 1
  upload || return 1
fi

echo "Done"

exit 0

# vim: ft=zsh ts=2 sw=2 et ai:
