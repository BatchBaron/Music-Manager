# Music Manager Batch Script

## Overview

Music Manager is a command-line batch script designed to enhance your music listening experience directly from the console. It provides a range of features that allow you to manage and play your music with ease.

## Features

- **List Songs**: Displays all songs in a specified directory.
- **Play a Song**: Plays a specific song.
- **Download a Song**: Downloads a song from YouTube and saves it to a specified directory.
- **Play a Random Song**: Plays a randomly selected song from a specified directory.
- **Help**: Displays usage information.

## Commands

- `-list` or `-l [directory_path]`: Lists all songs in the specified directory.
- `-p <song_name> [directory_path]`: Plays the specified song.
- `-d [directory_path] <YouTube_link>`: Downloads a YouTube song and saves it to the specified directory.
- `-r [directory_path]`: Plays a randomly selected song from the specified directory.
- `-h` or `--help`: Displays help message.

## Usage

The script is easy to use with command-line arguments. For example, to play a song named "Song Name" from the directory "C:\Users\username\Music", you would use the following command:

```batch
music -p "Song Name" C:\Users\username\Music
```

Replace "Song Name" with the actual name of your Song.

## Note

The optional directory argument is the folder path where the command will be executed. If not provided, the default music directory specified in the script will be used.
