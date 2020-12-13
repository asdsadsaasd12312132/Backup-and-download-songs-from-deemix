#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#NoTrayIcon
#Include %A_ScriptDir%\tf.ahk
#Include %A_ScriptDir%\id3read_trimmed.ahk

mode := 2
sort := true ;true = sort; anything else = doesn't
include_deemix_links := true ;true = include deemix links; anything else = doesn't
Music_collection_directory := "C:\My files\Music"

FileDelete, Song info (mode %mode%).txt
if mode = 1
{
	id3_tag_combination := "taaly"
}
else if mode = 2
{
	id3_tag_combination := "taa"
}
else if mode = 3
{
	id3_tag_combination := "aat"
}
else if mode = 4
{
	id3_tag_combination := "at"
}

mp3_tags =
filename = 
Loop, Files, %Music_collection_directory%\*.mp3, F R
{
	mp3_tags =  % mp3_tags id3read_trimmed(A_LoopFileFullPath, id3_tag_combination)"`n"
	filename = %filename%%A_LoopFileName%`n
}
FileAppend, %mp3_tags%, Song info.txt
FileAppend, %filename%, Song file names.txt
TF_RemoveDuplicateLines("!Song info.txt",1,0,1,false)
TF_RemoveDuplicateLines("!Song file names.txt",1,0,1,false)
TF_RemoveBlankLines("!Song info.txt")
TF_RemoveBlankLines("!Song file names.txt")

;Trackids
TF_RegExReplace("!Song file names.txt",".+ - ","")
TF_RegExReplace("!Song file names.txt","m).mp3$","")
FileMove, Song file names.txt, Trackids.txt, 1

;Links
TF_InsertPrefix("Trackids.txt",1,0, "https://www.deezer.com/us/track/") 
FileMove, Trackids_copy.txt, Links.txt, 1

;Include deemix links
if (include_deemix_links = true)
{
	TF_InsertSuffix("!Song info.txt",1,0, " - ")
	TF_ConCat("Song info.txt","Links.txt","Song info.txt")	
}

;Total songs
Total_songs := TF_CountLines("Song info.txt")
FileDelete, Total songs = *.txt
FileAppend, %Total_songs%, Total songs = %Total_songs%.txt

;Describe mode
if (sort = true)
{
	TF_Sort("!Song info.txt", "", 1, 0)
}
FileMove, Song info.txt, Song info (mode %mode%).txt
