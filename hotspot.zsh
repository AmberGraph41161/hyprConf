#!/bin/zsh

ifname="$(nmcli -t dev | fuzzel --dmenu -p'ifname > ' | awk -F':' '{ print $1 }')"
ssid=$HOST
conName=$HOST

if [ "$(echo "hostname\ncustom" | fuzzel --dmenu -p'ssid/con-name > ')" = "custom" ]; then
	ssid="$(fuzzel --dmenu --prompt-only='ssid > ')"
	conName="$(fuzzel --dmenu --prompt-only='con-name > ')"
fi

password="$(fuzzel --dmenu --password --prompt-only='password > ')"

nmcli dev wifi hotspot ifname "$ifname" ssid "$ssid" con-name "$conName"
