#!/bin/zsh

cat "$HOME/.config/hypr/scripts/resources/asciiemojipickerlist.txt" | fuzzel --dmenu \
	| sed "s/\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\.\. .*//" | wl-copy
