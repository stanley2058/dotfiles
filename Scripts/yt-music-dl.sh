#!/bin/bash

echo Start downloding...
for url; do
    echo
    echo === Downloading: $url ===
    echo
    yt-dlp -o '%(title)s.%(ext)s' -x --audio-format "mp3" $url
done
echo Fin.
