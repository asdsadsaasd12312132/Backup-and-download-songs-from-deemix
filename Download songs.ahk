#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SendMode Input
SetWinDelay, 1
#NoTrayIcon
#Include tf.ahk

Msgbox, Launch deemix then press OK.
WinActivate, ahk_exe deemix-pyweb.exe
send ^f{escape}
Loop, read, Links.txt
{
	Clipboard := A_LoopReadLine
	sleep 1 ;separate SendEvent and SendInput to avoid bugs
	send ^v{enter}{escape}
	sleep 1
}

sleep 10
MsgBox, Operation complete. After all songs are finished downloading, run "Check and download missing songs.ahk" to check if any songs are missing and to download them.