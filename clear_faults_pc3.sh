#!/bin/sh
# Click the Clear Faults button. Check if the faults clear. If they do
# not clear, report which PC does not clear and exit. 
#

exec 3>&1 1>/dev/null 2>&1	# Silence terminal output so grabc isn't a nuisance
delay=0.2

# Status Box coordinates
FCM[1]="390 128"
FCM[2]="830 128"
FCM[3]="1245 128"
ACE[1]="290 635"
ACE[2]="600 635"
ACE[3]="930 635"
ACE[4]="1245 635"

# Activate the Data acquisition window.
wid=`xdotool search --name "acquisition"`
xdotool windowactivate $wid; sleep 0.2

# Click Clear Faults button
xdotool mousemove --sync 1230 660 click 1; sleep 7

# Move window to the right so we can switch tabs later
xdotool mousemove --sync 100 40
xdotool mousedown 1; sleep $delay
xdotool mousemove --sync 400 40; sleep $delay
xdotool mouseup 1; sleep $delay

# Check if status boxes are green #00ff00
for i in `seq 1 3`; do 
	color=`grabc & xdotool mousemove --sync ${FCM[$i]} click 1`
	if [ "$color" = "#00ff00" ] ; then
		sleep $delay
	else
		echo "	FAILED ###PC3### FAILED" >&3; exit
	fi
	sleep $delay
done   

for i in `seq 1 4`; do 
	color=`grabc & xdotool mousemove --sync ${ACE[$i]} click 1`
	if [ "$color" = "#00ff00" ] ; then
		sleep $delay
	else
		echo "	FAILED ###PC3### FAILED" >&3; exit
	fi
	sleep $delay
done   

# Switch to Flight Test Tab
xdotool mousemove --sync 110 85 click 1; sleep $delay

for i in `seq 1 3`; do 
	color=`grabc & xdotool mousemove --sync ${FCM[$i]} click 1`
	if [ "$color" = "#00ff00" ] ; then
		sleep $delay
	else
		echo "	FAILED ###PC3### FAILED" >&3; exit
	fi
	sleep $delay
done   

# Switch to first tab & move window to the left
xdotool mousemove --sync 40 85 click 1; sleep $delay
xdotool mousemove --sync 400 40
xdotool mousedown 1; sleep $delay
xdotool mousemove --sync 100 40; sleep $delay
xdotool mouseup 1; sleep $delay

echo "		PC #3: PASS" >&3; sleep $delay
