#!/bin/zsh

#NOTE AS OF: Monday, May 06, 2024, 00:53:07
# you WILL get weird visual errors in nvim while editing this, so just don't touch anything near the emojis,
# they have already been formatted correctly. Just work with piping and stdout redirecting the echo command

#see "https://unicode.org/emoji/charts/full-emoji-list.html" for more emoji stuff idk
#see "https://unicode.org/Public/" to download full emoji lists and such
#see "https://unicode.org/Public/emoji/" to download full emoji lists and such

cat "$HOME/.config/hypr/scripts/resources/emojipickerlist.txt" | fuzzel --dmenu | sed "s/\s.*$//" | wl-copy -n
