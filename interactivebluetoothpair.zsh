#!/bin/zsh

# meant to only be called from bluetoothprompt.zsh, from 'alacritty -e' so that this isnt headless

retryAfterSeconds=5
counter=0

{
	echo 'agent KeyboardDisplay'
	echo 'default-agent'
	sleep 1
	echo 'trust' "$1"
	sleep 1
	echo 'pair' "$1"
	sleep 1
	echo 'connect' "$1"
				sleep 1
	while true; do
		if [ -n "$(echo 'devices Paired' | bluetoothctl | grep 'Device' | awk '{ print $2 }' | grep ""$1"")" ] && \
			[ -n "$(echo 'info '$1 | bluetoothctl | grep 'Bonded: yes')" ] && \
			[ -n "$(echo 'info '$1 | bluetoothctl | grep 'Connected: yes')" ]; then
			exit
		else
			((counter++))
			if ((counter >= retryAfterSeconds)); then
				((counter=0))
				echo 'trust' "$1"
				sleep 1
				echo 'pair' "$1"
				sleep 1
				echo 'connect' "$1"
			fi
		fi
	done
} | bluetoothctl
