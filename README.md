# Arch Linux on Docker

  This is a set of scripts to build yourself an Arch Linux image to use with Docker.
  By default, they build a Docker image called `arch`.

## build.sh \[image name\] \[base image\]

  Builds a fresh Docker image inside a container. This requires an Arch base image.
  Unless you pass one on the command line, the base image is assumed to have the same name as the image you're building.
  If you don't want to bootstrap from the host, you might want to use `nathan7/arch` as your base image.

## bootstrap.sh \[image name\]

  Builds a fresh Docker image on the host. The host needs to be running Arch.

