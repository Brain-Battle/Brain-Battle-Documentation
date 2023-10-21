# Video Processing
## Adding time code & frame number to video
You can add time code to video via premiere pro.  
However, this page will cover how to add **time code** and **frame number** via FFmpeg.
## Adding time code & frame number using [FFmpeg](https://ffmpeg.org/)
(Installation guide at the bottom)
### Command
#### Syntax:
- Basic format:
```
ffmpeg -i [input filename] -vf [video filter parameter] -b:[stream type] [stream bit rate] -y [output filename]
```
- `-vf [filter parameter]`  
parameters are seperated by `:`  
- `-b:[stream type] [stream bit rate]`  
example: `-b:v` set video stream bit rate  
example: `-b:v 10000k` set video stream bit rate to 10000k per second

#### Template:
```
ffmpeg -i [input file path] -vf "text='%{pts\:hms}  %{n}': 
 x=(w-tw)/2: y=h-(2*lh): fontsize=72: fontcolor=white: box=1: 
boxcolor=0x00000099" -y -b:v [bitrate]k [output filename]
```

#### Notice:
- **Line Breaking**  
Some example command use unix way to break line using ` \ ` (back slash). However, in powershell, please change it into powershell style, which is `` ` `` (back tick), or simply do not use multiple line command.
- **Bit Rate**  
Check bit rate of the video being processed first, then set the same or similar bit rate for output video using `-b:v` option to prevent losing quality
- **Font file in MS Windows**  
In windows, FFmpeg can have difficulty on automatically finding font file to use for adding text in video. Therefore, we need to specify the `fontfile` parameter in the `-vf` option. See the first example below.
	- **Format of Path**  
Use `C\\:` to represent the C volume 
#### Example:
- an example for windows with specified fontfile path.
```
ffmpeg -i .\round1-edit-pr.mp4 -vf "drawtext=fontfile=C\\:/Users/media/Documents/Brain-Battle/Fontfile/Open_Sans/static/OpenSans-Regular.ttf : text='%{pts\:hms}  %{n}': x=(w-tw)/2: y=h-(2*lh): fontsize=72: fontcolor=white: box=1: boxcolor=0x00000099" -y -b:v 10000k .\round1-edit-pr-framenumber-timecode.mp4
```


### Install & Setup FFmpeg
- use winget to install for Windows

use winget to avoid annoying `$PATH` setup
```
winget install -e --id Gyan.FFmpeg
```
close and open a new powershell
- use respective package manager for Linux & MacOS
	- Homebrew is recommanded for MacOS
