@echo off
color 0f
title Music Manager
setlocal enabledelayedexpansion
set "musicFolder=%userprofile%\desktop\songs" :: Change the directory to where your music is located

set "option=%~1"

if /I "%option%"=="-list" (
   call :loopDirectory %2
exit /b
) else if /I "%option%"=="-l" (
    call :loopDirectory %2
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
    call :playRandomSong %2
    exit /b
)

if /I "%option%"=="-p" (
  call :playMusic %2 %3
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
if not "%~2"=="" (
    set "musicFolder=%~2"
)
 if not exist "%musicFolder%" (
        echo Couldn't find folder named '%musicFolder%'.
    exit /b
)

for %%a in ("%musicFolder%\*.mp3") do (
    set "current=%%~nxa"
    if "!current:%songName%=!" neq "!current!" (
        echo Playing song: !current!
        start /b "" "%%a"
        exit /b
    )
)
echo Couldn't find song: '%songName%'
exit /b

:loopDirectory
set "directoryPath=%~1"
echo %directoryPath%
if "%directoryPath%"=="" (
    set "directoryPath=%musicFolder%"
)

if not exist "%directoryPath%" (
    echo Couldn't find folder named '%directoryPath%'.
    exit /b
)

set songCount=0
for %%a in ("%directoryPath%\*.mp3") do (
    set /a songCount+=1
)

if !songCount! equ 0 (
    echo couldn't find any songs in %directoryPath%.
    exit /b
)

for %%b in ("%directoryPath%\*.mp3") do (
    echo %%~nxb
)
exit /b

:downloadSong 

if not exist "%~dp0DownloadMP3.exe" (
    echo Couldn't find DownloadMP3.exe. Make it's place in the same folder as batch file!
    exit /b
)
if "%2"=="" (
"%~dp0DownloadMP3.exe" %musicFolder% %~1
    exit /b
)
"%~dp0DownloadMP3.exe" %~1 %~2
exit /b

:playRandomSong
if not "%~1"=="" (
    set "musicFolder=%~1"
)

if not exist %musicFolder% (
   echo Couldn't find Folder named '%musicFolder%'.
    exit /b
 )
set songCount=0
 for %%a in ("%musicFolder%\*.mp3") do (
        set /a songCount+=1
    )   

 if %songCount% equ 0 (
        echo There are no songs in this folder! %musicFolder%
    )

SET /A "selectedSong=1 + %RANDOM% %% %songCount%"
set songCount=0
     for %%b in ("%musicFolder%\*.mp3") do (
        set /a songCount+=1
        if !songCount! equ %selectedSong% (
            echo Playing: %%~nxb
             start /b "" "%%b"
        exit /b
        )
    )
    exit /b

:displayHelp
echo Usage: 
echo.
echo -list, -l [directory_path]           List all songs in the specified directory.
echo                     Example: music -list C\Users\bob\songs\
echo.
echo -p ^<song_name^> [directory_path]      Play the specified song.
echo                     Example: music -p  "Timmy Trumpet & KSHMR - Toca" C:\Users\bob\Songs
echo.
echo -d [directory_path] ^<YouTube_link^>       
echo                     Download a YouTube song and save it to the specified directory.
echo                     Example: music -d C:\Users\bob\songs\ "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
echo.
echo -r [directory_path]                  Play a randomly selected song from the specified directory.
echo                     Example: music -r C:\Users\bob\songs\
echo.
echo -h, --help          Display this help message.
echo.
echo Note:
echo - Optional directory argument is the folder path where the command will be executed. If not provided,
echo   the default music directory specified in the script will be used.
echo.
exit /b