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

Run `muselsl --help` or `muselsl -h` for the help prompt (contains 5 self explanatory commands).

## How-tos
### Installation

It is generally recommended to install/setup dependencies inside a **python virtual environment** (see Additional Guides).

If you choose to use a **python virtual environment**, make sure it is **active** during the muselsl installation and usage.

Install Muselsl with pip
```
pip3 install muselsl
```
Verify the install was a success by running the help command
```
muselsl --help
```

### Usage

#### List all muse-bands
Finds and lists all non-busy muse devices to get their **device name** and **MAC address**
```
muselsl list
```
Sample output: (work in progress)



#### Option 1: record using `record_direct`
Directly record from an available muse-band:
```
muselsl record_direct -n [device-name] -d [duration(sec)]
```
- **`-n`** to specify a device's name (from `muselsl list`)
- **`-d`** to specify `[duration(sec)]` seconds of recording (60s if option not provided)
- **`-a [MAC address]`** to specify MAC address of muse-band, optional alternative to `-n` names
- Recording will be stored in the current folder


#### Option 2: record using `stream` & `record` separately
Stream an available muse-band:
```
muselsl stream -n [device-name]
```
- **`-n`** to optionally specify a device's name (from `muselsl list`)
- will stream the first available muse if `-n` was not specified

Then, record from the specified muse-band:
```
muselsl record -n [device-name] -d [duration(sec)]
```
- **`-n`** to optionally specify a streaming device's name
- **`-d`** to specify `[duration(sec)]` seconds of recording (60s if option not provided)
- will record the first available stream if `-n` was not specified
- Recording will be stored in the current folder

### Tips:
- With our current setup, the physical muse device gets buried under the boxers' headgear, making it hard to access during sessions. Make sure the stream/recording is good to go before the boxers put their equipment on. Also make sure the muse is not idle for more than a few minutes; it will turn off automatically. Streaming will keep them active, especially useful duing setup!
- Muselsl currently uses bluetooth. Make sure the devices are not too far from each other (because you will see a lot of data packets go missing). Keeping the computer withing 6 meters distance has worked without problems so far. The distance has not been limit-tested.
- Make sure you are familiar with the names of the muse devices, and keep track of which person is using which device. Currently the physical devices are labeled with their names/numbers, which usually take the form MuseS-XXXX (numbers), however can be modified. Make sure that your recordings are well organized or labeled in some way; since the recording commands dumps the recordings in the current folder/directory, its recommended to run the command in a specific folder with the date and name already written.

## Additional Guides

### Create python virtual environment
Create python virtual environment using python module **venv**
```
python -m venv [env-name]
```
- `-m` to use the venv module
- specify desired virtual env name in `[env-name]` field
- `python3` instead, if `python` represents python2. (Run `python --version` to check.)

The command will create a folder named `env-name` which contains 
files of the virtual environment. The structure of the folder varies 
between different OSs.

Virtual environment need to be activated to use.

### Activate existing python virtual environment

To activate a venv, in terminal, navigate to the venv folder, then run the appropriate command:
- windows (powershell) : `./Scripts/Activate.ps1`
- unix-like system: `source ./bin/[respective-shell-script]`
    - for bash & bash compatible shell (most cases): `source ./bin/activate`
    - for fish `source ./bin/activate.fish`
    - for csh `source ./bin/activate.csh`

### Check if a python virtual environment is active
The command prompt will usually show the name of an active virtual environment.
Example: powershell prefixes `(test-env)` once active. 
```
PS C:\Users\user\Document\test-env>
(test-env) PS C:\Users\user\Document\test-env>
```

### Deactivate an Active python virtual environment
Run the deactivate script:
```
deactivate
```
