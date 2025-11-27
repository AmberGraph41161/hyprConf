#!/bin/zsh

defaultuntypablepicker='emojipicker.zsh'

if [ ! -z "$1" ]; then
	if [ -f "$HOME/.config/hypr/scripts/resources/untypablepickerlastchoice.txt" ]; then
		$HOME/.config/hypr/scripts/$(cat "$HOME/.config/hypr/scripts/resources/untypablepickerlastchoice.txt")
	else
		echo "$defaultuntypablepicker" > $HOME/.config/hypr/scripts/resources/untypablepickerlastchoice.txt
		$HOME/.config/hypr/scripts/"$defaultuntypablepicker"
	fi
	exit
fi

choice=\
$(echo -n "emojipicker.zsh\nkpicker.zsh\nsymbolpicker.zsh\nasciiemojipicker.zsh" \
| fuzzel -p "choose picker > " --dmenu)

if [ -z "$choice" ]; then
	choice="$defaultuntypablepicker"
fi

$HOME/.config/hypr/scripts/"$choice" && echo "$choice" > $HOME/.config/hypr/scripts/resources/untypablepickerlastchoice.txt
