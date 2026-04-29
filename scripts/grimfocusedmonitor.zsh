#!/bin/zsh

monitortoscreenshot="$(hyprctl monitors all | grep -P 'focused: yes|Monitor' | grep -B1 'focused: yes' | sed '2,2d' | awk '{ print $2 }')"
grim -o "$monitortoscreenshot" - | satty -f - --copy-command "wl-copy" --early-exit --disable-notifications
