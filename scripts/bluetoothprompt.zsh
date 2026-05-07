#!/bin/zsh

#rewrote 90% of the entire thing after getting rid of "blueberry.py"

# Random documentation for self:
# Paired = has been connected to device before
# Bonded = both devices have stored info about each other
# Trusted = auto connection is allowed
# Connected = actively connected devices

notificationlifetime=5000
notificationid=100000000

# !!! terminal must be able to launch command such as:
	# alacritty -e btop
	# foot -- btop
	# kitty -- btop
terminalEmulator='foot'

# as of Wednesday, August 13, 2025, 23:26:11, bluetoothctl interactive mode being forced is actually garbage. I hate this I hate this I hate this.
# as of Tuesday, February 17, 2026, 12:03:16, https://github.com/bluez/bluez/issues/1896
	# decolorize: https://unix.stackexchange.com/questions/172000/remove-escape-characters-using-sed

case "$(echo 'bluetooth ON\nbluetooth OFF\nconnect device\ndisconnect device\nedit paired device' | fuzzel -p'enable bluetooth? > ' --dmenu)" in

	"bluetooth ON")
		bluetoothctl power on
		;;

	"bluetooth OFF")
		bluetoothctl power off
		;;

	"connect device")
		bluetoothctl power on
		connectionMethod="$(echo 'already paired device\nscan new devices bredr\nregular all scan on\nlow energy scan le' | fuzzel -p'scan devices? > ' --dmenu)"
		case "$connectionMethod" in

			"already paired device")
				selectedDevice="$(echo 'devices Paired' | bluetoothctl | grep 'Device' | fuzzel -p'choose device > ' --dmenu)"
				selectedDeviceUUID="$(awk '{ print $2 }' <<<$selectedDevice)"
				if [ -z "$selectedDevice" ] || [ -z $selectedDeviceUUID ]; then
					exit
				fi
				if ! bluetoothctl connect "$selectedDeviceUUID"; then
					notify-send "FAILED TO CONNECT TO:" "$selectedDevice" -u normal -t $notificationlifetime -r $notificationid
				else
					notify-send "SUCCESSFULLY CONNECTED TO:" "$selectedDevice" -u normal -t $notificationlifetime -r $notificationid
				fi
				;;

			"scan new devices bredr"|"regular all scan on"|"low energy scan le")
				scanMethod="$(awk '{ print $4}' <<<$connectionMethod)"
				selectedDevice="$( { echo 'scan '""$scanMethod""; sleep 120 & } | bluetoothctl | grep --line-buffered 'Device' | sed --unbuffered 's/.*Device //' | fuzzel -p'choose device > ' --dmenu)"
				selectedDeviceUUID="$(awk '{ print $1 }' <<<$selectedDevice)"
				if [ -z "$selectedDevice" ] || [ -z "$selectedDeviceUUID" ]; then
					exit
				fi
				sleep 1
				# unfortunately, 'bluetooth --agent NoInputNoOutput pair' breaks things that need password or confirmation, so this:
				echo $selectedDeviceUUID
				$terminalEmulator "$HOME/.config/hypr/scripts/interactivebluetoothpair.zsh" "$selectedDeviceUUID"
				if ! bluetoothctl connect "$selectedDeviceUUID"; then
					notify-send "FAILED TO CONNECT TO:" "$selectedDevice" -u normal -t $notificationlifetime -r $notificationid
				else
					notify-send "SUCCESSFULLY CONNECTED TO:" "$selectedDevice" -u normal -t $notificationlifetime -r $notificationid
				fi
				;;
		esac
		;;

	"disconnect device")
		selectedDevice="$(echo 'devices Connected' | bluetoothctl | grep 'Device' | fuzzel -p'choose device > ' --dmenu)"
		selectedDeviceUUID="$(awk '{ print $2 }'<<<$selectedDevice)"
		if [ -z "$selectedDevice" ] || [ -z "$selectedDeviceUUID" ]; then
			exit
		fi
		if ! bluetoothctl disconnect "$selectedDeviceUUID"; then
			notify-send "FAILED TO DISCONNECT FROM:" "$selectedDevice" -u normal -t $notificationlifetime -r $notificationid
		else
			notify-send "SUCCESSFULLY DISCONNECTED FROM:" "$selectedDevice" -u normal -t $notificationlifetime -r $notificationid
		fi
		;;

	"edit paired device")
		selectedDevice="$(echo 'devices Paired\ndevices Trusted\ndevices Bonded' | bluetoothctl | grep 'Device' | sort | uniq | fuzzel -p'choose device > ' --dmenu)"
		selectedDeviceUUID="$(awk '{ print $2 }'<<<$selectedDevice)"
		selectedDeviceName="$(sed 's/Device ..:..:..:..:..:.. //'<<<$selectedDevice)"
		if [ -z "$selectedDevice" ] || [ -z "$selectedDeviceUUID" ]; then
			exit
		fi
		pairedDeviceModificationChoice="$(echo 'set-alias\nset-default-alias\ninfo\ntrust\nuntrust\nblock\nunblock\nremove' | fuzzel -p'['""$selectedDeviceName""'] device options > ' --dmenu)"
		case "$pairedDeviceModificationChoice" in

			"set-alias")
				if ! bluetoothctl set-alias "$(fuzzel --prompt-only='['""$selectedDeviceName""'] enter device alias > ' --dmenu)"; then
					notify-send "FAILED TO $pairedDeviceModificationChoice TO:" "$selectedDevice" -u normal -t $notificationlifetime -r $notificationid
				else
					notify-send "SUCCESSFULLY $pairedDeviceModificationChoice TO:" "$selectedDevice" -u normal -t $notificationlifetime -r $notificationid
				fi
				;;

			"set-default-alias")
				selectedDeviceOriginalName="$(echo 'info '$selectedDeviceUUID | bluetoothctl | grep 'Name: ' | sed 's/.\+Name: //')"
				if ! bluetoothctl set-alias "$selectedDeviceOriginalName"; then
					notify-send "FAILED TO $pairedDeviceModificationChoice TO:" "$selectedDevice" -u normal -t $notificationlifetime -r $notificationid
				else
					notify-send "SUCCESSFULLY $pairedDeviceModificationChoice TO:" "$selectedDevice\n$selectedDeviceOriginalName" -u normal -t $notificationlifetime -r $notificationid
				fi
				;;

			"info")
				notify-send "DEVICE INFO" "$selectedDevice\n$(echo 'info '$selectedDeviceUUID | bluetoothctl | grep 'info ' -A 99 | sed $'s/\033\[[0-9;]*m//g')" -u normal -t $notificationlifetime -r 0
				;;

			*)
				#reset-alias trust, untrust, block, unblock, remove
				if ! bluetoothctl "$pairedDeviceModificationChoice" "$selectedDeviceUUID"; then
					notify-send "FAILED TO $pairedDeviceModificationChoice TO:" "$selectedDevice" -u normal -t $notificationlifetime -r $notificationid
				else
					notify-send "SUCCESSFULLY $pairedDeviceModificationChoice TO:" "$selectedDevice" -u normal -t $notificationlifetime -r $notificationid
				fi
				;;
		esac
		;;
esac
