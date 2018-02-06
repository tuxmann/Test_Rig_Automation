#!/bin/sh
# Click the Stop Test and Stop Sim buttons. Check if any status faults
# occurred, and report faults. Activate QTDPP program and start post
# processing. 

exec 3>&1 1>/dev/null 2>&1	# Silence terminal output so "Defaulting to search window name" Doesn't appear
LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH
delay=0.5
fail=0

# Status Box coordinates
BOX[1]="440 480"
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
	color=`grabc & sleep 0.1 && xdotool mousemove_relative --sync -- ${BOX[$i]} click 1`
	if [ "$color" = "#00ff00" ] ; then
		sleep 0
	else
		fail=1
	fi
	sleep $delay
done   

if [ "$fail" = 0 ] ; then
	echo -e "		\e[102mPC #5: PASS\e[0m" >&3
else
	echo -e "	\e[41mFAILED ###PC5### FAILED\e[0m" >&3
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

process(){ # Click Process button & Check Done
xdotool mousemove_relative --sync -- -295 325 click 1
button_old=`grabc & sleep 0.1 && xdotool mousemove_relative --sync 354 -185 click 1`
button_new=$button_old
xdotool click 1; sleep $delay
until [ "$button_old" != "$button_new" ]; do
	button_new=`grabc & sleep 0.1 && xdotool click 1`; sleep 1
done
}

process

sleep 2

# Select most recent data file
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep $delay
xdotool mousemove_relative --sync 580 190 click 1; sleep $delay

for i in `seq 1 3`; do # Press the down arrow 						three times
	sleep $delay; xdotool key "Down" 
done   

xdotool key "Return"; sleep $delay

# Click Process button
process

# Open file browser and go to most recent report
nautilus /home/data; sleep 2
xdotool key "Down"; xdotool key "Down"; sleep 1
xdotool keydown "shift"; xdotool key "Down"; xdotool keyup "shift"
xdotool key "Return"; sleep 1
xdotool keydown "ctrl"; xdotool key "End"; xdotool keyup "ctrl"

echo "	PC #5 QRPT file created"  >&3

