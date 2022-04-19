#!/usr/bin/env bash

distro=Linux
logo=""

if [ -f "/etc/os-release" ]; then
    source /etc/os-release
    distro="$NAME"
fi

case "$distro" in
    "Arch Linux")   logo="\033[34m\033[0m"
        ;;
    "Manjaro")      logo="\033[32m\033[0m"
        ;;
    "Ubuntu")       logo="\033[31m\033[0m"
        ;;
    "Fedora Linux") logo="\033[34m\033[0m"
        ;;
    "Debian")       logo="\033[32m\033[0m"
        ;;
esac

echo -e $logo
