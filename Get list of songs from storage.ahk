#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#NoTrayIcon
#Include %A_ScriptDir%\tf.ahk

/*
#Warn
SetKeyDelay, 1
SetMouseDelay, 1
SetWinDelay, 1
*/

FileDelete, *.txt
FileAppend, % list_files("C:\My files\Music"), Music.txt

TF_RemoveBlankLines("!Music.txt")
TF_Replace("!Music.txt",".mp3","")
;Sorting (used instead of TF_Sort because it is bugged and deletes the last character in the last line (as of version 3.7))
FileRead, Contents, Music.txt
Sort, Contents
FileDelete, Music.txt
FileAppend, %Contents%, Music.txt

TF_RegExReplaceInLines("Music.txt", 1, 0, " - \d+$","")
FileMove, Music_copy.txt, Artist - Song.txt

TF_RegExReplace("Music.txt",".+ - ","")
FileMove, Music_copy.txt, Trackids.txt

TF_InsertPrefix("Trackids.txt",1,0, "https://www.deezer.com/us/track/") 
FileMove, Trackids_copy.txt, Links.txt

TF_InsertSuffix("Artist - Song.txt",1,0, " - ")
FileMove, Artist - Song_copy.txt, Artist - Song - Link.txt
TF_ConCat("Artist - Song - Link.txt","Links.txt","Artist - Song - Link.txt")

Total_songs := TF_CountLines("Links.txt")
FileAppend, %Total_songs%, Total songs = %Total_songs%.txt
FileDelete, Music.txt

list_files(Directory)
{
	files =
	Loop, Files, %Directory%\*.mp3, F R
	{
		files = %files%%A_LoopFileName%`n
	}
	return files
}