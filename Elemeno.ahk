;**************************************************************
;Elemeno's Keycloner for World of Warcraft
;Current Version 01/07/2013.1
;Some code inspired by other people from the AHK community
;Feel free to use / modify this code as needed
;**************************************************************
 
;**************************************************************
;IMPORTANT STUFF
;To close the program use <CTRL>+<SHIFT>+C at anytime
;Press 'Pause' to temporarily suspend the program
;**************************************************************
  
;To Use:
;**************************************************************
; -Log into WoW with 2 separate windows.
; -Start the program
; -Pressing <Shift> and F1 will load Camera Setup #1 [Window #1 Maximized, Window #2 25% of screen in bottom left corner]
; -Pressing <Shift> and F2 will load Camera Setup #2 [Window #1 75% of screen top left, Window #2 25% of screen in bottom left corner]
; -Pressing F1 will make Window #1 the primary window
; -Pressing F2 will make Window #2 the primary window
; -Pressing <Scroll Lock> will reload the script
;
; Special Warcraft Setup:
;**************************************************************
; This script works heavily dependant on certain macros you have
; set up with keybinds in your respective warcraft windows.
; Your two characters should be able to jump and activate the standard
; shortcut keys but will have a hard time getting around. You will need
; to set up some /follow macros, and their is no one *correct* way to do it.
; Search the web, forums, etc.. and you will have different people having their
; own preferences. I will provide a limited amount below to perform basic
; functions / tasks on your two characters.
;
; Basic Setup:
;**************************************************************
; For Wow Instance #1 [Your main character]
; - Unbind your arrow movement keys
;
; For WoW Instance #2 [Your secondary character]
; - Unbind your standard movement keys Q,W,E,A,S,D
; - Bind the movement keys to the arrow keys
; - Set up a macro / keybind to the letter 'G' to read the following:
; 		/target nameofmaincharacter (where 'nameofmaincharacter' is the name of your main character)
; 		/focus
; 		/follow nameofmaincharacter
; 		/petfollow nameofmaincharacter
; 		/target focustarget
; The purpose of this is to allow your second character to always have your
; main as the focus, and will always be targeting what you are targeting.
; If your main toon selects a new target and want your secondary toons target
; to get updated, just press 'G' again. I just prefer 'G'. You can make this
; whatever you want.
;
; The Basic setup will allow your secondary character to have a /follow and /target
; bound to one single key, and allow you to make minor running adjustments by way
; of the arrow keys. QWEASD control player #1, UP DOWN LEFT RIGHT arrow keys
; will control player #2 [they must be bound properly in your wow keybindings

;**************************************************************
;********************** Top of Script *********************
;**************************************************************


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;Warn
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
hotkey, ^+c, close
onexit, close
SetBatchLines, -1
windowstyle := 2
WinGet, wowid, List, World of Warcraft
IfWinExist, ahk_id %wowid1% and winexist ahk_id %wowid2%
{	
	gosub, winrestore
	gosub, alwaysontopoff
	winmaximize, ahk_id %wowid1%
	w1a := A_ScreenWidth * .75
	h1a := A_ScreenHeight * .75
	w2a := A_ScreenWidth * .25
	h2a := A_ScreenHeight * .25
	winmove, ahk_id %wowid1%, ,0,0,%w1a%,%h1a%	
	WinGetPos, x1, y1, w1, h1, ahk_id %wowid1%
	gosub, winrestore
	winmove, ahk_id %wowid2%, ,%w1%,%h1%,%w2a%,%h2a%
	windowstyle := 1
	winmaximize, ahk_id %wowid1%
	winset, alwaysontop, on, ahk_id %wowid2%
	TrayTip , , Elemeno's Keycloner Loaded, 3, 1
	winactivate, ahk_id %wowid1%
 }
 else
 {
 msgbox, 16, Elemeno's Dual Boxing Keycloner, Please make sure you have both World of Warcraft windows open and running before starting.
 exitapp
 }
 
