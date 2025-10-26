=======================================================================
This is a demonstration of the Extending Complex-lag Time-frequency Distribution (ECTD). The algorithm is described in:
Xinhang Zhu, etc., "An Analysis of 2-D Signals with Fast Varying Instantaneous Frequencies: Extending Complex-lag Time-frequency Distribution", submitted to IEEE Signal Processing Letters, 2025.

You can change this program as you like and use it anywhere

=======================================================================
File lists:
ECTD.m Examplemono.m Examplemulti.m monosignal.m multisignal.m ECTD2.m ECTD4.m tftb_window.m
monoplotfig.m multiplotfig.m

=======================================================================
Recommended Usage:
Running on Matlab. This program has been verified to run on MATLAB 2012a and MATLAB 2020a.

1. Examplemono.m & Examplemulti.m are two complete examples. They correspond to the Example 1 and Example 2 in the paper above. Just directly execute them.

2. Input a signal in a matrix and analyze it by the function ECTD(s,N1,M1,steps). The signal can be generate by monosignal.m & multisignal.m (you can adjust the signal parameters in the two file), or just input your own signal.


=======================================================================
File Instructions:

====================
1. ECTD.m

The ECTD algorithm is reorganized as a function in this file: ECTD(s,N1,M1,steps)
Necessary input parameters:
	s - input 2-D signal, which size is N*M, N is the slow-time dimension, M is the fast-time dimension
Optional input parameters:
	N1 - slow-time window width.
	M1 - fast-time window width
	steps - sampling number of the distribution in na dimension
Output parameters: ECTD - the extending complex-lag time-frequency distribution of the signal

====================
2. Examplemono.m & Examplemulti.m

The two file are complete examples for using ECTD to analyze a monocomponent 2-D signal and a multicomponent 2-D signal, respectively. The two file include the process from signal generation to plot figures. The two examples corresponds to the Example 1 and Example 2 in the paper above, respectively.
*Running these two files will take several hours
====================
3. monosignal.m & multisignal.m

The two file are using to generate monocomponent 2-D signals and multicomponent 2-D signals, respectively. You can change the parameter of the signal in the two file as you like. 
Using the default parameters can obtain the results corresponding to the figures in the paper above.

====================
4. Other files
(These programs are generally not executed independently, but their usages are still explained here)

ECTD2.m ECTD4.m tftb_window.m
The functions that ECTD(s,N1,M1,steps) is intended to call.

monoplotfig.m & multiplotfig.m
These files are used to plot the figures of the example.

=======================================================================