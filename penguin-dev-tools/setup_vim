#!/usr/bin/env zsh

# install pathogen and plugins
src_url="https://git.linuxit.us/spider/vim"
tpo_url="https://tpo.pe/pathogen.vim"

# install to
dest_dir="$HOME/.vim"

# plugins
plugin_lst="$dest_dir/plugins.txt"

# check for git
if ! command -v git &>/dev/null
then
  echo "Could not locate 'git' command!"
  exit 1
fi

echo "Installing zsh setup..."
echo "Source: $src_url"
echo "Target: $dest_dir"

read -s -k "?Press any key continue" && echo

# clone repo
if test -d $dest_dir
then
  echo "Target '$dest_dir' already exists!"
  exit 1
else
  if git clone $src_url $dest_dir
  then
    echo "Cloned repo to $dest_dir"
  else
    echo "Failed to clone repo!"
    exit 1
  fi
fi

local old_rc="$HOME/.vimrc"
if test -L $old_rc
then
  echo "Target '$old_rc' is symlink!"
  echo "Removing symlink!"
  rm $conf
fi

if test -f $old_rc
then
  echo "Target '$old_rc' already exists!"
  echo "Created backup '$old_rc.bak'!"
  mv -b $old_rc $old_rc.backup
fi

unset old_rc

echo "Installing Pathogen..."
local bundle_dir="$dest_dir/bundle"
local autoload_dir="$dest_dir/autoload"
mkdir -p $autoload_dir $bundle_dir 2>/dev/null
if ! curl -LSso $autoload_dir/$(basename "$tpo_url") $tpo_url
then
  echo "Failed to install Pathogen!"
  exit 1
fi

# get plugins
if test -f $plugin_lst
then
  mkdir -p $dest_dir/bundle &>/dev/null

  echo "Reading plugin list..."
  typeset -A plugins
  while read name url
  do
    plugins[$name]="$url"
  done < $plugin_lst
  unset name url

  echo "Fetching plugins..."
  for dest url in ${(kv)plugins}
  do
    dest="$dest_dir/bundle/$dest"
    if ! test -d $dest
    then
      git clone $url $dest
    fi
  done
  unset dest url
fi

echo "Done!"
exit 0

# vim: ft=zsh ts=2 sw=2 et:
