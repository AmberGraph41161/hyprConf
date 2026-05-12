#!/bin/zsh

ffmpegSecretCameraVideoFrames=10
ffmpegSecretCameraLocation="/tmp/ffmpegSecretCameraTemp%d.png"

choices="wl-copy\nimv"
case $(echo $choices | fuzzel -p"secretCamera > " --dmenu) in
	"wl-copy")
		ffmpeg -f video4linux2 -i /dev/v4l/by-id/usb-SunplusIT_Inc_Integrated_Camera-video-index0 -vframes $ffmpegSecretCameraVideoFrames -video_size 1920x1080 -y "$ffmpegSecretCameraLocation"\
			&& cat "${ffmpegSecretCameraLocation%\%d.png}$ffmpegSecretCameraVideoFrames.png" | wl-copy
		;;

	
	"imv")
		#ffmpeg -f video4linux2 -i /dev/v4l/by-id/usb-SunplusIT_Inc_Integrated_Camera-video-index0 -vframes 1 -video_size 1920x1080 -y "$ffmpegSecretCameraLocation"\
		ffmpeg -f video4linux2 -i /dev/v4l/by-id/usb-SunplusIT_Inc_Integrated_Camera-video-index0 -vframes $ffmpegSecretCameraVideoFrames -video_size 1920x1080 -y "$ffmpegSecretCameraLocation"\
			&& cat "${ffmpegSecretCameraLocation%\%d.png}$ffmpegSecretCameraVideoFrames.png" | wl-copy \
			&& hyprctl 'dispatch hl.exec_cmd("imv -w'"'$0'"' '"${ffmpegSecretCameraLocation%\%d.png}$ffmpegSecretCameraVideoFrames.png"'", { float = true, size = { 100, 100 }, center = true })'
		;;

	*)
	echo "bruh"
		;;
esac

notify-send "ffmpegCameraMagic" "DO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nclose your camera cover brudda" -u normal -t 10000
