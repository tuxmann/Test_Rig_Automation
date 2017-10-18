#!/bin/sh
# Request a filename and mode from the user. Enter filename, select mode, 
# and press "Start Simulation"
# 
# IMPORTANT NOTE!!! PLEASE READ!!!
# NOTE: xdotool DOES NOT MOVE THE WINDOW OFF THE SCREEN CORRECTLY.
#       PLEASE TAKE THE TIME TO RESIZE THE "DATA ACQ" WINDOW AND MOVE
#       WINDOW SO THAT THE ACE1 SUBWINDOW IS VISIBLE, BUT ITS 
#       SCROLLBAR IS VISIBLE. THE RESULT WILL BE THAT THE FULL BUTTONS
#       AND SELECTION MENUS ON THE RIGHT SIDE ARE VISIBLE.
#
#
# Move the Data acquisition window to the top right of the screen.
# xdotool getmouselocation --shell
# X,Y not relative 
# filename field: X=1230  Y=405
# Mode menu:	  X=1230  Y=325
# Start Sim:	  X=1230  Y=610

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
xdotool windowactivate $wid #mousemove --sync --window $wid 0 0; 
sleep 2

# Enter the file name
xdotool mousemove --sync 1230 405 click --repeat 3 --delay 40 1; sleep 2
xdotool key "BackSpace"
xdotool type --clearmodifiers $filename; sleep 2

# Select Normal or Direct Mode
xdotool mousemove --sync 1230 325 click 1; sleep 1
if [ "$mode" = "1" ] ; then
	xdotool key "Up"; sleep 1
else
	xdotool key "Down"; sleep 1
fi
xdotool key "Return"

# Start Simulation
xdotool mousemove --sync 1230 610 click 1
echo "	Job Complete!" $'\n'

#####################################################################
######################   LUMBER YARD    #############################
#####################################################################
#echo "You typed:" $filename $mode

#echo "	1"
#echo "	2"
#echo "	3"


