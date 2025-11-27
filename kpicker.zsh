#!/bin/zsh

cat "$HOME/.config/hypr/scripts/resources/kpickerlist.txt" | fuzzel --dmenu | sed "s/|.*//" | wl-copy -n
