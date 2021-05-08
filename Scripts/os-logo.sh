#!/usr/bin/env bash

distro=Linux

if [ -f "/etc/os-release" ]; then
    source /etc/os-release
    distro="$NAME"
fi

case "$distro" in
    "Arch Linux") echo -e "\033[34m\033[0m"
        ;;
    "Manjaro") echo -e "\033[32m\033[0m"
        ;;
    "Ubuntu") echo -e "\033[31m\033[0m"
        ;;
    "Fedora") echo -e "\033[34m\033[0m"
        ;;
    "Debian") echo -e "\033[32m\033[0m"
        ;;
    *) echo -e ""
        ;;
esac

