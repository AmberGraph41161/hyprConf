#!/bin/zsh

choices="satty\nzbarimg\ntesseract\nwl-copy"
ffmpegcameramagic_taken_photo_file_path="/tmp/ffmpegcameramagic_$(date '+%F.%H.%M.%S').png"

function ffmpegTakeWebcamPhoto()
{
	while true; do
		ffplay -window_title 'ffplaywebcampreview' -fast /dev/video0
		#'-y' will overwrite image without asking
		ffmpeg -f video4linux2 -i /dev/v4l/by-id/usb-SunplusIT_Inc_Integrated_Camera-video-index0 -vframes 1 -video_size 1920x1080 -y "$ffmpegcameramagic_taken_photo_file_path"
		#ffmpeg -f video4linux2 -i /dev/video0 -vframes 1 -video_size 1920x1080 -y "$ffmpegcameramagic_taken_photo_file_path"

		#hyprctl 'dispatch exec [float; size 480 270; move 0 0]' -- imv -w'ffplaywebcampreview' "$ffmpegcameramagic_taken_photo_file_path"
		imv -w'ffplaywebcampreview' "$ffmpegcameramagic_taken_photo_file_path"

		isPhotoGoodOrBadStatus="$(echo 'bad\ngood' | fuzzel -p'bad? good? > ' --dmenu)"
		if [  "$isPhotoGoodOrBadStatus" = "good" ] || [ -z "$isPhotoGoodOrBadStatus" ]; then
			break;
		fi
	done
}

case $(echo $choices | fuzzel -p"ffmpegCameraMagic > " --dmenu) in

	"satty")
		ffmpegTakeWebcamPhoto
		satty -f "$ffmpegcameramagic_taken_photo_file_path" --copy-command "wl-copy" --early-exit --disable-notifications
		;;

	"zbarimg")
		#ffmpegTakeWebcamPhoto
		#zbarimg "$ffmpegcameramagic_taken_photo_file_path" | wl-copy
		zbarcam | wl-copy
		;;

	"tesseract")
		ffmpegTakeWebcamPhoto
		tesseract "$ffmpegcameramagic_taken_photo_file_path" - | wl-copy
		;;

	"wl-copy")
		ffmpegTakeWebcamPhoto
		cat "$ffmpegcameramagic_taken_photo_file_path" | wl-copy
		;;
esac

notify-send "ffmpegCameraMagic" "DO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nDO NOT FORGET\nclose your camera cover brudda" -u normal -t 10000
