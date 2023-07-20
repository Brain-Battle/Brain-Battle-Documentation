# Brain Battle

## GoPro Streaming
### Method & Goal
**Goal**:  
to display streaming from two gopro on a screen  
**Method**:  
Host two RTMP servers locally using two instance of **MonaServer2**, stream GoPro to each server using **GoPro Quik** app and then receive the streamings using **FFmpeg**.
### Requirements
- [MonaServer2](https://github.com/MonaSolutions/MonaServer2) for hosting RTMP server
- [FFmpeg](https://ffmpeg.org/) to receive GoPro streaming with low delay
- Two iOS or Android Device with GoPro [Quik](https://gopro.com/de/de/shop/quik-app-video-photo-editor) installed
- PC with wireless network interface (Wifi)
- Wireless local area network (WLAN, usually a wifi router)
### Setup Two MonaServer
#### First MonaServer
- Install requirements based on instruction of [MonaServer2](https://github.com/MonaSolutions/MonaServer2) Github Page (MonaServer itself dosn't requires installation)
- For Linux & MacOS, compile MonaServer according to [instruction](https://github.com/MonaSolutions/MonaServer2)
- For Windows, [download](https://github.com/MonaSolutions/MonaServer2) the compiled version
- open up a terminal and run `./MonaServer` where MonaServer folder is located, for windows use powershell and run `.\MonaServer.exe`
The output should looks like this if the server is successfully running:
```
Application.cpp[134] MonaServer v2.723
Application.cpp[136] Load configuration file MonaServer.ini
Protocols.h[82] RTMFP server started on 0.0.0.0:1935
Protocols.h[82] RTMP server started on 0.0.0.0:1935
Protocols.h[82] RTMPS server started on 0.0.0.0:8443
Protocols.h[82] HTTP server started on 0.0.0.0:80
Protocols.h[82] WS server started on 0.0.0.0:80
Protocols.h[82] HTTPS server started on 0.0.0.0:443
Protocols.h[82] WSS server started on 0.0.0.0:443
Protocols.h[82] SRT server started on 0.0.0.0:9710
```
Now the Monaserver is running locally, and we can see that the RTMP server is hosted on the default RTMP port `port 1935` as the fourth line shows
- **remain the terminal** so that the server keep running
#### The Second Instance of MonaServer
- copy the entire MonaServer folder (rename the copy if under same path)
- open the second Monaserver folder and open `MonaServer.ini`
Find the following configuration for RTMP in the file: 
```
; [RTMP(=true|false)] RTMP (and RTMPE) server
[RTMP]
; socket bind
port=1935
host=0.0.0.0
publicPort=1935
publicHost=127.0.0.1
; socket parameters, if not set use [net] parameters (see above in CATEGORIZED)
bufferSize=65536
recvBufferSize=65536
sendBufferSize=65536
; timeout connection in seconds
timeout=60
```
Modify the line `port=1935` so that it use another not-in-use port, Ex: `port=9999`
- run the second Monaserver like running the first one: `./MonaServer` for Mac & Linux and `.\MonaServer.exe` for Windows
- remain the terminal
### Streaming GoPro to MonaServer
get the local ip address of your pc 
    - [Windows method](https://www.howtogeek.com/858334/how-to-find-your-ip-address-from-cmd-command-prompt/)
    - [Linux method](https://phoenixnap.com/kb/how-to-find-ip-address-linux)
    - [MacOS Method](https://www.wikihow.com/Find-Your-IP-Address-on-a-Mac)
#### Streaming one GoPro to the first Monaserver
- open GoPro Quik & connect to GoPro
- Control Your Gopro -> Set Up Live -> Other/RTMP 
- Connect GoPro to the same wifi your pc connected
- At "ENTER YOUR RTMP URL" section, enter `rtmp://[local ip address]` replace [local ip address] with the local ip address just obtained
- chose other option accordingly and stream