; Asks the user which window they want to be the main
msgbox, 4, Elemeno's Dual Boxing Keycloner, `nDo you want the large window to be your main window?,
ifmsgbox, Yes
{
}
ifmsgbox, No
{
gosub, alwaysontopoff
switch1 = %wowid1%
switch2 = %wowid2%
wowid1 := switch2
wowid2 := switch1
winmaximize, ahk_id %wowid1%
winmove, ahk_id %wowid2%, ,%w1%,%h1%,%w2a%,%h2a%
winset, alwaysontop, on, ahk_id %wowid2%
TrayTip , , Picture In Picture, 3, 1
winactivate, ahk_id %wowid1%
}

;******************* MENU INFORMATION *************************
Menu, tray, add, Window Style #1 [PiP], window1  ; Creates a new menu item.
Menu, tray, add, Window Style #2 [Split View], window2
Menu, tray, add, Window Style #3 [Maximized], window3

menu, tray, tip,  Elemeno's Dual Boxing Keycloner
return
 
;**************************************************************
;**************** START OF ALL THE HOTKEYS ******************
;**************************************************************
 
~Pause:: ; Pauses the script
Suspend, Toggle
if A_IsSuspended = 1
{
ToolTip, Elemeno's Dual Boxing Keycloner Suspended, A_ScreenWidth/2, A_ScreenHeight/2, 1
TrayTip, Elemeno's Dual Boxing Keycloner, SUSPENDED, 1, 1
soundplay, *63
}
if A_IsSuspended = 0
{
ToolTip, , 0, 0, 1
TrayTip, Elemeno's Dual Boxing Keycloner, RUNNING, 5, 1
soundplay, *64
}
Return
;--------------------------------------------------------------
~ScrollLock:: ; ScrollLock reloads the current script.
Reload
Return
;--------------------------------------------------------------
~F1:: ; Sets your defined primary window the the foreground
gosub, alwaysontopoff
if windowstyle = 1
{
gosub, winrestore
winmove, ahk_id %wowid2%, ,%w1%,%h1%,%w2a%,%h2a%
winmaximize, ahk_id %wowid1%
winset, alwaysontop, on, ahk_id %wowid2%
TrayTip , , WINDOW #1 [MAIN], 3, 1
winactivate, ahk_id %wowid1%
}
if windowstyle = 2
{
gosub, winrestore
winmove, ahk_id %wowid1%, ,0,0,%w1a%,%h1a%
winmove, ahk_id %wowid2%, ,%w1%,%h1%,%w2a%,%h2a%
TrayTip , , WINDOW #1 [MAIN], 3, 1
winactivate, ahk_id %wowid1%
}
if windowstyle = 3
{
winmaximize, ahk_id %wowid1%
winminimize, ahk_id %wowid2%
TrayTip , , WINDOW #1 [MAIN], 3, 1
winactivate, ahk_id %wowid1%
}
Return
;--------------------------------------------------------------
~F2:: ; Sets your defined secondary window the the foreground
gosub, alwaysontopoff
if windowstyle = 1
{
gosub, winrestore
winmove, ahk_id %wowid1%, ,%w1%,%h1%,%w2a%,%h2a%
winmaximize, ahk_id %wowid2%
winset, alwaysontop, on, ahk_id %wowid1%
TrayTip , , WINDOW #2, 3, 1
winactivate, ahk_id %wowid2%
}
if windowstyle = 2
{
gosub, winrestore
winmove, ahk_id %wowid1%, ,%w1%,%h1%,%w2a%,%h2a%
winmove, ahk_id %wowid2%, ,0,0,%w1a%,%h1a%
TrayTip , , WINDOW #2, 3, 1
winactivate, ahk_id %wowid2%
}
if windowstyle = 3
{
winmaximize, ahk_id %wowid2%
winminimize, ahk_id %wowid1%
TrayTip , , WINDOW #2 [MAIN], 3, 1
winactivate, ahk_id %wowid2%
}
Return
;--------------------------------------------------------------
window1:
{
~+F1:: ; Loads Window Profile #1
gosub, alwaysontopoff
gosub, winrestore
windowstyle := 1
winmaximize, ahk_id %wowid1%
winmove, ahk_id %wowid2%, ,%w1%,%h1%,%w2a%,%h2a%
winset, alwaysontop, on, ahk_id %wowid2%
TrayTip , , Picture In Picture, 3, 1
winactivate, ahk_id %wowid1%
Return
}
;--------------------------------------------------------------
window2:
{
~+F2:: ; Loads Window Profile #2
gosub, alwaysontopoff
gosub, winrestore
windowstyle := 2
winmove, ahk_id %wowid1%, ,0,0,%w1a%,%h1a%
winmove, ahk_id %wowid2%, ,%w1%,%h1%,%w2a%,%h2a%
TrayTip , , Split View, 3, 1
winactivate, ahk_id %wowid1%
Return
}
;--------------------------------------------------------------
window3:
{
~+F3:: ; Loads Window Profile #3
windowstyle := 3
winmaximize, ahk_id %wowid1%
winminimize, ahk_id %wowid2%
TrayTip , , Maximized, 3, 1
winactivate, ahk_id %wowid1%
return
} 
 
