#!/bin/zsh

notificationlifetime=5000
notificationid=100000000

connection_name="$(nmcli -t -g 'bars, bssid, ssid' -e no -m multiline dev wifi | paste - - - \
	| fuzzel --dmenu -p'connection name > ' \
	| sed 's/.*\tSSID://')"
if [ -z "$connection_name" ]; then
	exit
fi

username="$(fuzzel --dmenu --prompt-only='username > ')"
if [ -z "$username" ]; then
	exit
fi

password="$(fuzzel --dmenu --password --prompt-only='password > ')"
if [ -z "$password" ]; then
	exit
fi

if ! nmcli connection add type wifi con-name $connection_name ifname wlp1s0 ssid $connection_name -- wifi-sec.key-mgmt wpa-eap 802-1x.eap peap 802-1x.phase2-auth mschapv2 802-1x.identity $username 802-1x.password $password; then
	notify-send "FAILED TO ADD CONNECT TO:" "$connection_name" -u normal -t $notificationlifetime -r $notificationid
else
	notify-send "SUCCESSFULLY CONNECTED TO:" "$connection_name" -u normal -t $notificationlifetime -r $notificationid
fi
