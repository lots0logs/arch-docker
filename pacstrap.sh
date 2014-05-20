#!/bin/bash -e
home="$(dirname "$(readlink -f "$0")")"

output="$1"
if [ $# -ne 1 ]; then
  echo "$0 [output file]" >&2
  exit 1
fi

[ "$(id -u)" = "0" ] || exec sudo "$0" $@

echo "installing arch-install-scripts" >&2
pacman -Sy --noconfirm --needed arch-install-scripts

echo "setting up environment" >&2

tmp="$(mktemp -d)"
mount -t tmpfs new_root "$tmp"
trap "{ cd /; umount -lf $tmp; }" EXIT

cd "$tmp"

echo "bootstrapping system" >&2
pacstrap -cC "$home/pacman.conf" .

echo "configuring timezone" >&2
ln -s /usr/share/zoneinfo/UTC ./etc/localtime

echo "generating locales" >&2
sed -i '/^#en_US/s/^#//' /etc/locale.gen
arch-chroot . locale-gen

echo "setting locales" >&2
echo 'LANG="en_US.UTF-8"' > ./etc/locale.conf

echo "packing up" >&2
tar c . > $output
