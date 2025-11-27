#!/bin/zsh

cat "$HOME/.config/hypr/scripts/resources/symbolpickerlist.txt" | fuzzel --dmenu | sed "s/\s.*$//" | wl-copy -n
