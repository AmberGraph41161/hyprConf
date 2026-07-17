#!/bin/zsh

ifname="$(nmcli -t dev | fuzzel --dmenu -p'ifname > ' | awk -F':' '{ print $1 }')"
[ -z "$ifname" ] && exit

case "$(echo -e 'hostname\ncustom' | fuzzel --dmenu -p'ssid/con-name > ')" in

	"custom")
		ssid="$(fuzzel --dmenu --prompt-only='ssid > ')"
		conName="$(fuzzel --dmenu --prompt-only='con-name > ')"
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

nmcli dev wifi hotspot ifname "$ifname" ssid "$ssid" con-name "$conName"
