#!/bin/zsh

notificationlifetime=5000
notificationid=100000000

connectionInfo="$(nmcli -t -g 'bssid, band, bars, ssid, security' -e no -m multiline dev wifi \
	 | paste - - - - - \
	 | grep 'WPA2 802.1X' \
	 | sed 's/BAND:5 GHz/BAND:5 GHz  /; s/\sSECURITY:WPA2 802.1X$//' \
	 | fuzzel --dmenu)"

connection_name="$(echo $connectionInfo | sed 's/.*\sSSID:\(.*\)$/\1/')"
connection_bssid="$(echo $connectionInfo | sed 's/BSSID:\([0-9A-Z:]\+\)\s.*/\1/')"

if [ -z "$connection_name" -o -z "$connection_bssid" ]; then
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

if ! nmcli connection add type wifi \
	con-name "$connection_name" \
	ifname wlp1s0 \
	ssid "$connection_name" \
	802-11-wireless.bssid "$connection_bssid" \
	-- \
	wifi-sec.key-mgmt wpa-eap \
	802-1x.eap peap \
	802-1x.phase2-auth mschapv2 \
	802-1x.identity "$username" \
	802-1x.password "$password"; then
	notify-send "FAILED TO ADD NEW CONNECTION TO NMCLI:" "ssid: $connection_name\nbssid: $connection_bssid" -u normal -t $notificationlifetime -r $notificationid
else
	notify-send "SUCCESSFULLY ADDED NEW CONNECTION TO NMCLI:" "ssid: $connection_name\nbssd: $connection_bssid" -u normal -t $notificationlifetime -r $notificationid
fi
