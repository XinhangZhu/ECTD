function ECTD=ECTD(s,varargin)
%   ECTD=ECTD(s,N1,M1,steps) calculates extending complex-lag time-frequency distribution of 2-D signal.
%   Necessary input parameters:
%                      s - input 2-D signal, which size is N*M, N is the slow-time dimension, M is the fast-time dimension
%   Optional input parameters:
%                      N1 - slow-time window width.
%                      M1 - fast-time window width
%                      steps - sampling number of the distribution in na dimension
%   Output parameters: ECTD - the extending complex-lag time-frequency distribution of the signal
%   P.S.: If the execution is too slow, you can try reducing M1 and steps, which decrease the number of sampling points.
%   Programming by Xinhang Zhu
%   Date: June 2025.
%   Copyright (c) by the authors
%% set default parameters
[N M] = size(s);
switch nargin
    case 1
        N1 = N/32;
        M1 = M/32;
        steps = N/64;
    case 2
        N1 = cell2mat(varargin(1));
        M1 = M/32;
        steps = N/64;
    case 3
        N1 = cell2mat(varargin(1));
        M1 = cell2mat(varargin(2));
        steps = N/64;
    case 4
        N1 = cell2mat(varargin(1));
        M1 = cell2mat(varargin(2));
        steps = cell2mat(varargin(3));
end

%% window function generation
nbegin = round(linspace(1,N-N1,steps));
mwinlength = M1;
msteplength = mwinlength/2;
kclearwin = [zeros((M-mwinlength)/2,1);hann(mwinlength);zeros((M-mwinlength)/2,1)].';
rclearwin = zeros(N1,M);
for in = 1:N1
    rclearwin(in,:) = kclearwin;
end

%% ECTD analysis
ECTD = zeros(steps,N1,M);
waitF = waitbar(0, 'ECTD generating ...');
for istep = 1:steps
    waitbar(istep/steps, waitF);
    for im = 1:msteplength:M
        clearwin = circshift(rclearwin,[0 -M/2+im]);
        sana = s(nbegin(istep)+(1:N1),:);                               %step2: apply window function in the slow-time dimension
        fana = fftshift(fft(sana,[],2),2).*clearwin;
        clear sana;sana = ifft(ifftshift(fana,2),[],2);                 %step3: apply window function in the fast-time dimension
        ECTDT=ECTD4(sana);                                              %step4-6 are in this function, ECTD4 corresponds to Temp in the paper
        for in = 1:N1
            ECTD(istep,in,im+(1:msteplength)-1) = ECTDT(in,im+(1:msteplength)-1);       %step7
        end
    end
end
close(waitF);
