#!/usr/bin/env bash

distro=Linux
logo=""
prefix=

if [ -f "/etc/os-release" ]; then
    source /etc/os-release
    distro="$NAME"
fi

# check if is a ssh session
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    prefix="\033[93m撚\033[0m"
fi

case "$distro" in
    "Arch Linux")   logo="\033[34m\033[0m"
        ;;
    "Manjaro")      logo="\033[32m\033[0m"
        ;;
    "Ubuntu")       logo="\033[31m\033[0m"
        ;;
    "Fedora")       logo="\033[34m\033[0m"
        ;;
    "Debian")       logo="\033[32m\033[0m"
        ;;
esac

echo -e $prefix$logo
