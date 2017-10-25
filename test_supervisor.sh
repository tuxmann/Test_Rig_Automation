#!/bin/sh
#
# This script is responsible for starting tasks on the remote PCs.
# This script will execute the "start_sim", "clear_start", 
# "finish_and_report". This could be executed by waiting for the tech
# to press ENTER to execute the next script or by selecting a number.

enter_data(){
read -p "Enter the filename for this test: " filename
	until [ "$mode" == "1" ] || [ "$mode" == "2" ]; do
		read -p "Enter (1)Normal or (2)Direct: " mode
	done	
}

echo $'\n' "	Test Supervisor Script started" $'\n'

enter_data

###############################################################################
###################          START SIM SCRIPTS             ####################
###############################################################################
echo $'\n' "	Running Start Sim Scripts"

#PC2
/home/usrA664/Downloads/start_sim_pc2.sh $filename $mode &
#PC3
ssh usrIMB@192.168.1.203 "sleep 0.2; export DISPLAY=:0.0; Downloads/start_sim_pc3.sh $filename $mode" &
#PC4
ssh usrADB@192.168.1.204 "sleep 0.2; export DISPLAY=:0.0; Downloads/start_sim_pc4.sh $filename $mode" &
#PC5
ssh usrA429@192.168.1.205 "sleep 0.2; export DISPLAY=:0.0; Downloads/start_sim_pc5.sh $filename $mode" &

sleep 10; xdotool key alt+Tab
read -p "Press ENTER to continue"

###############################################################################
###################          CLEAR START SCRIPTS           ####################
###############################################################################

# CLEAR FAULTS
echo $'\n' "	Running Clear Faults Scripts"
#PC2
/home/usrA664/Downloads/clear_faults_pc2.sh &
#PC3
ssh usrIMB@192.168.1.203 "sleep 0.2; export DISPLAY=:0.0; Downloads/clear_faults_pc3.sh" &
#PC4
ssh usrADB@192.168.1.204 "sleep 0.2; export DISPLAY=:0.0; Downloads/clear_faults_pc4.sh" &
#PC5
ssh usrA429@192.168.1.205 "sleep 0.2; export DISPLAY=:0.0; Downloads/clear_faults_pc5.sh" &

### ARE THE FAULTS CLEARED?
sleep 16; xdotool key alt+Tab
until [ "$ans" == "Y" ] || [ "$ans" == "y" ]; do
	read -p "Are the faults clear? (Press Ctrl+C to quit) " ans
done	

# START TEST
echo $'\n' "	Starting Tests"
#PC2
wid=`xdotool search --name "acquisition"`
xdotool windowactivate $wid mousemove --sync --window $wid 0 0; sleep 0.2
xdotool mousemove_relative --sync 580 405 click 1
#PC3
ssh usrIMB@192.168.1.203 "sleep 0.2; export DISPLAY=:0.0; xdotool mousemove --sync 1230 705 click 1" &
#PC4
ssh usrADB@192.168.1.204 "sleep 0.2; export DISPLAY=:0.0; xdotool mousemove_relative --sync 350 485 click 1" &
#PC5
ssh usrA429@192.168.1.205 "sleep 0.2; export DISPLAY=:0.0; LD_LIBRARY_PATH=/usr/local/lib; export LD_LIBRARY_PATH; xdotool mousemove_relative --sync 330 -270 click 1" &
sleep 5; xdotool key alt+Tab
read -p "Press ENTER to continue"

###############################################################################
###################        FINISH AND REPORT SCRIPTS       ####################
###############################################################################

echo $'\n' "	Running Finish Scripts"
#PC2
xdotool mousemove_relative --sync 0 50 click 1 &
#PC3
ssh usrIMB@192.168.1.203 "sleep 0.2; export DISPLAY=:0.0; Downloads/finish_and_report_pc3.sh" &
#PC4
ssh usrADB@192.168.1.204 "sleep 0.2; export DISPLAY=:0.0; Downloads/finish_and_report_pc4.sh" &
#PC5
ssh usrA429@192.168.1.205 "sleep 0.2; export DISPLAY=:0.0; Downloads/finish_and_report_pc5.sh"

echo $'\n' "	Test Supervisor Script finished" $'\n'


