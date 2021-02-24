# pkgbuilds

PKGBUILDs for [***Penguin***](https://penguin.fyi) and dependencies from [AUR](https://aur.archlinux.org)

## Building Penguin
```sh
# clone repo
git clone https://git.linuxit.us/penguin/pkgbuilds
cd pkgbuilds

# edit options (required)
head -24 build.zsh | tail -n 20 >! BUILD_VARS
vim BUILD_VARS

# build single package
./build.zsh -p <dir>

# build from list
./build.zsh -l <file>

# build a set of lists
# set $build_lists in BUILD_VARS
./build.zsh --all

```