;**************************************************************
;*************** Standard Keyboard Hotkeys ****************
;**************************************************************
 
~1::
~2::
~3::
~4::
~5::
~6::
~7::
~8::
~9::
~0::
~-::
~=::
~q::
~w::
~e::
~r::
~t::
~y::
~u::
~i::
~o::
~p::
~[::
~]::
~a::
~s::
~d::
~f::
~g::
~h::
~j::
~k::
~l::
~;::
~'::
~z::
~x::
~c::
~v::
~b::
~n::
~m::
~,::
~.::
~`::
~/::
IfWinActive, ahk_id %wowid1%
{
StringTrimLeft, ThisKey, A_ThisHotKey, 1
ControlSend,, %ThisKey%, ahk_id %wowid2%
Return
}
IfWinActive, ahk_id %wowid2%
{
StringTrimLeft, ThisKey, A_ThisHotKey, 1
ControlSend,, %ThisKey%, ahk_id %wowid1%
Return
}
 
;**************************************************************
;************ SHIFT + Standard Keyboard Keys **************
;**************************************************************
 
~+1::
~+2::
~+3::
~+4::
~+5::
~+6::
~+7::
~+8::
~+9::
~+0::
~+-::
~+=::
~+q::
~+w::
~+e::
~+r::
~+t::
~+y::
~+u::
~+i::
~+o::
~+p::
~+[::
~+]::
~+a::
~+s::
~+d::
~+f::
~+g::
~+h::
~+j::
~+k::
~+l::
~+;::
~+'::
~+z::
~+x::
~+c::
~+v::
~+b::
~+n::
~+m::
~+,::
~+.::
~+`::
~+/::
IfWinActive, ahk_id %wowid1%
{
StringTrimLeft, ThisKey, A_ThisHotKey, 1
ControlSend,, {shift down}%thiskey%{shift up}, ahk_id %wowid2%
Return
}
IfWinActive, ahk_id %wowid2%
{
StringTrimLeft, ThisKey, A_ThisHotKey, 1
ControlSend,, {shift down}%thiskey%{shift up}, ahk_id %wowid1%
Return
}
 
;**************************************************************
;*************** Start of Special Hotkeys *****************
;**************************************************************
 
