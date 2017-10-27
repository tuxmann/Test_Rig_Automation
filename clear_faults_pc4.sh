#!/bin/sh
# Click the Clear Faults button. Check if the faults clear. If they do
# not clear, report which PC does not clear and exit. 
#

exec 3>&1 1>/dev/null 2>&1	# Silence terminal output so grabc isn't a nuisance
delay=0.2

# Move mouse to 0 0 of the Data acquisition window.
wid=`xdotool search --name "acquistion"`
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep $delay

# Click Clear Faults button
xdotool mousemove_relative --sync 950 470 click 1; sleep 7

# Check if the faults are cleared
color=`grabc & xdotool mousemove_relative --sync -- -300 -420 click 1`

if [ "$color" = "#00ff00" ] ; then
	echo "		PC #4: PASS" >&3
else
	echo "	FAILED ###PC4### FAILED " >&3
fi
