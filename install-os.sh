#!/usr/bin/env bash

sed -i "s/#Parallel/Parallel/g; s/#Color/Color/g" /etc/pacman.conf

printf "Hostname: "
read NEW_HOSTNAME

printf "Username: "
read NEW_USER

printf "Password: "
read -s PASSWD
echo

printf "Password again: "
read -s CONF_PASSWD
echo

if [ "$PASSWD" != "$CONF_PASSWD" ]; then
    echo "Password not aligned!"
    exit 1
fi

printf "Drive to format: "
read DRIVE

printf "Drive size: "
read SIZE

sed "s/\$USER/$NEW_USER/g; s/\$PASSWORD/$PASSWD/g; s/\$HOSTNAME/$NEW_HOSTNAME/g; s|\$DRIVE|$DRIVE|g; s/\$SIZE/$SIZE/g" \
    archinstall.template.json > archinstall.json

echo
printf "Modify the config? [y/N]: "
read MODIFY

if [ "$MODIFY" == "Y" ] || [ "$MODIFY" == "y" ] || [ "$MODIFY" == "yes" ] || [ "$MODIFY" == "Yes" ]; then
    $EDITOR archinstall.json
fi

printf "Proceed to install? [y/N]: "
read RUN_INSTALL

if [ "$RUN_INSTALL" == "Y" ] || [ "$RUN_INSTALL" == "y" ] || [ "$RUN_INSTALL" == "yes" ] || [ "$RUN_INSTALL" == "Yes" ]; then
    archinstall --config archinstall.json
else
    echo "Exiting, nothing has been installed."
    exit 1
fi