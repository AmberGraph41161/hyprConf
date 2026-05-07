#!/bin/zsh

menuoptions=$(echo "Shutdown\nReboot\nSuspend\nLogout\nBtop\nfoot\nBrightness\nAudio\nBluetooth\nCamera\nSecretCamera\nHotspot\nMpdCoverArt")

areyousure='fat finger misclick
fat finger misclick
fat finger misclick
fat finger misclick
fat finger misclick
fat finger misclick
fat finger misclick
fat finger misclick
fat finger misclick
fat finger misclick
I am absolutely sure I want to '

case $(echo $menuoptions | fuzzel -p "[PowerMenu] > " --dmenu) in

	"Shutdown")
		areyousure+='poweroff'

		areyousure=$(echo $areyousure | fuzzel -p'[ARE YOU SURE??] ' --dmenu);
		if [ "$areyousure" = "I am absolutely sure I want to poweroff" ]; then
			shutdown now
		fi
		;;

	"Reboot")
		areyousure+='reboot'

		areyousure=$(echo $areyousure | fuzzel -p'[ARE YOU SURE??] ' --dmenu);
		if [ "$areyousure" = "I am absolutely sure I want to reboot" ]; then
			reboot
		fi
		;;

	"Suspend")
		areyousure+='suspend'

		areyousure=$(echo $areyousure | fuzzel -p'[ARE YOU SURE??] ' --dmenu);
		if [ "$areyousure" = "I am absolutely sure I want to suspend" ]; then
			areyousure='lock\nnolock'
			areyousure=$(echo $areyousure | fuzzel -p'[lock or no lock?] ' --dmenu)
			if [ -z "$areyousure" ]; then
				exit
			elif [ "$areyousure" = "lock" ]; then
				# make sure  that this runs in the background... otherwise it inhibits the suspend command until pc is unlocked
				hyprlock --grace 0 --immediate-render --no-fade-in &
				while [ ! $(pidof hyprlock) ]; do
					sleep 1
				done
			fi
			systemctl suspend
		fi
		;;

	"Logout")
		areyousure+='logout'

		areyousure=$(echo $areyousure | fuzzel -p'[ARE YOU SURE??] ' --dmenu);
		if [ "$areyousure" = "I am absolutely sure I want to logout" ]; then
			hyprctl 'dispatch exit'
		fi
		;;

	"Btop")
		hyprctl 'dispatch exec [fullscreen] foot btop'
		;;

	"foot")
		hyprctl 'dispatch exec [fullscreen] foot'
		;;

	"Brightness")
		brightnessctl set "$(seq 1 100 | fuzzel -p'set brightness > ' --dmenu)"%
		;;

	"Audio")
		"$HOME/.config/hypr/scripts/audioprompt.zsh"
		;;

	"Bluetooth")
		"$HOME/.config/hypr/scripts/bluetoothprompt.zsh"
		;;

	"Camera")
		ffplay -window_title ffplaywebcampreview -fast /dev/video0
		notify-send "Camera" "DO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nclose your camera cover brudda" -u normal -t 10000
		;;
	
	"SecretCamera")
		"$HOME/.config/hypr/scripts/secretcamera.zsh"
		;;

	"Hotspot")
		"$HOME/.config/hypr/scripts/hotspot.zsh"
		;;

	"MpdCoverArt")
		"$HOME/.config/hypr/scripts/mpddisplaycoverart.zsh"
		;;

	*)
		echo "bruh."
		;;
esac
