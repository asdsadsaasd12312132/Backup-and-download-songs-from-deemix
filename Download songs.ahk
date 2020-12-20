#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetKeyDelay, 1
SetMouseDelay, 1
SetWinDelay, 1
#NoTrayIcon
#Include tf.ahk

Msgbox, Launch deemix then press OK. Use F1 to stop if necessary.
WinActivate, ahk_exe deemix-pyweb.exe
send ^f{escape}
Loop, read, Links.txt
{
	Clipboard := ""
	Clipboard := A_LoopReadLine
	ClipWait
	sleep 1
	send ^v{enter}{escape}
}

sleep 10
MsgBox, Operation complete. After all songs are finished downloading, run "Check and download missing songs.ahk" to check if any songs are missing and to download them.
ExitApp

f1::
ExitApp
return
