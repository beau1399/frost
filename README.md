## Overview

**Frost** is a new language specifically tailored to the capabilities of Microchip Technology PIC microcontrollers, and to the real-time, embedded, and low-cost / low budget millieus in which they have traditionally been most at home. 

This repository holds the Linux-hosted version of the Frost cross-compiler. The Windows version is hosted with my blog, [here](http://beauscode.blogspot.com/2013/02/language-and-development-tool-for.html). 

The blog also contains detailed discussion of the Frost language, which is not duplicated here. Both this Git archive and the downloads available at the blog contain the canonical large Frost application, which is a PID controller of the sort one might use for an autopilot, cruise control, robot, or other cybernetic control system. 

Some salient features of the Frost language and its HLOE runtime are listed below:

* Subroutines, functions and parameters    
* A 16-bit, general-purpose real number type (SFP, also available from [its own repository](https://github.com/beau1399/frost))
* Event handlers, with automatic preemption and constant interrupt latency 
* Serial I/O and ANSI terminal support   
* Support for string literals and look-up tables  
* Modular, expandable runtime library 
* Macros  
* Full support for PIC features (timers, analog sensing and signal generation, etc.) 
* Extensive facilities for portability, e.g. between "mid-range" and "enhanced mid-range" devices, and to other Microchip Technology devices 

## Using the Archive

To use this archive, you must have both the MPLAB IDE installed and the Wine emulation layer used to run Windows executables on Linux. The MPLAB IDE's assembler and linker are used by the cross-compiler present in the archive. 

The instructions below give very specific information about how I have been able to use the Frost cross-compiler and all of the Microchip programs it relies on using an Ubuntu 18.04 installation. The general steps will be similar for other distributions, though these will require you to place the steps into the context of your own installation, e.g. using your distribution's own package manager to install things.

Note that the "MPLAB X" IDE is not what you need; rather, its predecessor IDE (which is not branded as "X") is what is required. I am using version 8.00 of MPLAB, which is available [here](http://ww1.microchip.com/downloads/en/DeviceDoc/mpl610full.zip). 

The MPLAB installation CD you likely received with you Microchip Technology programmer or starter board should suffice as well. If you choose to use the link supplied, though, you will need to create a free Microchip account.

## Environment

In any case, whether MPLAB is obtained online of from a CD, there will be an installation EXE in the root folder that you need to run using Wine. It is advisable to use the default MPLAB installation path; if you do not, files **make.inc** and **build.inc** from the "frostcompiler" folder of the Git archive will need to be edited to reflect the path selected.

The operation of the Frost cross-compiler relies on an environment variable called FROST. This can be set by adding a line to file **~/.bashrc**:

```export FROST='../frostcompiler/'```

The advantage of expressing this variable as a relative path is that is works for both the Linux and Windows (Wine) components of the Frost development stack; an absolute path would look different in Linux vs. Windows / Wine. Of course, editing ".bashrc" in this manner will, at a minimum, require you to close and re-open your terminal window, if not log off altogether.

The small disadvantage is that all Frost projects developed must reside in subfolders of the "Frost" folder into which the instant Git repository residers. Note that the sample projects supplied with the repository already respect this structure.

## Building the Supplied Samples

Once you have cloned the Git archive and met the prerequisite requirements, you can drill down into any of the sample project folders and invoke executable **frostcompiler** to generate the correct binary, e.g.:

```$ ../frostcompiler/frostcompiler file ./led.frost board lpc proc 16F690```

This is the appropriate build command for the sample project found in the "frostledproject" folder, which blinks an LED. The "lpc" and "16F690" parameters reflect the use of the Microchip "Low Pin Count" demo board and the 16F690 processor it hosts. For more information about the various "board" and "proc" values available for development, see the blog.

TODO - case implications for processor e.g. above

## Programming With the PICKit 2

It is possible to program PIC devices from the Ubuntu shell. I do so using the PICKit 2 development programmer, using a program called **pk2cmd**. There is also a PICKit 3 programmer, with its own **pk3cmd** utility. I imagine these operate similarly to what is described below, though I am not able to test this. 

A library called **libusb-dev** is necessary for programming. Ensure it is installed using the package manager, e.g.

```$ sudo apt install libusb-dev```

The **pk2cmd** program itself must be downloaded from Github as uncompiled source. Note that this program is not **free** software in the sense that much of Linux is; while available for download, it is covered by a more restrictive license and remains proprietary to Microchip.

Begin by cloning the **pk2cmd** repository:

```$ git clone https://github.com/psmay/pk2cmd```

This will create a "pk2cmd" subfolder within the folder from which you ran the clone command. Drill into this folder, and then into the second "pk2cmd" folder contained therein, and then run "make" to build the programming utility:

```
$ cd pk2cmd
$ cd pk2cmd
$ make
```
You will next need to make another addition to ~/.bashrc, e.g.:

```export PATH="$PATH:"/home/dell/pk2cmd/pk2cmd""```

I cloned the repository from "/home/dell" so that is what is seen above; you will need to edit this command to reflect the folder you used.

To pick up this change, you will need to close / re-open your terminal window, at a minimum.

Finally, make the relevant file executable. Again, edit this command to reflect your own choice of folder:

```$ chmod a+x /home/dell/pk2cmd/pk2cmd/pk2cmd```

With these steps complete, you should be able to program from the shell terminal, directly from the folder in which the "hloe.hex" folder that the Frost cross-compiler generates, e.g.

$ pk2cmd -PPIC16F690 -M -T -Fhloe.hex

Above, the -P parameter is followed by the PIC device name. The -M parameter tells pk2cmd to overwrite all memory. The -T parameter instructs pk2cmd to leave the target device powered on. Finally, -F is followed by the file name, which will always be "hloe.hex" for Frost development.


BUILDING THE FROST OCMPILER
BAT FILES


