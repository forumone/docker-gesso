#!/usr/bin/env sh
LINUX_DISTRO=alpine
if [[ $1 == 5 ]]; then
  LINUX_DISTRO=debian
fi

echo $LINUX_DISTRO
