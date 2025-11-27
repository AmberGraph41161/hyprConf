#!/bin/zsh

choices="small\nmedium\nlarge"

case $(echo $choices | fuzzel -p"mpddisplaycoverart > " --dmenu) in

	"small")
		hyprctl 'dispatch exec [float; size 160 90; move 100 100]' -- imv -w"mpddisplaycoverart.zsh" /tmp/mpd_cover.jpg
		;;
	"medium")
		hyprctl 'dispatch exec [float; size 480 270; move 100 100]' -- imv -w"mpddisplaycoverart.zsh" /tmp/mpd_cover.jpg
		;;

	"large")
		hyprctl 'dispatch exec [float; size 800 450; move 100 100]' -- imv -w"mpddisplaycoverart.zsh" /tmp/mpd_cover.jpg
		;;

	(*)
	#small
		hyprctl 'dispatch exec [float; size 160 90; move 100 100]' -- imv -w"mpddisplaycoverart.zsh" /tmp/mpd_cover.jpg
		;;
esac
