#!/bin/zsh

choices="grim\nsatty\nzbarimg\ntesseract\nmonitor\nimv\nimvsatty\nffmpegCameraMagic"

case $(echo $choices | fuzzel -p"grim magick > " --dmenu) in
	"grim")
		grim -g "$(slurp -w 0 -b 555555aa)" - | wl-copy
		;;
	"satty")
		grim -g "$(slurp -w 0 -b 555555aa)" - | satty -f - --copy-command "wl-copy" --early-exit --disable-notifications
		;;

	"zbarimg")
		grim -g "$(slurp -w 0 -b 555555aa)" - | zbarimg - | wl-copy
		;;
	
	"tesseract")
		grim -g "$(slurp -w 0 -b 555555aa)" - | tesseract - - | wl-copy
		;;

	"monitor")
		monitors="$(hyprctl 'monitors all' | sed '/\t.*/d; /^$/d; s/[^ ]*\s//; s/\s.*//')"
		grim -o "$(echo $monitors | fuzzel -p'choose monitor (UNFINISHED FUNCTIONALITY AS OF MONDAY, AUGUST 26, 2024, 01:45:20) > ' --dmenu)" - | wl-copy
		;;

	"imv")
		grimmagic_imv_image_file_path="/tmp/grimmagic_imv_$(date '+%F.%H.%M.%S').png"
		grim -g "$(slurp -w 0 -b 555555aa)" "$grimmagic_imv_image_file_path" \
			&& cat "$grimmagic_imv_image_file_path" \
			| wl-copy && hyprctl 'dispatch hl.exec_cmd("imv '"$grimmagic_imv_image_file_path"'", { float = true, size = { 480, 270 }, center = true })'
		;;

	"imvsatty")
		grimmagic_imvsatty_image_file_path="/tmp/grimmagic_imvsatty_$(date '+%F.%H.%M.%S').png"
		grim -g "$(slurp -w 0 -b 555555aa)" - | satty -f - --copy-command "wl-copy" --early-exit --disable-notifications -o "$grimmagic_imvsatty_image_file_path" && imv "$grimmagic_imvsatty_image_file_path"
		;;

	"ffmpegCameraMagic")
		"$HOME/.config/hypr/scripts/ffmpegcameramagic.zsh"
		;;
esac
