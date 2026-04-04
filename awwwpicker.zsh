#!/bin/zsh

wallpaperDirectories=(
	"~/.config/wallpapers/main"
	"~/.config/wallpapers/Garry"
	"~/.config/wallpapers/gifs"
	"~/.config/wallpapers/wallhaven"
)

searchThisDirectory=$(printf "%s\n" "${wallpaperDirectories[@]}" | fuzzel --dmenu -p"pick directory > ")

if [ "$(echo $searchThisDirectory | sed 's/~\/.config\/wallpapers\/.*/YESWEARESEARCHINGTHEWALLPAPERSDIRECTORYANDNOTSOMEWHERERANDOM/')" != 'YESWEARESEARCHINGTHEWALLPAPERSDIRECTORYANDNOTSOMEWHERERANDOM' ]; then
	exit
fi

foundImages=$(find ${searchThisDirectory/#\~/$HOME} -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \))

useThisImage=$(echo ${foundImages//$HOME/\~} | fuzzel --dmenu -p"choose image > ")

if [ -z "$useThisImage" ]; then
	exit
fi

awww img --resize crop --fill-color 000000 --transition-type \
	$(echo 'none\nsimple\nfade\nleft\nright\ntop\nbottom\nwipe\nwave\ngrow\ncenter\nany\nouter\nrandom' | \
	fuzzel --dmenu -p"transition type > ") "${useThisImage/#\~/$HOME}"
