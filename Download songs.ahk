#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SendMode Input
SetKeyDelay, 1
SetMouseDelay, 1
SetWinDelay, 1
#NoTrayIcon
#Include tf.ahk

Msgbox, Launch deemix then press OK.
WinActivate, ahk_exe deemix-pyweb.exe
send ^f{escape}
Loop, read, Links.txt
{
	Clipboard := A_LoopReadLine
	sendEvent ^v
	sleep 1
	send {enter}{escape}
}

sleep 10
MsgBox, Operation complete. After all songs are finished downloading, run "Check and download missing songs.ahk" to check if any songs are missing and to download them.