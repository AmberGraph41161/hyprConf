#!/bin/zsh

#assuming you have "pamixer" and "pactl" working, with preferrably a pipewire-pulse setup

sinkorsources=$(echo "sink\nsources\noutput volume\ninput volume\nmpd volume" | fuzzel --dmenu -p'sink or sources? > ')

if [ "$sinkorsources" = "sink" ]; then
	foundsinks="@NONE@\n"$(pamixer --list-sinks | sed '1,1d')
	chosensink=$(echo $foundsinks | fuzzel --dmenu -p'choose sink > ')
	if [ -n "$chosensink" ]; then
		pactl set-default-sink "$(echo $chosensink | awk '{ print $1 }')"
	fi
elif [ "$sinkorsources" = "sources" ]; then
	foundsources="@NONE@\n"$(pamixer --list-sources | sed '1,1d')
	chosensource=$(echo $foundsources | fuzzel --dmenu -p'choose source > ')
	if [ -n "$chosensource" ]; then
		pactl set-default-source "$(echo $chosensource | awk '{ print $1 }')"
	fi
elif [ "$sinkorsources" = "output volume" ]; then
	outputvolume="mute\nunmute\n"$(seq 0 100)
	outputvolume=$(echo $outputvolume | fuzzel --dmenu -p"[$(pamixer --sink @DEFAULT_SINK@ --get-volume)%][mute: $(pamixer --sink @DEFAULT_SINK@ --get-mute)] "'set output volume > ')
	if [ "$outputvolume" = "mute" ]; then
		pamixer --sink @DEFAULT_SINK@ --mute
	elif [ "$outputvolume" = "unmute" ]; then
		pamixer --sink @DEFAULT_SINK@ --unmute
	else
		pamixer --sink @DEFAULT_SINK@ --set-volume $outputvolume
	fi
elif [ "$sinkorsources" = "input volume" ]; then
	inputvolume="mute\nunmute\n"$(seq 0 100)
	inputvolume=$(echo $inputvolume | fuzzel --dmenu -p"[$(pamixer --default-source --get-volume)%][mute: $(pamixer --default-source --get-mute)] "'set input volume > ')
	if [ "$inputvolume" = "mute" ]; then
		pamixer --default-source --mute
	elif [ "$inputvolume" = "unmute" ]; then
		pamixer --default-source --unmute
	else
		pamixer --default-source --set-volume $inputvolume
	fi
elif [ "$sinkorsources" = "mpd volume" ]; then
	mpc volume $(seq 0 100 | fuzzel --dmenu -p"[$(mpc status '%volume%')] "'set mpd volume > ')
fi
