#NoEnv
SetWorkingDir %A_ScriptDir%
#SingleInstance Force
#NoTrayIcon
#Include %A_ScriptDir%\tf.ahk

mode := 2
sort := true ;true = sort; anything else = doesn't
include_deemix_links := true ;true = include deemix links; anything else = doesn't
Music_collection_directory := "C:\My files\Music"

Loop, Files, *.txt
{
	FileDelete, %A_LoopFileFullPath%
}

objShell := ComObjCreate("Shell.Application")
global objShell
mp3_tags =
filename = 
if mode = 1
{
	Loop, Files, %Music_collection_directory%\*.mp3, R
	{
		;Get all file names for trackid extraction later
		filename = %filename%%A_LoopFileName%`n

		;Get id3/mp3 tags
		mp3_tags =  % mp3_tags id3read_taaly(A_LoopFileName, A_LoopFileDir)"`n"
	}
}
else if mode = 2
{
	Loop, Files, %Music_collection_directory%\*.mp3, R
	{
		;Get all file names for trackid extraction later
		filename = %filename%%A_LoopFileName%`n

		;Get id3/mp3 tags
		mp3_tags =  % mp3_tags id3read_taa(A_LoopFileName, A_LoopFileDir)"`n"
	}
}
else if mode = 3
{
	Loop, Files, %Music_collection_directory%\*.mp3, R
	{
		;Get all file names for trackid extraction later
		filename = %filename%%A_LoopFileName%`n

		;Get id3/mp3 tags
		mp3_tags =  % mp3_tags id3read_aat(A_LoopFileName, A_LoopFileDir)"`n"
	}
}
else if mode = 4
{
	Loop, Files, %Music_collection_directory%\*.mp3, R
	{
		;Get all file names for trackid extraction later
		filename = %filename%%A_LoopFileName%`n

		;Get id3/mp3 tags
		mp3_tags =  % mp3_tags id3read_at(A_LoopFileName, A_LoopFileDir)"`n"
	}
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
FileAppend, %Total_songs%, Total songs.txt

;Describe mode
if (sort = true)
{
	TF_Sort("!Song info.txt", "", 1, 0)
}
FileMove, Song info.txt, Song info (mode %mode%).txt

;Functions
id3read_taa(FileName,FileDir)
{
	oDir := objShell.NameSpace(FileDir)
	oMP3 := oDir.ParseName(FileName)
	return oDir.GetDetailsOf(oMP3, 21) " - " oDir.GetDetailsOf(oMP3, 13) " - " oDir.GetDetailsOf(oMP3, 14)
}

id3read_aat(FileName,FileDir)
{
	oDir := objShell.NameSpace(FileDir)
	oMP3 := oDir.ParseName(FileName)
	return oDir.GetDetailsOf(oMP3, 13) " - " oDir.GetDetailsOf(oMP3, 14) " - " oDir.GetDetailsOf(oMP3, 21)
}

id3read_taaly(FileName,FileDir)
{
	oDir := objShell.NameSpace(FileDir)
	oMP3 := oDir.ParseName(FileName)
	return oDir.GetDetailsOf(oMP3, 21) " - " oDir.GetDetailsOf(oMP3, 13) " - " oDir.GetDetailsOf(oMP3, 14) " - " oDir.GetDetailsOf(oMP3, 27) " - " oDir.GetDetailsOf(oMP3, 15)
}

id3read_at(FileName,FileDir)
{
	oDir := objShell.NameSpace(FileDir)
	oMP3 := oDir.ParseName(FileName)
	return oDir.GetDetailsOf(oMP3, 13) " - " oDir.GetDetailsOf(oMP3, 21)
}