~Enter::
IfWinActive, ahk_id %wowid1%
{
ControlSend,, {Enter}, ahk_id %wowid2%
Return
}
IfWinActive, ahk_id %wowid2%
{
ControlSend,, {Enter}, ahk_id %wowid1%
Return
}
;--------------------------------------------------------------
~Tab::
IfWinActive, ahk_id %wowid1%
{
ControlSend,, {Tab}, ahk_id %wowid2%
Return
}
IfWinActive, ahk_id %wowid2%
{
ControlSend,, {Tab}, ahk_id %wowid1%
Return
}
;--------------------------------------------------------------
~Delete::
IfWinActive, ahk_id %wowid1%
{
ControlSend,, {Delete}, ahk_id %wowid2%
Return
}
IfWinActive, ahk_id %wowid2%
{
ControlSend,, {Delete}, ahk_id %wowid1%
Return
}
;--------------------------------------------------------------
~BackSpace::
IfWinActive, ahk_id %wowid1%
{
ControlSend,, {backspace}, ahk_id %wowid2%
Return
}
IfWinActive, ahk_id %wowid2%
{
ControlSend,, {backspace}, ahk_id %wowid1%
Return
}
;--------------------------------------------------------------
~Escape::
IfWinActive, ahk_id %wowid1%
{
ControlSend,, {escape}, ahk_id %wowid2%
Return
}
IfWinActive, ahk_id %wowid2%
{
ControlSend,, {escape}, ahk_id %wowid1%
Return
}
 
;**************************************************************
;********************** ARROW Keys ************************
;**************************************************************
 
~Up::
IfWinActive, World of Warcraft
{
ControlSend,, {up down}, ahk_id %wowid2%
loop
{
getkeystate, state, up
if state = U
break
}
ControlSend,, {up up}, ahk_id %wowid2%
Return
}
;--------------------------------------------------------------
~Down::
IfWinActive, World of Warcraft
{
ControlSend,, {down down}, ahk_id %wowid2%
loop
{
getkeystate, state, down
if state = U
break
}
ControlSend,, {down up}, ahk_id %wowid2%
Return
}
;--------------------------------------------------------------
~Left::
IfWinActive, World of Warcraft
{
ControlSend,, {Left down}, ahk_id %wowid2%
loop
{
getkeystate, state, Left
if state = U
break
}
ControlSend,, {Left up}, ahk_id %wowid2%
Return
}
;--------------------------------------------------------------
~Right::
IfWinActive, World of Warcraft
{
ControlSend,, {Right down}, ahk_id %wowid2%
loop
{
getkeystate, state, Right
if state = U
break
}
ControlSend,, {Right up}, ahk_id %wowid2%
Return
}

~Space::
IfWinActive, World of Warcraft
{
ControlSend,, {Space down}, ahk_id %wowid2%
loop
{
getkeystate, state, Space
if state = U
break
}
ControlSend,, {Space up}, ahk_id %wowid2%
Return
}
 
;**************************************************************
;************************ CLOSE ***************************
;**************************************************************

close:
winset, alwaysontop, off, ahk_id %wowid1%
winset, alwaysontop, off, ahk_id %wowid2%
winmove, ahk_id %wowid1%, ,0,0,640,389
winmove, ahk_id %wowid2%, ,50,50,640,389
exitapp

 
;**************************************************************
;*******************  Windows to Backround ********************
;**************************************************************

alwaysontopoff:
winset, alwaysontop, off, ahk_id %wowid1%
winset, alwaysontop, off, ahk_id %wowid2%
return 

;**************************************************************
;*******************  Windows Restored *** ********************
;**************************************************************

winrestore:
winrestore, ahk_id %wowid1%
winrestore, ahk_id %wowid2%
return

;**************************************************************
;******************* Revision History **********************
;**************************************************************

; 01/07/2013.1
; Added Window View #3 [Maximized]
; Added check for both warcraft windows being open
; Changed default view to Window View #1 
; Added variables ScreenHeight and ScreenWidth to determine window sizes
; Added Menu Shortcuts
; Revised Space hotkey to fix flying issues with second character
 
 
; 01/03/2013.1
; Added variable size windows
; Added use control of main window
; Fixed minor bugs
 
; 01/02/2013.1
; Initial version