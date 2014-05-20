#!/bin/bash -e
home="$(dirname "$(readlink -f "$0")")"

if [ $# -gt 2 ]; then
  echo "$0 [output image] [base image]" >&2
  echo >&2
  echo "  if no base image is given, this is assumed to be a self-hosting build" >&2
  echo "  (the output image name is used as base image name)" >&2
  exit 1
fi

output="$1"
[ -n "$output" ] || output="arch"
base="$2"
[ -n "$base" ] || base="$output"

source "$home/docker.sh"

tmp="$(mktemp)"
trap "{ rm -rf $tmp; }" EXIT

$docker run --rm -v "$tmp:/root.tar:rw" -v "$home/cache:/var/cache/pacman:rw" -v "$home:/bootstrap:ro" --privileged arch /bootstrap/pacstrap.sh /root.tar
$docker import - "$output" < "$tmp"
