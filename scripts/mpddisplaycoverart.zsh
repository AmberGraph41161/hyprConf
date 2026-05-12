#!/bin/zsh

choices="small\nmedium\nlarge"

case $(echo $choices | fuzzel -p"mpddisplaycoverart > " --dmenu) in

	"small")
		hyprctl 'dispatch hl.exec_cmd("imv -w'"'$0'"' /tmp/mpd_cover.jpg", { float = true, size = { 160, 90 }, move = { 100, 100 } })'
		echo hyprctl 'dispatch hl.exec_cmd("imv -w'"$0"' /tmp/mpd_cover.jpg", { float = true, size = { 160, 90 }, move = { 100, 100 } })'
		;;
	"medium")
		hyprctl 'dispatch hl.exec_cmd("imv -w'"'$0'"' /tmp/mpd_cover.jpg", { float = true, size = { 480, 270 }, move = { 100, 100 } })'
		;;

	"large")
		hyprctl 'dispatch hl.exec_cmd("imv -w'"'$0'"' /tmp/mpd_cover.jpg", { float = true, size = { 800, 450 }, move = { 100, 100 } })'
		;;

	(*)
	#small
		hyprctl 'dispatch hl.exec_cmd("imv -w'"'$0'"' /tmp/mpd_cover.jpg", { float = true, size = { 160, 90 }, move = { 100, 100 } })'
		;;
esac
