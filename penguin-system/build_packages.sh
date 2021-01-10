#!/usr/bin/env bash

echo "### running $0"

out_dir=$HOME/Projects/penguin-repo
echo "### checking ${out_dir}"
mkdir -p "${out_dir}" || exit 1

echo "### update sums"
updpkgsums || exit 1

echo "### update SRCINFO"
makepkg --printsrcinfo > .SRCINFO || exit 1

echo "### build packages"
makepkg -srcf || exit 1

echo "### move packages"
#mv -v \
mv \
    ./*.zst \
    "${out_dir}" \
    || exit 1

echo "### move to ${out_dir}"
cd "${out_dir}" || exit 1

echo "### update repo"
repo-add -R \
    penguin.db.tar \
    ./*.zst \
    || exit 1

echo "### upload packages"
scp \
    ./*.zst penguin.db.tar penguin.files.tar \
    spider@penguin.fyi:penguin-repo/ \
    || exit 1

echo "### complete!"
exit 0
