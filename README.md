# pkgbuilds

PKGBUILDs for [***Penguin***](https://penguin.fyi) and dependencies from [AUR](https://aur.archlinux.org)

## Building Penguin
```sh
# clone repo
git clone https://git.linuxit.us/penguin/pkgbuilds
cd pkgbuilds

# edit options (required)
head -20 build.zsh >! BUILD_VARS
vim BUILD_VARS

# build everything
./build.zsh

# or to build single package
./build.zsh <path>
```
