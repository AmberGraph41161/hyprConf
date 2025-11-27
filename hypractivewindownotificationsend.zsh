#!/bin/zsh

notificationlifetime=2000
notificationid=100000000

hypractivewindowinfo=$(hyprctl 'activewindow')

notify-send "hypractivewindow" "$hypractivewindowinfo" -u normal -t $notificationlifetime -r $notificationid
