clear all;close all;clc
%% multi component radar echo signal generation

f0 = 2e9;
c = 3e8;
lambda = c/f0;
N = 8192;
PRF = 200;
M = 128;
B = 100e6;
fs = 200e6;
Tr = 50e-6;
k = B/Tr;
SNR = -5;

T = (-M/2:M/2-1)/fs;
Ta = (-N/2:N/2-1)/PRF;

Gamma = 4*k/c;

Phi1 = -2*pi*20.*(2*cos(2*pi*Ta/60-0.1*pi)+sin(2*pi*Ta/30))-30*Ta+700;
s1 = zeros(N,M);
for in = 1:N
   s1(in,:) = exp(1j*2*pi*T*(-4*k/c*Phi1(in))).*exp(1j*Phi1(in));
end

Phi2 = -2*pi*30.*(3*cos(2*pi*Ta/60-0.4*pi)+sin(2*pi*Ta/25+0.2*pi))-50*Ta-500;
s2 = zeros(N,M);
for in = 1:N
   s2(in,:) = exp(1j*2*pi*T*(-4*k/c*Phi2(in))).*exp(1j*Phi2(in));
end

Phi3 = -2*pi*10.*(1*cos(2*pi*Ta/60-0.8*pi)+sin(2*pi*Ta/20+0.4*pi))+20*Ta-500;
s3 = zeros(N,M);
for in = 1:N
   s3(in,:) = exp(1j*2*pi*T*(-4*k/c*Phi3(in))).*exp(1j*Phi3(in));
end

Phi4 = -2*pi*20.*(0*cos(2*pi*Ta/60-0.8*pi)+sin(2*pi*Ta/20+0.6*pi))+60*Ta+1300;
s4 = zeros(N,M);
for in = 1:N
   s4(in,:) = exp(1j*2*pi*T*(-4*k/c*Phi4(in))).*exp(1j*Phi4(in));
end

s0 = s1+s2+s3+s4;
saddn = awgn(zeros(N,M),SNR);
s = s0+saddn;
save multisignal;


PN = sqrt(sum(sum(abs(saddn(1:10,1:10).^2)))/100);   %noise sigma
figure;
sf = fftshift(fft(s,[],2),2);
imagesc(abs(sf));
xlabel('M');
ylabel('N');
title('signal in range-Doppler domain');    %give a range-Doppler view of the radar signal
