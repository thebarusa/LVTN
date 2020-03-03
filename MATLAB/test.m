close all
clc

h = hamming(256);
h2 = (h) * data_tach;
ft = fft(h2);
fft1 = fft(data_tach);
plot(abs(ft));
%figure
%bao = short_energy(data_tach,100);
%plot(bao)