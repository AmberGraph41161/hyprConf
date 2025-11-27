#!/bin/zsh

# meant to only be called from bluetoothprompt.zsh, from 'alacritty -e' so that this isnt headless

{
	echo 'agent KeyboardDisplay'
	echo 'default-agent'
	sleep 1
	echo 'trust' "$1"
	sleep 1
	echo 'pair' "$1"
	while true; do
		if [ -n "$(bluetoothctl devices Paired | awk '{ print $2 }' | grep ""$1"")" ] && [ -n "$(bluetoothctl info $1 | grep 'Bonded: yes')" ]; then
			break;
		else
			sleep 1
		fi
	done
} | bluetoothctl
