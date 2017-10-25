#!/bin/sh
# Click the Stop Test and Stop Sim buttons. Check if any status faults
# occurred, and report faults. Activate QTDPP program and start post
# processing. 

exec 3>&1 1>/dev/null 2>&1	# Silence terminal output so grabc isn't a nuisance
delay=0.5

# Move mouse to 0 0 of the Data acquisition window.
wid=`xdotool search --name "acquisition"`
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep $delay

# Click Stop Test button
xdotool mousemove_relative --sync 580 405 click 1; sleep $delay

# Click Stop Sim button
xdotool mousemove_relative --sync 0 -100 click 1; sleep $delay

xdotool mousemove --sync --window $wid 0 0; sleep $delay
# Check if the faults are occurred
color=`grabc & xdotool mousemove_relative --sync -- -190 -310 click 1`
if [ "$color" = "#00ff00" ] ; then
	echo "		PC #2: PASS" >&3		# ">&3 sends output to terminal
else
	echo "	FAILED ###PC2### FAILED"  >&3
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
