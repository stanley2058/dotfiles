#!/usr/bin/env bash

distro=Linux

if [ -f "/etc/os-release" ]; then
    source /etc/os-release
    distro="$NAME"
fi

case "$distro" in
    "Arch Linux") echo ""
        ;;
    "Manjaro") echo ""
        ;;
    "Ubuntu") echo ""
        ;;
    "Fedora") echo ""
        ;;
    "Debian") echo ""
        ;;
    *) echo ""
        ;;
esac

