#!/bin/sh

while read -r conf; do
    patch=/usr/share/penguin/patches/${conf##*/}.patch
    echo "$patch"
    if [ -e "$patch" ]; then
        if ! patch -d / -Rfp1 -i "$patch" --dry-run > /dev/null; then
            patch -d / -r - -Np1 -i "$patch"
        fi
    fi
done
