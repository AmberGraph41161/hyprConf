#!/bin/zsh

notificationid=100000000
notificationlifetime=10000

ifname="$(nmcli -t dev | fuzzel --dmenu -p'ifname > ' | awk -F':' '{ print $1 }')"
[ -z "$ifname" ] && exit

case "$(echo -e 'hostname\ncustom' | fuzzel --dmenu -p'ssid/con-name > ')" in

	"custom")
		ssid="$(fuzzel --dmenu --prompt-only='ssid > ')"
		[ -z "$ssid" ] && exit
		conName="$(fuzzel --dmenu --prompt-only='con-name > ')"
		[ -z "$conName" ] && exit
		;;
	"hostname")
		ssid=$HOST
		conName=$HOST
		;;
	*)
		exit
esac

password="$(fuzzel --dmenu --password --prompt-only='password > ')"
[ -z "$password" ] && exit

output=$(nmcli dev wifi hotspot ifname "$ifname" ssid "$ssid" con-name "$conName" 2>&1)
((? == 0)) \
	&& notify-send 'HOTSPOT UP' "$output" -u normal -t $notificationlifetime -r $notificationid \
	|| notify-send 'HOTSPOT FAILED' "$output" -u critical -t $notificationlifetime -r $notificationid
