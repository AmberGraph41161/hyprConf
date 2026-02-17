#!/bin/zsh

connection_name="$(nmcli dev wifi | sed '1,1d; s/........//' | awk '{ print $8, $1, $2 }' | fuzzel --dmenu -p'connection name > ')"
if [ -z "$connection_name" ]; then
	exit
fi

username="$(fuzzel --dmenu -p'username > ')"
if [ -z "$username" ]; then
	exit
fi

password="$(fuzzel --dmenu --password -p'password > ')"
if [ -z "$password" ]; then
	exit
fi

nmcli connection add type wifi con-name $connection_name ifname wlp1s0 ssid $connection_name -- wifi-sec.key-mgmt wpa-eap 802-1x.eap peap 802-1x.phase2-auth mschapv2 802-1x.identity $username 802-1x.password $password
