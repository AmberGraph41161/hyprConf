#!/bin/zsh

echo '[this will run rsync to backup everything to whatever is in /mnt/]'
echo '[make sure that you have a disk mounted at /mnt/]'
echo -n '[enter "YES" to continue] > '
read yesNoPrompt
if [ "$yesNoPrompt" != "YES" ]; then
	echo '[aborting!]'
	exit
fi

echo '[starting backup...]'

time sudo rsync -aAXv --delete --exclude={'/tmp/','/sys/','/proc/','/run/','/dev/','/mnt/','/lost+found/'} / /mnt/

echo '[done!]'
