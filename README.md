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



