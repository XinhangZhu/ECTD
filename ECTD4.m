function ECTD4=ECTD4(s)

%% Obtain ECTD2
[N M] = size(s);

STFT = fft(fft(s,[],2),[],1);
SM=ECTD2(s);                %step4: obtain ECTD2

%% Obtain CF


[MAXN MAXNPT] = max(abs(STFT));
[MAXM MAXMP] = max(MAXN);
MAXNP = MAXNPT(MAXMP);
clearwinlengthn = 32;
clearwinlengthm = 16;
STFTEXT = circshift(STFT,[N/2-MAXNP M/2-MAXMP]);
STFTP = STFTEXT(N/2+(-clearwinlengthn/2:clearwinlengthn/2-1),M/2+(-clearwinlengthm/2:clearwinlengthm/2-1));

sana3 = zeros(N,M);
sana4 = zeros(N,M);
NAs =repmat(1/4*(-clearwinlengthn/2:clearwinlengthn/2-1).',1,clearwinlengthm);
MAs =repmat(1/4*(-clearwinlengthm/2:clearwinlengthm/2-1),clearwinlengthn,1);
for in = 1:N
    for im = 1:M
        tta = in-1-N/2;
        tt = im-1-M/2;
        sana3(in,im) = sum(sum(STFTP.*exp(1j*2*pi*NAs/N*1j*tta).*exp(1j*2*pi*MAs/M*1j*tt)))/N/M;
    end
end

for in = 1:N
    for im = 1:M
        tta = in-1-N/2;
        tt = im-1-M/2;
        sana4(in,im) = sum(sum(STFTP.*exp(1j*2*pi*NAs/N*-1j*tta).*exp(1j*2*pi*MAs/M*-1j*tt)))/N/M;
    end
end

T = repmat((-M/2+1:M/2)/M*2,N,1);
Ta = repmat((-N/2+1:N/2).'/N*2,1,M);
sk = exp(1j*4*pi*T*(MAXMP-M/2));
ska = exp(1j*4*pi*Ta*(MAXNP-N/2));
cwin = exp(-(Ta.*T/0.25).^4);
sj34 = exp(-1j*log(abs(sana3./sana4))).*sk.*ska.*cwin;
CF = fft(fft(fftshift(fftshift(sj34,1),2),[],2),[],1);      %step5: obtain CF
CFK = repmat(imresize(CF,[N/4,M/4]),4,4);
% figure;imagesc(abs(CFK));

%% Obtain ECTD4
ECTD4 = SM.*CFK;
SM1 = SM;
C2 = CFK;
L2 = 8;
for il=1:L2
    SM1 = [zeros(1,M);SM1(1:N-1,:)];
    SM1 = [zeros(N,1) SM1(:,1:M-1)];
    C2 = [C2(2:N,:);zeros(1,M)];
    C2 = [C2(:,2:M) zeros(N,1)];
    ECTD4 = ECTD4+SM1.*C2;
end


ECTD4 = fftshift(fftshift(ECTD4,1),2);          %step6: obtain Temp










