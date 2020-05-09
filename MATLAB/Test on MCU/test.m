clc

%rec_data(1:32) = 0;
playrec = audioplayer(rec_data,fs);
play(playrec);
N = 16;
for k=1:length(rec_data)/N,
    Es(k) = rec_data((k-1)*N+1:k*N)'*rec_data((k-1)*N+1:k*N)/N;
    Ezc(k) = zerocross(rec_data((k-1)*N+1:k*N), N);
end

imx = max(Es);
imn = min(Es);
I1 = 0.03*( imx - imn ) + imn;
I2 = 4 * imn;
ITL = min (I1,I2);
ITU = 5* ITL;

