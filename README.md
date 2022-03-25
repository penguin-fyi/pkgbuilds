# pkgbuilds

PKGBUILDs for [***Penguin Desktop***](https://penguin.fyi)

## Building Penguin Desktop
```sh
# clone repo
git clone https://github.com/penguin-fyi/pkgbuilds
cd pkgbuilds

# fetch PKGBUILDs in packages-aur.txt (or provided file)
./build.zsh --fetch [<file>]

# build single package
./build.zsh --pkg <dir>

# build from list
./build.zsh --list <file>

# build a set of lists
# set $build_lists in BUILD_VARS
./build.zsh --all

```
