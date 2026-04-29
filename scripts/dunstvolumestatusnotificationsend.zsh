#!/bin/zsh

notificationlifetime=600
notificationid=100000000

#finished adding pamixer stuff and edits as of Friday, August 23, 2024, 17:10:16
pamixervolume=$(pamixer --sink @DEFAULT_SINK@ --get-volume)
pamixervolumestatus=$(pamixer --sink @DEFAULT_SINK@ --get-mute)

pamixermic=$(pamixer --default-source --get-volume)
pamixermicstatus=$(pamixer --default-source --get-mute)

pamixerdefaultsink=$(pamixer --get-default-sink)

pamixertotal="V: $pamixervolume% [mute: $pamixervolumestatus]\nM: $pamixermic% [mute: $pamixermicstatus]\n\n$pamixerdefaultsink"

if [ $pamixervolumestatus = "false" ]; then
	if [ $pamixervolume -ge 75 ]; then
		notify-send "Volume/Mic" "$pamixertotal" -u normal -t $notificationlifetime -r $notificationid -h int:value:$pamixervolume -i $HOME/.config/dunst/resources/icons/volume4.svg
	elif [ $pamixervolume -ge 50 ]; then
		notify-send "Volume/Mic" "$pamixertotal" -u normal -t $notificationlifetime -r $notificationid -h int:value:$pamixervolume -i $HOME/.config/dunst/resources/icons/volume3.svg
	elif [ $pamixervolume -ge 25 ]; then
		notify-send "Volume/Mic" "$pamixertotal" -u normal -t $notificationlifetime -r $notificationid -h int:value:$pamixervolume -i $HOME/.config/dunst/resources/icons/volume2.svg
	elif [ $pamixervolume -ge 10 ]; then
		notify-send "Volume/Mic" "$pamixertotal" -u normal -t $notificationlifetime -r $notificationid -h int:value:$pamixervolume -i $HOME/.config/dunst/resources/icons/volume1.svg
	else
		notify-send "Volume/Mic" "$pamixertotal" -u normal -t $notificationlifetime -r $notificationid -h int:value:$pamixervolume -i $HOME/.config/dunst/resources/icons/volume0.svg
	fi
else
		notify-send "Volume/Mic" "$pamixertotal" -u normal -t $notificationlifetime -r $notificationid -h int:value:$pamixervolume -i $HOME/.config/dunst/resources/icons/volumemute.svg
fi
