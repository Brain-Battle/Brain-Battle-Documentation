# Recording EEG Data with Muselsl

## Contents
- **Intro**
    - What is Muselsl
- **How-tos on Muselsl**
    - Installation
    - Record using command `muselsl record_direct`
    - Record with commands `muselsl stream` and `muselsl record`
- **Additional Guides**
    - How to activate a python **virtual environment** created with **venv**
    - How to create a python **virtual environment** with **venv**

## What is Muselsl
From [Github page of Muselsl](https://github.com/alexandrebarachant/muse-lsl):
> A Python package for streaming, visualizing, 
> and recording EEG data from the Muse devices developed by InteraXon.

It can be used as a program or as a library.

Run `muselsl -h` to see help prompt which is self explanatory on its usage. 

## How-tos
### Installation

It is recommended to install muselsl inside a **python virtual environment** (see Additional Guides).

Install Muselsl with pip
```
pip3 install muselsl
```

### Tips:
- Stream muse-bands (using `muselsl stream ...` to stream [see option2]) before wear them on boxers to prevent them turning off after idle for a while. 
(You don't want to try turn on muse-bands beneath head protector and fixed rubber band)

### Usage
#### List all muse-bands
List all muse devices to get their **device name** and **MAC address**
```
muselsl list
```
Sample output:

[under construction]



#### Option 1: record using `record_direct`
Basic usage:
```
muselsl record_direct -n [device-name] -d [duration(sec)]
```
- **`-n`** to specify which device to record by name; put device names derived from `muselsl list` into `[device-name]` field
- **`-d`** to specify `[duration(sec)]` seconds of recording (60s if option not provided)

or in case `-n` not working (or you prefer using MAC address):
```
muselsl record_direct -a [MAC address] -d [duration]
```
- **`-a`** to specify MAC address of muse-band


#### Option 2: record using `stream` & `record`
##### Stream
Setup a stream to a specific muse-band:
```
muselsl stream -n [device-name]
```
Can run without `-n` option: `muselsl stream`. In this case, muselsl will stream the first museband.

##### Record
Then, record from the specified muse-band:
```
muselsl record -n [device-name] -d [duration(sec)]
```
When no `-n` option, it record the first stream.


#### The help prompt
Run `muselsl` or `muselsl -h` to show all commands and options.

## Additional Guides

### Create python virtual environment
Create python virtual environment using python module **venv**
```
python -m venv [env-name]
```
- `-m` to use the venv module
- specify desired virtual env name in `[env-name]` field
- if `python` is mapped to python2 in your shell, then use `python3` in the command

The command will create a folder named `env-name` which contains 
files of the virtual environment. The structure of the folder varies 
between different OSs.

Virtual environment need to be activated to use.

### Activate existing python virtual environment

To activate a venv, in terminal, go to the venv folder, and run
- windows (powershell) : `./Scripts/Activate.ps1`
- unix-like system: `source ./bin/[respective-shell-script]`
    - for bash & bash compatible shell (most cases): `source ./bin/activate`
    - for fish `source ./bin/activate.fish`
    - for csh `source ./bin/activate.csh`

When the virtual env. is activated, usually the prompt will notifies it.

Powershell Ex:
- not activated `PS C:\Users\user\Document\test-env>`
- activated `(test-env) PS C:\Users\user\Document\test-env>`
    - `(test-env)` notifies the virtual environment named "test-env" is activated

After the python virtual environment is activated, one can **install** or **use muselsl**.

### Deactivate python virtual environment
Run the deactivate script:
```
deactivate
```
