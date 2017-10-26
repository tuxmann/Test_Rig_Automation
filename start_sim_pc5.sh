#!/bin/sh
# Enter the filename, and mode received from the test_supervisor script.
# Start simulation.
# xdotool getmouselocation --shell

exec 3>&1 1>/dev/null 2>&1	# Silence terminal output so "Defaulting to search window name" Doesn't appear
filename="$1"
mode="$2"
delay=0.2
LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH

#enter_data

# Move mouse to 0 0 of the Data acquisition window.
wid=`xdotool search --desktop 0 "acquistion"`	# spelled incorrectly on purpose.
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep $delay

# Click 3 times to highlight all text, press BackSpace, Enter the filename
xdotool mousemove_relative --sync 1340 120 click --repeat 3 --delay 40 1; sleep $delay
xdotool key "BackSpace"
xdotool type --clearmodifiers $filename; sleep $delay

# Select Normal or Direct Mode
xdotool mousemove_relative --sync 0 350 click 1; sleep $delay
if [ "$mode" = "1" ] ; then
	xdotool key "Up"; sleep $delay
else
	xdotool key "Down"; sleep $delay
fi
xdotool key "Return"

# Start Simulation
xdotool mousemove_relative --sync 0 -410 click 1
