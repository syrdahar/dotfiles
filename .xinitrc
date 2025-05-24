#!/bin/sh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# Display settings
redshift -PO 4000 &

# Touchpad synaptics
touchegg &

# Sound stuff
start-pulseaudio-x11 &
blueman-applet &

# Wallpaper
feh --bg-scale ~/Pictures/physics.jpg

# Keyboard options
setxkbmap fr
setxkbmap -option caps:swapescape

xrdb merge ~/.Xresources
dash ~/sources/chadwm/scripts/bar.sh &

# Launch window manager
exec $HOME/sources/chadwm/chadwm/dwm
