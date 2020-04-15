close all
clc
clear all

fs = 8000;
s = zeros(1,2000);
s(1:15) = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
n = 256;
m = 100;

n2 = 1 + floor(n / 2);
frame=blockFrames(s, fs, m, n);
frame_amp=abs(frame(1:n2, :)).^2;
mel = melfb_v2(20, n, fs);

z = mel * frame_amp;
r = dct(log(z));


te(1:8) = 5:12;
tes = dct(log(te));
