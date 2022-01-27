#!/usr/bin/env bash

echo "ArchLinux semi-automatic installation script"

echo "Setting up pacman.conf"
sed -i "s/#Parallel/Parallel/g; s/#Color/Color/g" /etc/pacman.conf

printf "Hostname: "
read -r NEW_HOSTNAME

printf "Username: "
read -r NEW_USER

printf "Password: "
read -rs PASSWD
echo

printf "Password again: "
read -rs CONF_PASSWD
echo

if [ "$PASSWD" != "$CONF_PASSWD" ]; then
    echo "Password not aligned!"
    exit 1
fi

lsblk
echo

printf "Drive to format: "
read -r DRIVE

echo
echo "[0] Server  - TTY"
echo "[1] Desktop - KDE"
printf "Select a profile to install [0-1]: "
read -r PROFILE_TO_USE

set TEMPLATE
if [ "$PROFILE_TO_USE" == "0" ]; then
    TEMPLATE=archinstall-server.template.json
elif [ "$PROFILE_TO_USE" == "1" ]; then
    TEMPLATE=archinstall-kde.template.json
else
    echo "Not supported profile"
    exit 1
fi

sed "s/\$USER/$NEW_USER/g; s/\$PASSWORD/$PASSWD/g; s/\$HOSTNAME/$NEW_HOSTNAME/g; s|\$DRIVE|$DRIVE|g; s/\$SIZE/$SIZE/g" \
    $TEMPLATE > archinstall.json

echo
printf "Modify the config? [y/N]: "
read -r MODIFY

if [ "$MODIFY" == "y" ] || [ "$MODIFY" == "Y" ] || [ "$MODIFY" == "yes" ] || [ "$MODIFY" == "Yes" ]; then
    $EDITOR archinstall.json
fi

printf "Proceed to install? [Y/n]: "
read -r RUN_INSTALL

if [ "$RUN_INSTALL" == "n" ] || [ "$RUN_INSTALL" == "N" ] || [ "$RUN_INSTALL" == "no" ] || [ "$RUN_INSTALL" == "No" ]; then
    echo "Exiting, your config:"
    cat archinstall.json
    rm archinstall.json
    exit 0
fi

archinstall --config archinstall.json
