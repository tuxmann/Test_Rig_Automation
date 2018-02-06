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
sleep $delay
# Click Stop Sim button
xdotool mousemove_relative --sync 0 -100 click 1; sleep $delay
sleep $delay
# Move window to the right
move_wndw_right(){
xdotool mousemove --sync 100 40
xdotool mousedown 1; sleep $delay
xdotool mousemove --sync 400 40; sleep $delay
xdotool mouseup 1; sleep $delay
}

# Move window to the left
move_wndw_left(){
xdotool mousemove --sync 400 40
xdotool mousedown 1; sleep $delay
xdotool mousemove --sync 100 40; sleep $delay
xdotool mouseup 1; sleep $delay
}

# Move window to the right so we can switch tabs later
move_wndw_right

# Check if status boxes are green #00ff00
for i in `seq 1 3`; do 
	color=`grabc & sleep 0.2 && xdotool mousemove --sync ${FCM[$i]} click 1`
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

# Switch to first tab 
xdotool mousemove --sync 40 85 click 1; sleep $delay
move_wndw_left

if [ "$fail" = 0 ] ; then
	echo -e "		\e[102mPC #3: PASS\e[0m" >&3
else
	echo -e "	\e[41mFAILED ###PC3### FAILED\e[0m" >&3
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
xdotool mousemove_relative --sync -- -295 325 click 1; sleep 3

# Check to see if the program is finished processing.
button_old=`grabc & xdotool mousemove_relative --sync 354 -185 click 1`
button_new=$button_old
xdotool click 1; sleep $delay
until [ "$button_old" != "$button_new" ]; do
	button_new=`grabc & sleep 0.1 && xdotool click 1`; sleep 1
done

# Open file browser and go to most recent report
nautilus /home/data; sleep 2
xdotool key "Down"; xdotool key "Down"; xdotool key "Down"; sleep 1
xdotool key "Return"; sleep 1
xdotool keydown "ctrl"; xdotool key "End"; xdotool keyup "ctrl"

echo "	PC #3 QRPT file created"  >&3
