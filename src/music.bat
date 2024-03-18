@echo off
color 0f
title Music Manager
setlocal enabledelayedexpansion
set "musicFolder=%userprofile%\desktop\nice"
set "option=%~1"

if /I "%option%"=="-list" (
   call :loopDirectory %~2
exit /b
) else if /I "%option%"=="-l" (
   call :loopDirectory %~2
exit /b
) else if /I "%option%"=="-h" (
   call :displayHelp
exit /b
) else if /I "%option%"=="--help" (
   call :displayHelp
exit /b
) else if /I "%option%"=="-d" (
    call :downloadSong %2 %3
    exit /b
) else if /I "%option%"=="-r" (
    call :playRandomSong
    exit /b
)

if /I "%option%"=="-p" (
  call :playMusic %~2
  exit /b
)

echo Invalid switch: %option%. Use -h or --help for usage information.
exit /b

:playMusic
set "songName=%~1"

 if "%songName%"=="" (
    echo No song was provided!
    exit /b
)
@REM  if not exist "%musicPath%" (
@REM     echo Provided music does not exist! Please provide correct path.
@REM     exit /b
@REM )

for %%a in ("%musicFolder%\*.mp3") do (
    set "current=%%~nxa"
    @REM echo currently at !current!
    if "!current:%songName%=!" neq "!current!" (
        echo Playing song %%a
        start /b "" "%%a"
        exit /b
    )
)
echo Song not found: %songName%
exit /b

:loopDirectory
if not exist %musicFolder% (
  set "newMusicFolderPath=%~1"
  if not exist !newMusicFolderPath! (
    echo Couldn't find folder at path: !newMusicFolderPath!.
    exit /b
  )
  set musicCount=0
  for %%b in ("!newMusicFolderPath!\*.mp3") do (
        set /a musicCount+=1
  )
    if !musicCount! equ 0 (
        echo Couldn't find any song in folder !newMusicFolderPath!.
        exit /b
    )
echo Listing all songs in the directory:
    for %%a in ("!newMusicFolderPath!\*.mp3") do (
        echo %%~nxa
    )
    exit /b

)
 echo Listing all songs in the directory:
    for %%a in ("%musicFolder%\*.mp3") do (
        echo %%~nxa
    )
    exit /b

:downloadSong 
if not exist "%~dp0DownloadMP3.exe" (
    echo Couldn't find DownloadMP3.exe! Make sure you place it in the same folder as the batch script.
    exit /b
)
echo %*
"%~dp0DownloadMP3.exe" %~1 %~2
exit /b

:playRandomSong
set songsCount=0
 for %%a in ("%musicFolder%\*.mp3") do (
        set /a songsCount +=1
    )   

SET /A "selectedSong=1 + %RANDOM% %% %songsCount%"
set songsCount=0
     for %%b in ("%musicFolder%\*.mp3") do (
        set /a songsCount+=1
    echo !songsCount!
        if !songsCount! equ %selectedSong% (
            echo playing random song!
             start /b "" "%%b"
        exit /b
        )
    )
    exit /b


:displayHelp
echo Usage: 
echo -list, -l: List all songs in the directory
echo -p [song name]: Play the specified song
echo -h, --help: Display this help message
echo -d [directory] [YouTube link]: Allows you to download a YouTube song and save it to the destined folder.
echo -r: Allows you to play random song in given directory
exit /b
