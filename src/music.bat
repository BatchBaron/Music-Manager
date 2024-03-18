@echo off
color 0f
title Music Manager
setlocal enabledelayedexpansion
set "musicFolder=%userprofile%\desktop\Songs"
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

:displayHelp
echo Usage: 
echo -list, -l: List all songs in the directory
echo -p [song name]: Play the specified song
echo -h, --help: Display this help message
exit /b
