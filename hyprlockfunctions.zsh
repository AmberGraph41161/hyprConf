#!/bin/zsh

pidof hyprlock && {
	case "$1" in
		"shutdown")
			shutdown now
			;;
		"suspend")
			systemctl suspend
			;;
	esac
}
