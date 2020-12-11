# Backup-and-download-songs-from-deemix

REQUIRED SETUP
1. install AHK https://www.autohotkey.com/
2. all the songs you currently have downloaded MUST be in this format (if you want to change it, modify the code yourself): 

%artist% - %title% - %track_id%

Example: Feint - Signs - 91899970

If they are not, you must redownload or rename them all manually. Before that set the template for your future song downloads https://imgur.com/a/VhrnDRQ.

RUNNING IT

On the computer with your downloaded songs:
1. change C:\My files\Music in line 15 to your deemix download directory in Get list of songs from storage.ahk 
2. Run Get list of songs from storage.ahk

On the computer to download your songs to:
1. Make a copy of the text file showing your total number of songs
2. Launch deemix
3. Run Download all songs.ahk
3. Once all the songs are downloaded, run Get list of songs from storage and check if the total number of songs are the same, meaning all songs were properly downloaded

Example of script downloading 168 songs.
