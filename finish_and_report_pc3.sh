#!/bin/sh
# Click the Stop Test and Stop Sim buttons. Check if any status faults
# occurred, and report faults. Activate QTDPP program and start post
# processing. 

exec 3>&1 1>/dev/null 2>&1	# Silence terminal output so grabc isn't a nuisance
delay=0.5
fail=0
# Status Box coordinates
FCM[1]="390 128"
FCM[2]="830 128"
FCM[3]="1245 128"
ACE[1]="290 635"
ACE[2]="600 635"
ACE[3]="930 635"
ACE[4]="1245 635"

####		!!!!!!!!!!!			MAKE THIS ABSOLUTE AND NOT RELATIVE		!!!!!!!!!!!! ######
# Move mouse to 0 0 of the Data acquisition window.
wid=`xdotool search --name "acquisition"`
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep $delay

# Click Stop Test button
xdotool mousemove_relative --sync 1175 655 click 1; sleep $delay

# Click Stop Sim button
xdotool mousemove_relative --sync 0 -100 click 1; sleep $delay


# Move window to the right so we can switch tabs later
xdotool mousemove --sync 100 40
xdotool mousedown 1; sleep $delay
xdotool mousemove --sync 400 40; sleep $delay
xdotool mouseup 1; sleep $delay

# Check if status boxes are green #00ff00
for i in `seq 1 3`; do 
	color=`grabc & xdotool mousemove --sync ${FCM[$i]} click 1`
	if [ "$color" = "#00ff00" ] ; then
		sleep 0
	else
		fail=1
	fi
	sleep $delay
done   

for i in `seq 1 4`; do 
	color=`grabc & xdotool mousemove --sync ${ACE[$i]} click 1`
	if [ "$color" = "#00ff00" ] ; then
		sleep 0
	else
		fail=1
	fi
	sleep $delay
done   

# Switch to Flight Test Tab
xdotool mousemove --sync 110 85 click 1; sleep $delay

for i in `seq 1 3`; do 
	color=`grabc & xdotool mousemove --sync ${FCM[$i]} click 1`
	if [ "$color" = "#00ff00" ] ; then
		sleep 0
	else
		fail=1
	fi
	sleep $delay
done   

# Switch to first tab & move window to the left
xdotool mousemove --sync 40 85 click 1; sleep $delay
xdotool mousemove --sync 400 40
xdotool mousedown 1; sleep $delay
xdotool mousemove --sync 100 40; sleep $delay
xdotool mouseup 1; sleep $delay

if [ "$fail" = 0 ] ; then
	echo "		PC #3: PASS" >&3
else
	echo "	FAILED ###PC3### FAILED" >&3
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
for i in `seq 1 2`; do # Press the down arrow 						two times
	sleep $delay; xdotool key "Down"
done   
xdotool key "Return"; sleep $delay

# Click Process button
xdotool mousemove_relative --sync -- -260 325 click 1
