;
; AutoIt Version: 3.0
; Language:       English
; Platform:       Win9x/NT
; Author:         Jonathan Bennett (jon@hiddensoft.com)
;
; Script Function:
;   Demo of using multiple lines in a message box
;

; Use the @CRLF macro to do a newline in a MsgBox - it is similar to the \n in v2.64
; OK Returns 1, CANCEL Returns 2
;MsgBox(1, "FTCM Automation", "This program automates the Global Latch Reset process" & @CRLF & "Press OK to begin or CANCEL to quit")

Run("C:\DFTS\FTCM.exe")
WinWaitActive("Flight Test Configuration Manager (FTCM v10.1.6.0)")
;WinActivate("Flight Test Configuration Manager (FTCM v10.1.6.0)")
Sleep(1000) 

;Directories + sign
ControlClick("Flight Test ","","[CLASSNN:TreeView20WndClass1]", "left", 1,12,12)
Sleep(100)
;Initial Settings
ControlClick("Flight Test ","","[CLASSNN:TreeView20WndClass1]", "left", 1,60,22)
Sleep(100) 
;Global Latch Reset.csv
MouseClick("left", 620, 294)
Sleep(100) 
;Load Selected Setup
MouseClick("left", 820, 495)
Sleep(100) 
;FCM Mini Checkboxes
MouseClick("left", 702, 190)
MouseClick("left", 702, 202)
MouseClick("left", 798, 190)
MouseClick("left", 798, 202)
MouseClick("left", 895, 190)
MouseClick("left", 895, 202)
;Stim Lists
MouseClick("left", 510, 200)
;Stimulus List (Execute Setup)
MouseClick("left", 510, 630)
;FCM1_COM
MouseClick("left", 510, 660)
;Un-Check and then Check
MouseClick("left", 712, 402)
Sleep(100) 
MouseClick("left", 712, 402)
;Stimulus Setup Value of 1
MouseClick("left", 732, 434)
MouseClick("left", 635, 575)
MouseClick("left", 865, 665)
Sleep(4500) 

;Un-Check and then Check
MouseClick("left", 712, 402)
Sleep(100) 
MouseClick("left", 712, 402)
;Stimulus Setup Value of 1
;MouseClick("left", 732, 434)
MouseClick("left", 635, 575)
MouseClick("left", 865, 665)
Sleep(30000) 

MouseClick("left", 940, 170)

;Move mouse back to script icon
MouseClick("left", 110, 230)

; =================   Junk  =====================
;MouseClick("Flight Test Configuration Manager (FTCM v10.1.6.0)","", "[,[,[,352[,266]]]]")