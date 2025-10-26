function ECTD2=ECTD2(s)



[N M] = size(s);
ECTD2=zeros(N,M);

STFT = fft(fft(s,[],2),[],1);

L1 = 8;
SM = abs(STFT).^2;
STFT1 =  STFT;
STFT2 = STFT;
for il = 1:L1
    STFT1 = [zeros(1,M);STFT1(1:N-1,:)];
    STFT1 = [zeros(N,1) STFT1(:,1:M-1)];
    STFT2 = [STFT2(2:N,:);zeros(1,M)];
    STFT2 = [STFT2(:,2:M) zeros(N,1)];
    SM = SM+2*real([STFT1.*conj(STFT2)]);
end


ECTD2=SM;







