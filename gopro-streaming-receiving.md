## GoPro Streaming
### Method & Goal
**Goal**:  
to display streaming from two gopro on a screen (one device)  
**Method**:  
Host two RTMP servers locally using two instance of **MonaServer2**, stream GoPro to each server using **GoPro Quik** app and then receive the streaming using **FFmpeg**.
## Requirements
- [MonaServer2](https://github.com/MonaSolutions/MonaServer2) for hosting RTMP server
- [FFmpeg](https://ffmpeg.org/) to receive GoPro streaming with low delay
- Two iOS or Android Device with GoPro [Quik](https://gopro.com/de/de/shop/quik-app-video-photo-editor) installed
- PC with wireless network interface (Wifi function)
- Wireless local area network (WLAN, usually a wifi router; **eduroam is not suitable!**)
## Prepare Two MonaServers
### Setup
#### Linux & MacOS
- Install requirements based on instruction of [MonaServer2](https://github.com/MonaSolutions/MonaServer2) Github Page (MonaServer itself dosn't requires installation)
- Compile MonaServer according to [unix-setup instruction](https://github.com/MonaSolutions/MonaServer2#unix-setup)
#### Windows
- [Download](https://github.com/MonaSolutions/MonaServer2#binaries) the binary version
### The First Instance of MonaServer
- Run `./MonaServer` at root folder of MonaServer; for windows, use powershell and run `.\MonaServer.exe`
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
Now the Monaserver is running locally, and the fourth line:
> ```Protocols.h[82] RTMP server started on 0.0.0.0:1935```

from above output shows that the RTMP server is running at the default RTMP port 1935
- Remain the terminal so that the server keep running  
### The Second Instance of MonaServer <a id="2ndMonaserver"></a>
- Copy the entire MonaServer folder (rename the copy to avoid conflict is needed)
- Modify the port for hosting the second Monaserver:

Open the second Monaserver folder and open `MonaServer.ini`  
and find the following piece of configuration for RTMP in the file: 
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

Modify the line `port=1935` so that it use another not-in-use port, example: `port=9999`
- Run the second Monaserver like running the first one: `./MonaServer` for Mac & Linux and `.\MonaServer.exe` for Windows
- Remain the terminal
## Streaming GoPro to MonaServer
### Get the ip address in the WLAN of your pc  
- [Windows method](https://www.howtogeek.com/858334/how-to-find-your-ip-address-from-cmd-command-prompt/)
- [Linux method](https://phoenixnap.com/kb/how-to-find-ip-address-linux)
- [MacOS Method](https://www.wikihow.com/Find-Your-IP-Address-on-a-Mac)  
### Streaming the first GoPro to the first Monaserver
- Open GoPro Quik & connect to GoPro
- Control Your Gopro -> Set Up Live -> Other/RTMP 
- Connect GoPro to the same wifi your pc connected
- At "ENTER YOUR RTMP URL" section, enter 
```
rtmp://[ip address]
``` 
replace [local ip address] with the local ip address you just obtained  
for example: 

```
rtmp://192.168.178.10
```
- Chose other streaming options accordingly and stream
### Streaming the second GoPro to the second Monaserver 
- Repeat all steps until "ENTER YOUR RTMP URL"
- At "ENTER YOUR RTMP URL" section, enter 
```
rtmp://[ip address]:[the port number where 2nd Monaserver runs]
``` 
example:
```
rtmp://192.168.178.10:9999
``` 
(Please refer to the [2nd step](#2ndMonaserver) of setting the second instance of monaserver)
- Chose other streaming options accordingly and stream
## Receive Streaming
### Receive streaming with FFplay from FFmpeg
- Install [FFmpeg](https://ffmpeg.org/) on your device
- Modify and run
```
ffplay -an -flags low_delay -fflags nobuffer -framedrop -strict experimental -probesize 32 -analyzeduration 0 -sync ext rtmp://[ip:port-number]
  ```
to receive streaming of the first GoPro. Modify the `[ip:port-number]` part accordingly, the `ip` should be replaced with your local ip  
- To receive the streaming of the **1st** GoPro, the port-number is optional, example:
```
... -sync ext rtmp://192.168.178.10
```
- To receive the streaming of the **2nd** GoPro, change the port number accordingly (please refers to the step "Modify the port for the second Monaserver"), example:
```
... -sync ext rtmp://192.168.178.10:9999
```
- Please feel free to modify the flags to minimize the delay. See [FFplay](http://ffmpeg.org/ffplay.html) documentation 
- Alternatively, modify (ip, portnumber, flags) & use the script provided in this repo. 
### Scripts
- [receive_streaming_unix.sh](./gopro-streaming-receiving/receive_streaming_unix.sh) for MacOS & Linux  
- [receive_streaming_pwrshell.sh](./gopro-streaming-receiving/receive_streaming_pwrshell.ps1) for Powershell on Windows
