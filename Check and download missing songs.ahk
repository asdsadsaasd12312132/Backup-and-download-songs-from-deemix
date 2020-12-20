#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
SetKeyDelay, 1
#Include tf.ahk

Loop, Files, C:\My files\Music\*.mp3, R
    Total_songs_current := A_Index

Total_songs_previous := TF_CountLines("Trackids.txt")

if (Total_songs_current < Total_songs_previous)
{
	Loop, Files, C:\My files\Music\*.mp3, R
	{
		;Get all file names for trackid extraction later
		filename = %filename%%A_LoopFileName%`n
	}
	FileAppend, %filename%, Song file names temp.txt
	TF_RemoveDuplicateLines("!Song file names temp.txt",1,0,1,false)
	TF_RemoveBlankLines("!Song file names temp.txt")

	;Trackids
	TF_RegExReplace("!Song file names temp.txt",".+ - ","")
	TF_RegExReplace("!Song file names temp.txt","m).mp3$","")
	FileMove, Song file names temp.txt, Missing songs.txt, 1

	;Find missing songs
	TF_Append("Trackids.txt", "Missing songs.txt")
	TF_RemoveDuplicateLines("!Missing songs.txt", , , 2) ;consecutive = 2 uses the custom mod from https://github.com/hi5/TF/issues/12
	TF_RemoveBlankLines("!Missing songs.txt")
	TF_InsertPrefix("!Missing songs.txt",1,0, "https://www.deezer.com/us/track/") 

	;Download missing songs
	Missing_songs := TF_CountLines("Missing songs.txt")
	MsgBox, %Missing_songs% missing song(s) will now be downloaded. Launch deemix then click OK. Use F1 to stop the script if necessary.
	WinActivate, ahk_exe deemix-pyweb.exe
	send ^f{escape}
	Loop, read, Missing songs.txt
	{
		Clipboard := ""
		Clipboard := A_LoopReadLine
		ClipWait
		sleep 1
		send ^v{enter}{escape}
	}

	sleep 10
	FileDelete, Missing songs.txt
	MsgBox, Operation complete. Re-run this script afterwards to check if any songs are missing and to download them (repeat until no songs are missing).
}
else
{
	MsgBox, No songs are missing.
}
ExitApp

f1::
ExitApp
return