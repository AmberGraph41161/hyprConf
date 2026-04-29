#!/bin/zsh

windows=$(hyprctl 'clients' \
| grep -B2 --no-group-separator "pid:" \
| sed "s/\t//g; /^initialClass: \$/d; /^initialTitle: \$/d; /^pid: -1\$/d" \
| paste -d " " - - - \
| sort -n \
| sed "s/^/ /g" \
| grep -n "^");

thiswindow=$(echo $windows \
| fuzzel -p "SuperAltTab > " --dmenu \
| grep -o "pid:.*\$" \
| sed "s/ //g");

hyprctl 'dispatch focuswindow' "$(echo $thiswindow)"
hyprctl 'dispatch bringactivetotop'
hyprctl 'dispatch focuswindow' "$(echo $thiswindow)"
