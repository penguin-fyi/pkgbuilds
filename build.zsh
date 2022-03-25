#!/usr/bin/env zsh

# penguin-desktop build script

set -e

# internal vars
declare complete=false
declare publish=false

# load BUILD_VARS or else
. $(pwd)/BUILD_VARS \
  || { echo "BUILD_VARS not found!"; exit 1 }

# check for PKGBUILD, git pull, updpkgsums, and SRCINFO
function prepare() {
  local pkg=$1

  echo "Preparing '$pkg'..."

  cd $pkg \
    || { echo "Invalid path '$pkg'! Aborting!"; return 1 }

  test -f PKGBUILD \
    || { echo "PKGBUILD not found! Aborting!"; return 1 }

  test -d .git \
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

  prepare $pkg || return 1

  cd $pkg || return 1

  GPGKEY=$gpg_key \
  aur build \
    -d $out_db \
    --root=$out_dir \
    --pacman-conf $build_cfg \
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
  cat $pkglist || return 1
  confirm || exit 1

  while read pkg
  do
    prepare $pkg
  done < $pkglist

  GPGKEY=$gpg_key \
  aur build \
    --arg-file=$pkglist \
    --database $out_db \
    --root=$out_dir \
    --pacman-conf $build_cfg \
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
    || { echo "Failed to build list '${pkglist:t}'! Aborting!"; exit 1 }

  complete=true
}

# build package lists ($build_lists array must be defined)
function build_all() {
  local list

  echo "Building package lists: $build_lists"
  for list in $build_lists
  do
    test -f $list.txt || { echo "Could not locate $list.txt!"; break }
    build_list $list.txt
  done

  return
}

# fetch list of PKGBUILDs from AUR
function fetch_aur() {
  while IFS= read -r line; do
    if [ -d $line ]
    then
      echo "Path '$line' exists! Skipping!"
    else
      echo "Fetching '$line'..."
      git clone $aur_url/$line \
        || { echo "Failed to fetch '$line'! Aborting!"; return 1 }
    fi
  done < $1
}

# publish repo
function upload() {
  rsync -auv \
    $out_dir/ \
    $publish_login:$publish_dir \
    || { echo "Failed to sync remote repo!"; exit 1 }
}

# yes or no dialog
function confirm() {
  vared -cp "Confirm (y/N)? " ans
  [[ "$ans" =~ ^[Yy]$ ]] || return 1
}

# help
function usage() {
  echo "Usage: ${ZSH_ARGZERO:t} [-o <DIR>|-l <FILE>|-a|-f [<FILE>]|-h]"
  echo
  echo "arguments: (one required)"
  echo "  -p, --pkg <DIR>       build single package"
  echo "  -l, --list <FILE>     list of packages to build"
  echo "  -a, --all             build all package lists"
  echo "  -f, --fetch [<FILE>]  fetch PKGBUILDs in list from AUR"
  echo "  -h, --help            show this help message and quit"
  echo
}

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
      build_package $2 \
        || { echo "Error: $?"; exit 1 }
      break;;
    -l | --list)
      test -f $2 \
        || { echo "invalid file: $2"; exit 1 }
      build_list $2 \
        || { echo "Error: $?"; exit 1 }
      break;;
    -a | --all)
      (( ${+build_lists} )) \
        || { echo "'build_lists' not defined!"; exit 1 }
      build_all \
        || { echo "Error: $?"; exit 1 }
      break;;
    -f | --fetch)
      list=$aur_list
      [[ -n $2 && -f $2 ]] \
        && list=$2
      fetch_aur $list \
        || { echo "Error: $?"; exit 1 }
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
  #cd $out_dir || return 1
  upload || return 1
fi

echo "Done"

exit 0

# vim: ft=zsh ts=2 sw=2 et ai:
