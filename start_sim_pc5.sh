#!/bin/sh
# Request a filename and mode from the user. Enter filename, select mode, 
# and press "Start Simulation"
# 
# Move the Data acquisition window to the top right of the screen.
# xdotool getmouselocation --shell
# X,Y relative to window 0,0
# filename field: X=1340	Y=120
# Mode menu:	  X=580	Y=470
# Start Sim:	  X=580	Y=60

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
wid=`xdotool search --name "acquistion"`	# spelled incorrectly on purpose.
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep 2

# Enter the file name
xdotool mousemove_relative --sync 1340 120 click --repeat 3 --delay 40 1; sleep 2
xdotool key "BackSpace"
xdotool type --clearmodifiers $filename; sleep 2

# Select Normal or Direct Mode
xdotool mousemove_relative --sync 0 350 click 1; sleep 1
if [ "$mode" = "1" ] ; then
	xdotool key "Up"; sleep 1
else
	xdotool key "Down"; sleep 1
fi
xdotool key "Return"

# Start Simulation
xdotool mousemove_relative --sync 0 -410 click 1
echo "	Job Complete!" $'\n'

#####################################################################
######################   LUMBER YARD    #############################
#####################################################################
#echo "You typed:" $filename $mode

#echo "	1"
#echo "	2"
#echo "	3"


