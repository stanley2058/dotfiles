#!/usr/bin/env fish

if [ "$argv[1]" = "-h" ]; or [ -z "$argv[1]" ]; or [ -z "$argv[2]" ]; or [ -z "$argv[3]" ]
    echo -e 'Usage: ./yt-music-dl-single.fish <URL> <Title> <Artist> [<isCover>]'
else
    echo "Downloading..."
    set album $argv[2]
    set artist $argv[3]
    set title "$album - $artist"
    if [ $argv[4] ]
        set title "$album (covered by $artist)"
    end

    set downloaded (youtube-dl --get-filename -o '%(title)s.%(ext)s' -x --audio-format "mp3" $argv[1])
    set downloaded (string replace -r '\.[^.]+$' '.mp3' "$downloaded")
    echo $downloaded
    youtube-dl -o '%(title)s.%(ext)s' -x --audio-format "mp3" $argv[1]

    ffmpeg -i "$downloaded" \
        -metadata title="$title" \
        -metadata artist="$artist" \
        -metadata album="$album" \
        -codec copy "$title.mp3"
    rm -f "$downloaded"
end
