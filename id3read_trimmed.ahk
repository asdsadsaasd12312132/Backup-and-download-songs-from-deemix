id3read_trimmed(filename,object="msg")
{
	objShell := ComObjCreate("Shell.Application")
	SplitPath,filename , ename,edir
	oDir := objShell.NameSpace(eDir)
	oMP3 := oDir.ParseName(eName)
	  
	;id3 tags
	if (object = "taa") or (object = "aat")
	{
		artist := oDir.GetDetailsOf(oMP3, 13)
		album := oDir.GetDetailsOf(oMP3, 14)
		title := oDir.GetDetailsOf(oMP3, 21)
	}
	else if (object = "taaly")
	{
		artist := oDir.GetDetailsOf(oMP3, 13)
		album := oDir.GetDetailsOf(oMP3, 14)
		length := oDir.GetDetailsOf(oMP3, 27)
		title := oDir.GetDetailsOf(oMP3, 21)
		year := oDir.GetDetailsOf(oMP3, 15)
	}
	else if (object = "at")
	{
		artist := oDir.GetDetailsOf(oMP3, 13)
		title := oDir.GetDetailsOf(oMP3, 21)
	}

	;id3 tag combinations (can add your own)
	;see the documentation for an explanation of the modes/id3 tag combinations
	taaly := title " - " artist " - " album " - " length " - " year
	taa := title " - " artist " - " album
	aat := artist " - " album " - " title
	at := artist " - " title

	msg:=%object%
	return msg
}