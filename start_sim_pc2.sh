#!/bin/sh
# Enter the filename, and mode received from the test_supervisor script.
# Start simulation.
# xdotool getmouselocation --shell

filename="$1"
mode="$2"
delay=0.2

# Move mouse to 0 0 of the Data acquisition window.
wid=`xdotool search --name "acquisition"`
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep $delay

# Enter the file name
xdotool mousemove_relative --sync 580 180 click --repeat 3 --delay 40 1; sleep $delay
xdotool key "BackSpace"
xdotool type --clearmodifiers $filename; sleep $delay

# Select Normal or Direct Mode
xdotool mousemove_relative --sync 0 -55 click 1; sleep $delay
if [ "$mode" = "1" ] ; then
	xdotool key "Up"; sleep $delay
else
	xdotool key "Down"; sleep $delay
fi
xdotool key "Return"

# Start Simulation
xdotool mousemove_relative --sync 0 180 click 1
