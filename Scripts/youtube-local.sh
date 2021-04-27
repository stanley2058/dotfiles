#!/usr/bin/env bash

PLAYER=
URL=
CHAT_FLAG=
DRY_RUN=
WATCH_URL=

for arg in "$@"; do
    if [ "$arg" == "-c" ] || [ $arg == "--chat" ]; then CHAT_FLAG="1"; fi
    if [ "$arg" == "-d" ] || [ $arg == "--dry-run" ]; then DRY_RUN="1"; fi
    if [[ $arg == "http"* ]]; then URL=$arg; fi
    if [ $arg == "--player="* ]; then
        PLAYER=${arg/--player=/}
    fi
    if [ "$arg" == "-h" ] || [ $arg == "--help" ]; then
        echo -e "\033[1myoutube-local.sh\033[0m"
        echo -e "\033[32m  -c, --chat   \033[36m\tStart chat in browser.\033[0m"
        echo -e "\033[32m  --player= \033[36m\tSet media player. (eg. --player=mpv)\033[0m"
        echo -e "\033[32m  -d, --dry-run\033[36m\tDry run, display extra messages, won't start anything.\033[0m"
        echo -e "\033[32m  -h, --help   \033[36m\tDisplay this message.\033[0m"
        exit 0
    fi
done


if [ -z $PLAYER ]; then
    if [ -f $(which vlc) ]; then
        PLAYER=vlc
    elif [ -f $(which smplayer) ]; then
        PLAYER=smplayer
    elif [ -f $(which mpv) ]; then
        echo MPV
        PLAYER=mpv
    fi
fi

if [[ $URL == *"watch?v="* ]]; then
    WATCH_URL=$(echo $URL | grep -o 'watch?v=.*&')
    if [ -z $WATCH_URL ]; then
        WATCH_URL=$(echo $URL | grep -o 'watch?v=.*$')
    fi
    WATCH_URL=${WATCH_URL/watch?v=/}
    WATCH_URL=${WATCH_URL%&}
elif [[ $URL == *"youtu.be"* ]]; then
    WATCH_URL=$(echo $URL | grep -o "/[^/]*$")
    WATCH_URL=${WATCH_URL:1}
else
    echo -e "\033[1;31mError parsing url.\033[0m"
    exit 1
fi

echo -e "Using \033[1;32m$PLAYER\033[0m to open \033[1;34mhttps://youtu.be/$WATCH_URL\033[0m"
if [ ! -z "$CHAT_FLAG" ]; then
    if [ -z "$DRY_RUN" ]; then
        xdg-open "https://www.youtube.com/live_chat?v=$WATCH_URL"
    else
        echo -e "\033[32mChat URL: \033[36mhttps://www.youtube.com/live_chat?v=$WATCH_URL\033[0m"
    fi
fi

if [ -z "$DRY_RUN" ]; then
    exec $PLAYER "https://youtu.be/$WATCH_URL" > /dev/null &
    disown
else
    echo -e "\033[32mStream URL: \033[36mhttps://youtu.be/$WATCH_URL\033[0m"
fi

