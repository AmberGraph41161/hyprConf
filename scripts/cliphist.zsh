#!/bin/zsh
cliphist list | fuzzel --dmenu --prompt="cliphist > " | cliphist decode | wl-copy
