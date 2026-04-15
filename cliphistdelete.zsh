#!/bin/zsh

uniqueString='DELETE_ALL_'"$(date '+%F.%H.%M.%S')"
selected="$({ echo $uniqueString; cliphist list } | fuzzel --dmenu --prompt='cliphist DELETE entry > ')"

wl-copy --primary --clear

if [ "$selected" = "$uniqueString" ]; then
	cliphist wipe
else
	echo "$selected" | cliphist delete
fi
