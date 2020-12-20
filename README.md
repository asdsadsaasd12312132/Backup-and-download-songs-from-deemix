# Backup-and-download-songs-from-deemix
## OVERVIEW
This script can work with or without deemix. Without deemix, it can generate a text file containing the following information for all your songs:

•	title - artist - album - length - year 

•	title - artist - album 

•	artist - album - title 

•	artist - title 

This can be used to keep a list of your music collection, which can be used to find the song on music streaming and download sites or to share with others. If used with deemix, it can generate a list containing the song's track id on deezer and the link to the song on deezer and 

## REQUIREMENTS
There are no requirements to use it without deemix. To use it with deemix, the deezer track id of the song must be appended to the end of the song's file name in this format

anything - %track_id%

Example

Feint - Signs - 91899970

If they are not, you must redownload or rename them manually. If redownloading, set the template for your future song downloads in deemix first. To manually get the track id for renaming, search for the song on https://www.deezer.com/us/ and copy the trackid in the address bar, e.g. 122291592 for https://www.deezer.com/us/track/122291592.

## PARAMETERS
There are 4 modes. Each mode changes the layout for the output in the Song info text file.

Mode 1 (taaly): title - artist - album - length - year 
This has all the information you would ever need to manually find a song but "length" and "year" are unnecessary, so it pointlessly inflates the processing time.

Mode 2 (taa): title - artist - album 
This combination is ideal because it has been confirmed to be able to find any song on any music streaming and download sites.

Mode 3 (aat): artist - album - title 
This combination is best for managing your songs, particularly playlist creation, but is unnecessary if using foobar2000 to search for artist tags rather than file names.

Mode 4 (at): artist - title 
Same as the previous mode but omits album because it is usually unnecessary.
The other parameters sort, include_deemix_links, and Music_collection_directory are self-explanatory.

## DOWNLOADING SONGS FROM DEEMIX
On the computer with your downloaded songs:
1.	configure the parameters in Back up songs.ahk as needed; "include_deemix_links" must be set to true 
2.	run Back up songs.ahk

On the computer to download your songs to:
1.	launch deemix
2.	run Download songs.ahk and follow the instructions from the prompts

## FINDING SONGS ON MUSIC STREAMING AND DOWNLOAD SITES
The format song name - artists - album will successfully find almost all songs. If it fails, first try deleting the hyphens that separate the tags (" -"). This is usually required on Spotify. If it still fails, try deleting anything in brackets for the song name, e.g. from

Letting Go (feat. PRYVT RYN) Panuma; Marvin Vogel; PRYVT RYN Letting Go (feat. PRYVT RYN)

to 

Letting Go Panuma; Marvin Vogel; PRYVT RYN Letting Go (feat. PRYVT RYN)
