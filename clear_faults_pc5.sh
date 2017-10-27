#!/bin/sh
# Click the Clear Faults button. Check if the faults clear. If they do
# not clear, report which PC does not clear and exit. 
#

exec 3>&1 1>/dev/null 2>&1	# Silence terminal output so grabc isn't a nuisance
LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH
delay=0.2

# Status Box coordinates
BOX[1]="-900 310"
BOX[2]="600 0"

# Move mouse to 0 0 of the Data acquisition window.
wid=`xdotool search --desktop 0 "acquistion"`
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep $delay

# Click Clear Faults button
xdotool mousemove_relative --sync 1340 170 click 1; sleep 7

# Check if the faults are cleared
for i in `seq 1 2`; do 
	color=`grabc & xdotool mousemove_relative --sync -- ${BOX[$i]} click 1`
	if [ "$color" = "#00ff00" ] ; then
		sleep 0
	else
		echo "	FAILED ###PC5### FAILED" >&3; exit
	fi
	sleep $delay
done   

echo "		PC #5: PASS" >&3
