#!/bin/zsh

notificationlifetime=1000
notificationid=100000000

### current song queue info ###
totaltime="[totaltime] $(mpc status '%totaltime%')"
currenttime="[currenttime] $(mpc status '%currenttime%')"
percenttime="[percenttime] $(mpc status '%percenttime%')"
songpos="[songpos] $(mpc status '%songpos%')"
length="[length] $(mpc status '%length%')"

state="[state] $(mpc status '%state%')"

currentsong="[Current] $(mpc current)"
queuedsong="[Next] $(mpc queued)"

### settings info ###
volume="[volume] $(mpc status '%volume%')"
random="[random] $(mpc status '%random%')"
repeat="[repeat] $(mpc status '%repeat%')"
single="[single] $(mpc status '%single%')"
consume="[consume] $(mpc status '%consume%')"

### misc info ###
kbitrate="[kbitrate] $(mpc status '%kbitrate%')"
audioformat="[audioformat] $(mpc status '%audioformat%')"
samplerate="[samplerate] $(mpc status '%samplerate%')"
bits="[bits] $(mpc status '%bits%')"
channels="[channels] $(mpc status '%channels%')"

#as of Wednesday, August 28, 2024, 14:28:29, too lazy to make cool for now. this is good for now, just raw info
final="$currentsong\n\n$queuedsong\n\n$totaltime\n$currenttime\n$percenttime\n$songpos\n$length\n$state\n$volume\n$random\n$repeat\n$single\n$consume\n$kbitrate\n$audioformat\n$samplerate\n$bits\n$channels"

notify-send "MPD/MPC [$(mpc status '%state%')]" "$final" -u normal -t $notificationlifetime -r $notificationid -h "int:value:$(mpc status '%percenttime%' | sed 's/.$//; s/\s\+//')"  -i /tmp/mpd_cover.jpg
