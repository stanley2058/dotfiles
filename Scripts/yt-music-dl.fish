#!/usr/bin/fish

echo Start downloading...
for url in $argv;
    echo
    echo === Downloading: $url ===
    echo
    youtube-dl -o '%(title)s.%(ext)s' -x --audio-format "mp3" $url
end
echo Fin.
