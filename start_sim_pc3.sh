#!/bin/sh
# Enter the filename, and mode received from the test_supervisor script.
# Start simulation.
# xdotool getmouselocation --shell
# 
# IMPORTANT NOTE!!! PLEASE READ!!!
# NOTE: xdotool DOES NOT MOVE THE WINDOW OFF THE SCREEN CORRECTLY.
#       PLEASE TAKE THE TIME TO RESIZE THE "DATA ACQ" WINDOW AND MOVE
#       WINDOW SO THAT THE ACE1 SUBWINDOW IS VISIBLE, BUT ITS 
#       SCROLLBAR IS VISIBLE. THE RESULT WILL BE THAT THE FULL BUTTONS
#       AND SELECTION MENUS ON THE RIGHT SIDE ARE VISIBLE.
#
#	Try to fix this moved window by checking position.


filename="$1"
mode="$2"
delay=0.2

# Activate the Data acquisition window. Mouse is not moved to top left of window.
wid=`xdotool search --name "acquisition"`
xdotool windowactivate $wid;sleep $delay

# Enter the file name
xdotool mousemove --sync 1230 405 click --repeat 3 --delay 40 1; sleep $delay
xdotool key "BackSpace"
xdotool type --clearmodifiers $filename; sleep $delay

# Select Normal or Direct Mode
xdotool mousemove --sync 1230 325 click 1; sleep $delay
if [ "$mode" = "1" ] ; then
	xdotool key "Up"; sleep $delay
else
	xdotool key "Down"; sleep $delay
fi
xdotool key "Return"

# Start Simulation
xdotool mousemove --sync 1230 610 click 1
