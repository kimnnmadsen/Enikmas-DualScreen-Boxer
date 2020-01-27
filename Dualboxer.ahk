;**************************************************************
;Enikmas DualScreen Boxer for World of Warcraft
;Current Version 27-01-2020
;Original Scirpt by Elemeno's Keycloner Loaded
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
	w1a := A_ScreenWidth * 1
	h1a := A_ScreenHeight * 1
	w2a := A_ScreenWidth * 1
	h2a := A_ScreenHeight * 1
	winmove, ahk_id %wowid1%, ,0,0,%w1a%,%h1a%	
	WinGetPos, x1, y1, w1, h1, ahk_id %wowid1%
	gosub, winrestore
	winmove, ahk_id %wowid2%, ,1920,0,1920,1080
	windowstyle := 1
	winmaximize, ahk_id %wowid1%
	winset, alwaysontop, on, ahk_id %wowid2%
	TrayTip , , Enikmas DualScreen Boxer, 3, 1
	winactivate, ahk_id %wowid1%
 }
 else
 {
 msgbox, 16, Enikmas DualScreen Boxer, Make sure you have both World of Warcraft windows open and running before starting.
 exitapp
 }
 
; Asks the user which window they want to be the main
msgbox, 4, Enikmas DualScreen Boxer, `nDo you want to swap characters?,
ifmsgbox, Yes
{
gosub, alwaysontopoff
switch1 = %wowid1%
switch2 = %wowid2%
wowid1 := switch2
wowid2 := switch1
winmove, ahk_id %wowid1%, ,0,0,%w1a%,%h1a%	
WinGetPos, x1, y1, w1, h1, ahk_id %wowid1%
gosub, winrestore
winmove, ahk_id %wowid2%, ,1920,0,1920,1080
windowstyle := 1
winmaximize, ahk_id %wowid1%
winset, alwaysontop, on, ahk_id %wowid2%
winactivate, ahk_id %wowid1%
}
ifmsgbox, No
{
}

;**************************************************************
;**************** START OF ALL THE HOTKEYS ******************
;**************************************************************
 
~Pause:: ; Pauses the script
Suspend, Toggle
if A_IsSuspended = 1
{
ToolTip, Enikmas DualScreen Boxer Suspended, A_ScreenWidth/2, A_ScreenHeight/2, 1
TrayTip, Enikmas DualScreen Boxer, SUSPENDED, 1, 1
soundplay, *63
}
if A_IsSuspended = 0
{
ToolTip, , 0, 0, 1
TrayTip, Enikmas DualScreen Boxer, RUNNING, 5, 1
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
gosub, winrestore
winmove, ahk_id %wowid2%, ,1920,0,1920,1080
winmaximize, ahk_id %wowid1%
winset, alwaysontop, on, ahk_id %wowid2%
winactivate, ahk_id %wowid1%
Return
;--------------------------------------------------------------
~F2:: ; Sets your defined secondary window the the foreground
gosub, alwaysontopoff
gosub, winrestore
winmove, ahk_id %wowid1%, ,1920,0,1920,1080
winmaximize, ahk_id %wowid2%
winset, alwaysontop, on, ahk_id %wowid1%
TrayTip , , WINDOW #2, 3, 1
winactivate, ahk_id %wowid2%
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
winactivate, ahk_id %wowid1%
Return
}

;**************************************************************
;*************** Standard Keyboard Hotkeys ****************
;**************************************************************

~Numpad1::
~Numpad2::
~Numpad3::
~Numpad4::
~Numpad5::
~Numpad6::
~Numpad7::
~Numpad8::
~Numpad9::
~Numpad0::
~g::

IfWinActive, ahk_id %wowid1%
{
StringTrimLeft, ThisKey, A_ThisHotKey, 1
ControlSend,, %ThisKey%, ahk_id %wowid2%
Return
}

 
;**************************************************************
;************ SHIFT + Standard Keyboard Keys **************
;**************************************************************
 
~+Numpad1::
~+Numpad2::
~+Numpad3::
~+Numpad4::
~+Numpad5::
~+Numpad6::
~+Numpad7::
~+Numpad8::
~+Numpad9::
~+Numpad0::
~+g::

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
winmove, ahk_id %wowid1%, ,1920,0,1920,1080
winmove, ahk_id %wowid2%, ,1920,0,1920,1080
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
