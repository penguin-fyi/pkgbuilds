# pkgbuilds

[PKGBUILD](https://wiki.archlinux.org/title/PKGBUILD)s for [**PENGUIN**](https://penguin.fyi)


## Dependencies

- `aurutils`: `aur build` is used to build packages in clean chroot ([AUR](https://aur.archlinux.org/aurutils))
- `git`: clone and update PKGBUILD repositories
- `pacman-contrib`: update checksums
- `sed`: patching PKGBUILDs
- `rsync`: publish package repository to remote host
- `zsh`: this script was written in `zshell`


## Building

First, clone the repository and setup `BUILD_VARS`:
```sh
git clone https://github.com/penguin-fyi/pkgbuilds
cd pkgbuilds
cp BUILD_VARS.example BUILD_VARS
$EDITOR BUILD_VARS
```

To build single package:
```sh
./build.zsh --pkg <dir>

```

To fetch PKGBUILDs in `packages-aur.txt` (or provided file):
```sh
./build.zsh --fetch [<file>]
```

To build PKGBUILDs from a list:
```sh
./build.zsh --list <file>
```

To build a set of lists
```sh
# set $build_lists in BUILD_VARS
./build.zsh --all
```


## Notes

- Packages in the lists (`packages-*.txt`) are\\should be arranged in the order they are needed to be built.
