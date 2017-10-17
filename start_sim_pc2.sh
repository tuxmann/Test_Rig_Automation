#!/bin/sh
# Request a filename and mode from the user. Enter filename, select mode, 
# and press "Start Simulation"
# 
# Move the Data acquisition window to the top right of the screen.
# xdotool getmouselocation --shell
# X,Y relative to window 0,0
# filename field: X=580	Y=231
# Mode menu:	  X=580	Y=175
# Start Sim:	  X=580	Y=353

enter_data(){
read -p "Enter the filename for this test: " filename
	until [ "$mode" == "1" ] || [ "$mode" == "2" ]; do
		read -p "Enter (1)Normal or (2)Direct: " mode
	done	
#else echo "number did match"
}

echo $'\n' "	Start Sim PC #2 Script started" $'\n'

enter_data

# Move mouse to 0 0 of the Data acquisition window.
wid=`xdotool search --name "acquisition"`
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep 0.2

# Enter the file name
xdotool mousemove_relative --sync 580 180 click --repeat 3 --delay 40 1; sleep 0.2
xdotool key "BackSpace"
xdotool type --clearmodifiers $filename; sleep 0.2

# Select Normal or Direct Mode
xdotool mousemove_relative --sync 0 -55 click 1; sleep 0.1
if [ "$mode" = "1" ] ; then
	xdotool key "Up"; sleep 0.1
else
	xdotool key "Down"; sleep 0.1
fi
xdotool key "Return"

# Start Simulation
xdotool mousemove_relative --sync 0 180 click 1
echo "	Job Complete!" $'\n'

#####################################################################
######################   LUMBER YARD    #############################
#####################################################################
#echo "You typed:" $filename $mode

#echo "	1"
#echo "	2"
#echo "	3"


