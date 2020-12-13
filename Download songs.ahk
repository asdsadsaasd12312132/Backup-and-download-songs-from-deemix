#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetKeyDelay, 1
SetMouseDelay, 1
SetWinDelay, 1
#NoTrayIcon
#Include %A_ScriptDir%\tf.ahk

Msgbox, Launch deemix then press OK. Use F1 to stop if necessary.
WinActivate, ahk_exe deemix-pyweb.exe
send ^f{escape}
Total_songs := TF_CountLines("Links.txt")
Line_to_read := 1
Loop, %Total_songs%
{
	Clipboard := ""
	FileReadLine, Clipboard, Links.txt, %Line_to_read%
	ClipWait
	send ^v{enter}{escape}

	Line_to_read := Line_to_read + 1
	sleep 25
}
ExitApp

f1::
ExitApp
return
