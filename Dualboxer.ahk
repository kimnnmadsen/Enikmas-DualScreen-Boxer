;**************************************************************
;Enikmas DualScreen Boxer for World of Warcraft
;Current Version 27-01-2020
;Original Scirpt by Elemeno's Keycloner Loaded
;Feel free to use / modify this code as needed
;**************************************************************
 
;HowTo:
;**************************************************************
; -Log into WoW with 2 separate windows.
; -Start the program
; -Pressing F1 will make Window #1 the primary window
; -Pressing F2 will make Window #2 the primary window
; -Pressing <Scroll Lock> will reload the script
; -Pressing 'Pause' to temporarily suspend the program
;
; To close the program use <CTRL>+<SHIFT>+C at anytime
; Basic Setup:
;
; For WoW Instance #2 [Your secondary character]
; - Bind the movement keys to the arrow keys
; - Set up a macro / keybind to the letter 'G' to read the following:
; 		/target nameofmaincharacter
; 		/focus
; 		/follow nameofmaincharacter
; 		/petfollow nameofmaincharacter
; 		/target focustarget


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;Warn
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
hotkey, ^+c, close
onexit, close
SetBatchLines, -1
WinGet, wowid, List, World of Warcraft
IfWinExist, ahk_id %wowid1% and winexist ahk_id %wowid2%
{	
    gosub, pip
    
 }
 else
 {
 msgbox, 16, Enikmas DualScreen Boxer, Make sure you have both World of Warcraft windows open and running before starting.
 exitapp
 }
 

;**************************************************************
;**************** START OF ALL THE HOTKEYS ******************
;**************************************************************
 
~Pause:: ; Pauses the script
Suspend, Toggle
if A_IsSuspended = 1
{
gosub, alwaysontopoff
ToolTip, Enikmas DualScreen Boxer Suspended, A_ScreenWidth/2, A_ScreenHeight/2, 1
}
if A_IsSuspended = 0
{
ToolTip, , 0, 0, 1
ToolTip, Enikmas DualScreen Boxer Resumed, A_ScreenWidth/2, A_ScreenHeight/2, 1
}
Return
;--------------------------------------------------------------
~ScrollLock:: ; ScrollLock reloads the current script.
Reload
ToolTip, Enikmas DualScreen Boxer Reloaded, A_ScreenWidth/2, A_ScreenHeight/2, 1
Return
;--------------------------------------------------------------


~F1:: ; Sets your defined primary window the the foreground
gosub, dualscreen
Return 
~F2:: ; Sets your defined primary window the the foreground
gosub, pip
Return 
~+Tab:: ; Sets your defined secondary window the the foreground
gosub, swap
Return


dualscreen:
gosub, alwaysontopoff
gosub, winrestore
w1a := A_ScreenWidth * 1
h1a := A_ScreenHeight * 1
w2a := A_ScreenWidth * 1
h2a := A_ScreenHeight * 1
w1 := A_ScreenWidth * 1
h1 := 0
winmove, ahk_id %wowid1%, ,0,0,%w1a%,%h1a%	
winmove, ahk_id %wowid2%, ,%w1%,%h1%,%w2a%,%h2a%
winmaximize, ahk_id %wowid1%
winset, alwaysontop, on, ahk_id %wowid2%
winactivate, ahk_id %wowid1%
Return


pip:
w2a := A_ScreenWidth * .25
h2a := A_ScreenHeight * .25
w1 := 0
h1 := 0
winmove, ahk_id %wowid1%, ,0,0,%w1a%,%h1a%
WinGetPos, x1, y1, w1, h1, ahk_id %wowid1%
winmove, ahk_id %wowid2%, ,0,0,%w2a%,%h2a%
winmaximize, ahk_id %wowid1%
winset, alwaysontop, on, ahk_id %wowid2%
winactivate, ahk_id %wowid1%
Return

swap:
switch1 = %wowid1%
switch2 = %wowid2%
wowid1 := switch2
wowid2 := switch1
return


close:
gosub, alwaysontopoff
exitapp

alwaysontopoff:
winset, alwaysontop, off, ahk_id %wowid1%
winset, alwaysontop, off, ahk_id %wowid2%
return 

winrestore:
winrestore, ahk_id %wowid1%
winrestore, ahk_id %wowid2%
return

;**************************************************************
;*************** Standard Keyboard Hotkeys ****************
;**************************************************************

~1::
~2::
~3::
~g::
~f::
~q::
~e::
~r::


IfWinActive, ahk_id %wowid1%
{
StringTrimLeft, ThisKey, A_ThisHotKey, 1
ControlSend,, %ThisKey%, ahk_id %wowid2%
Return
}

 
;**************************************************************
;************ SHIFT + Standard Keyboard Keys **************
;**************************************************************
 
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
;*************** Special Hotkeys *****************
;**************************************************************


~Numpad0::
ControlSend,, {Numpad0}, ahk_id %wowid2%
Return


~Numpad1::
ControlSend,, {Numpad1}, ahk_id %wowid2%
Return

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
Return

 
;**************************************************************
;********************** Movement Keys ************************
;**************************************************************
IfWinActive, World of Warcraft
{
~Up::
ControlSend,, {Up down}, ahk_id %wowid2%
Keywait,Up,up
ControlSend,, {Up up}, ahk_id %wowid2%
Return

~Down::
ControlSend,, {Down down}, ahk_id %wowid2%
Keywait,Down,up
ControlSend,, {Down up}, ahk_id %wowid2%
Return

~Left::
ControlSend,, {Left down}, ahk_id %wowid2%
Keywait,Left,up
ControlSend,, {Left up}, ahk_id %wowid2%
Return
}

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

