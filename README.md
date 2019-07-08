## Overview

**Frost** is a new language specifically tailored to the capabilities of Microchip Technology PIC microcontrollers, and to the real-time, embedded, and low-cost / low budget millieus in which they have traditionally been most at home. 

This repository holds the Linux-hosted version of the Frost cross-compiler. The Windows version is hosted in my blog hosted at [here](http://beauscode.blogspot.com/2013/02/language-and-development-tool-for.html). 

The blog also contains detailed discussion of the Frost language, which is not duplicated here. Both this Git archive and the downloads available at the blog contain the canonical large Frost application, which is a PID controller of the sort one might use for an autopilot, cruise control, robot, or other cybernetic control system. 

Some salient features of the Frost language and its HLOE runtime are listed below:

* Subroutines, functions and parameters    
* A 16-bit, general-purpose real number type ("SFP")    
* Event handlers, with automatic preemption and constant interrupt latency 
* Serial I/O and ANSI terminal support   
* Support for string literals and look-up tables  
* Modular, expandable runtime library 
* Macros  
* Full support for PIC features (timers, analog sensing and signal generation, etc.) 
* Extensive facilities for portability, e.g. between "mid-range" and "enhanced mid-range" devices, and to other Microchip Technology devices 

## Using the Archive

To use this archive, you must have both the MPLAB IDE installed and the Wine emulation layer used to run Windows executables on Linux. The MPLAB IDE's assembler and linker are used by the cross-compiler present in the archive. 

Note that the "MPLAB X" IDE is not what you need; rather, its predecessor IDE (which is not branded as "X") is what is required. I am using version 8.00 of MPLAB, which is available [here](http://ww1.microchip.com/downloads/en/DeviceDoc/mpl610full.zip). 

The MPLAB installation CDs supplied with many Microchip Technology programmers and starter boards should suffice as well. If you choose to use the link supplied, though, you will need to create a free Microchip account.

## Environment

In any case, whether MPLAB is obtained online of from a CD, there will be an installation EXE in the root folder that you need to run using Wine. It is advisable to use the default MPLAB installation path; if you do not, files **make.inc** and **build.inc** from the "frostcompiler" folder of the Git archive will need to be edited to reflect the path selected.

The operation of the Frost cross-compiler relies on an environment variable called FROST. This can be set by adding a line to file **~/.bashrc**:

```export FROST='../frostcompiler/'```

The advantage of expressing this variable as a relative path is that is works for both the Linux and Windows (Wine) components of the Frost development stack; an absolute path would look different in Linux vs. Windows / Wine.

The small disadvantage is that all Frost projects developed must reside in subfolders of the "Frost" folder into which the instant Git repository residers. Note that the sample projects supplied with the repository already respect this structure.

## Building the Supplied Samples

Once you have cloned the Git archive and met the prerequisite requirements, you can drill down into any of the sample project folders and invoke executable **frostcompiler** to generate the correct binary, e.g.:

```dell@dell-Latitude-E6420:~/frost/frostledproject$ ../frostcompiler/frostcompiler file ./led.frost board lpc proc 16F690```




FOLDER STRUCTURE - UNDER LINUX
