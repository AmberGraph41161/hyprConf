#!/bin/zsh

wallpaperDirs=(
	"$HOME/.config/wallpapers/main"
	"$HOME/.config/wallpapers/Garry"
	"$HOME/.config/wallpapers/wallhaven"
)
wallpaperDir="$(printf "%s\n" "${wallpaperDirs[@]}" | fuzzel --dmenu -p'choose wallpaper dir > ')"
if [ -z "$wallpaperDir" ]; then
	exit
fi

case "$(echo 'choose\nimv' | fuzzel --dmenu -p'type > ')" in

	'choose')
		awww img --resize crop --transition-type none \
			"$(find $wallpaperDir -type f -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' | fuzzel --dmenu -p'choose > ')"
		;;
	'imv')
		walls=($(find $wallpaperDir -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) -printf '%p '))
		echo "${walls[@]}"
		while read -r wall; do
			awww img --resize crop --transition-type none "$wall" && \
			ln -sf "$wall" "$HOME/.config/hypr/resources/currentwallpaper"
		done < <(imv "${walls[@]}")
		;;
esac
