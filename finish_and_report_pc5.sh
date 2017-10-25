#!/bin/sh
# Click the Stop Test and Stop Sim buttons. Check if any status faults
# occurred, and report faults. Activate QTDPP program and start post
# processing. 

LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH
delay=0.5
fail=0

# Status Box coordinates
BOX[1]="-900 310"
BOX[2]="600 0"

# Move mouse to 0 0 of the Data acquisition window.
wid=`xdotool search --desktop 0 "acquistion"`
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep $delay

# Click Stop Test button
xdotool mousemove_relative --sync 1375 220 click 1; sleep $delay

# Click Stop Sim button
xdotool mousemove_relative --sync 0 -160 click 1; sleep $delay

# Check if the faults are occurred
xdotool mousemove --sync --window $wid 0 0; sleep $delay

for i in `seq 1 2`; do 
	color=`grabc & xdotool mousemove_relative --sync -- ${BOX[$i]} click 1`
	if [ "$color" = "#00ff00" ] ; then
		sleep 0
	else
		fail=1
	fi
	sleep $delay
done   

if [ "$fail" = 0 ] ; then
	echo "		PC #3: PASS" >&3
else
	echo "	FAILED ###PC5### FAILED" >&3
fi

# Switch to Post Processing Window
wid=`xdotool search --desktop 0 "data post"`
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep $delay

# Select Pass/Fail Criteria File
xdotool mousemove_relative --sync 580 90 click 1; sleep $delay
for i in `seq 1 4`; do # Press the down arrow four times
	sleep $delay; xdotool key "Down" 
done   
xdotool key "Return"; sleep $delay

# Select most recent data file
xdotool mousemove_relative --sync 0 100 click 1; sleep $delay
for i in `seq 1 1`; do # Press the down arrow 						two times
	sleep $delay; xdotool key "Down" 
done   
xdotool key "Return"; sleep $delay

# Click Process button
xdotool mousemove_relative --sync -- -260 325 click 1; sleep $delay

echo "	Job Complete!"

