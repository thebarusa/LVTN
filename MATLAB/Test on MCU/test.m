clc

%rec_data(1:32) = 0;
playrec = audioplayer(rec_data,fs);
play(playrec);
N = 16;
for k=1:length(rec_data)/N,
    Es(k) = rec_data((k-1)*N+1:k*N)'*rec_data((k-1)*N+1:k*N)/N;
    Ezc(k) = zerocross(rec_data((k-1)*N+1:k*N), N);
end

m = 100;
n = 256;
frame=blockFrames(rec_data, fs, m, n);
m = melfb_v2(20, n, fs);
n2 = 1 + floor(n / 2);
fr_amp = abs(frame(1:n2, :)).^2;
z = m * fr_amp;
r = dct(log(z));
