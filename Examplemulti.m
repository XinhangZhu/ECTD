clear all;clc
close all;

multisignal;                                %generate a signal
load multisignal;                        %load the signal generated

%If the execution is too slow, you can try to set M1=M/16 and steps=32, which decrease the number of sampling points.
N1 = N/32;
M1 = M/32;
steps = 128;        
ECTDdistribution=ECTD(s,N1,M1,steps);               %analyze the signal, obtain the ECTD distribution
ECTDdistributionmulti = ECTDdistribution;
save('ECTDdistributionmulti.mat','ECTDdistributionmulti');        %save the distribution obtained

multiplotfig;                               %plot the figure of the results


