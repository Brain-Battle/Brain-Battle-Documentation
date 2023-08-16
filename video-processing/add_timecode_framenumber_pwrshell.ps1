# This is a sample script for adding timecode & frame-number into the video for powershell. 
# The command for unix-like system is not provided but should be only differenced by the format of path.
# The frame-number is added at the center of the lower border of the frame. 
# We use drawtext filter of ffmpeg to add timecode & frame-number to each frame.
# Each parameter of the filter is separated by ':'.
# The only necessary change to run this command is to change the input filename, output filename and
# the fontfile path.
#
# Basic format:
# 	ffmpeg -i [input filename] -vf [filter parameter] -y [output filename]
#
# Format of [filter parameter]:
# 	[filter name]=[parameter1]: [parameter2]: [parameter3]
#
# The [text] parameter of drawtext filter:
# 	in the example below, text has parameter '%{pts\:hms} %{n}'
# 		pts - timecode
# 		hms - format of timecode to be printed
# 		n - framenumber
# 
# Notice for the [fontfile] parameter:
# 	Usually, it is not necessary to provide this parameter.
# 	But, in windows, it has a great chance that the ffmpeg cannot find a default fontfile.
# 	In this case, you have to specify the .ttf fontfile manually. You can look for fontfile
# 	provided by windows, or just download a fontfile and specify the path to it.
# 	When providing the path, please use '\\' to escape the ':' in the path as the example shows.
#
 ffmpeg -i .\round1-edit-pr.mp4 -vf "drawtext=fontfile=C\\:/Users/media/Documents/Brain-Battle/Fontfile/Open_Sans/static/OpenSans-Regular.ttf : text='%{pts\:hms}  %{n}': x=(w-tw)/2: y=h-(2*lh): fontsize=72: fontcolor=white: box=1: boxcolor=0x00000099" -y -b:v 10000kb .\round1-edit-pr-framenumber-timecode.mp4
