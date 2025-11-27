#!/bin/zsh

wallpaperDirectory="$HOME/wallpapers/main"

wallpaperTransition="any"

if [ ! -e $HOME/.config/hypr/scripts/resources/lastrandomwallpaper.txt ]; then
	echo "initial file creation dummy text" > $HOME/.config/hypr/scripts/resources/lastrandomwallpaper.txt
fi

while
do
	wallpaper="$(find $wallpaperDirectory -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' \) | shuf | sed '2,$d')"

	if [ "$wallpaper" != "$(cat $HOME/.config/hypr/scripts/resources/lastrandomwallpaper.txt)" ]; then
		echo $wallpaper > $HOME/.config/hypr/scripts/resources/lastrandomwallpaper.txt
		break;
	fi
done

swww img --resize crop --fill-color 000000 --transition-step 255 --transition-duration 2 --transition-fps 255 --transition-type "$wallpaperTransition" "$wallpaper"
