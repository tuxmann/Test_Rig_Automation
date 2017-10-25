#!/bin/sh
# Click the Stop Test and Stop Sim buttons. Check if any status faults
# occurred, and report faults. Activate QTDPP program and start post
# processing. 

echo "	Finish & Report PC #4 Script started"
delay=0.5
# Move mouse to 0 0 of the Data acquisition window.
wid=`xdotool search --name "acquistion"`
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep $delay

# Click Stop Test button
xdotool mousemove_relative --sync 1000 530 click 1; sleep $delay

# Click Stop Sim button
xdotool mousemove_relative --sync 0 -120 click 1; sleep $delay

# Check if the faults are occurred
xdotool mousemove --sync --window $wid 0 0; sleep $delay
xdotool mousemove_relative --sync 950 470
color=`grabc & xdotool mousemove_relative --sync -- -300 -420 click 1`
if [ "$color" = "#00ff00" ] ; then
	echo "		PC #4: PASS" >&3; sleep $delay
else
	echo "	FAILED ###PC4### FAILED " >&3; exit
fi


# Switch to Post Processing Window
wid=`xdotool search --name "data post"`
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

