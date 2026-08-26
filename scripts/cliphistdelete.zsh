#!/bin/zsh

uniqueString='DELETE_ALL_'"$(date '+%F.%H.%M.%S')"
selected="$({ echo $uniqueString; cliphist list } | fuzzel --dmenu --prompt='cliphist DELETE entry > ')"

if [ "$selected" = "$uniqueString" ]; then
	cliphist wipe
	wl-copy --primary --clear
	wl-copy --clear
elif [ -n "$selected" ]; then
	echo "$selected" | cliphist delete
	wl-copy --primary --clear
	wl-copy --clear
fi
