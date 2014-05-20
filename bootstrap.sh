#!/bin/bash -e
home="$(dirname "$(readlink -f "$0")")"

output="$1"
[ -n "$output" ] || output="arch"

source "$home/docker.sh"

tmp="$(mktemp)"
trap "{ rm -f $tmp; }" EXIT
"$home/pacstrap.sh" "$tmp"
$docker import - "$output" < "$tmp"
