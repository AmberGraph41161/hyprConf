#!/bin/zsh

thisWindow="$(hyprctl clients | \
	grep -P 'initialClass:|initialTitle:|pid:' | \
	sed 's/[\t ]\+//g' | \
	paste -d ' ' - - - | \
	fuzzel --dmenu -p'grabwindow > ' | \
	sed 's/.*pid://')"

activeWorkspace="$(hyprctl activeworkspace -j | \
	grep '"id": ' | \
	sed 's/.*\([0-9]\+\).*/\1/')"

hyprctl 'dispatch movetoworkspace' "$activeWorkspace,pid:$thisWindow"
