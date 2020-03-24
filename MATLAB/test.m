close all
clc
clear all

fs = 8000;
mel_high = 2595*log10(1+((fs/2)/700));
mel_points = linspace(0,mel_high,22);
hz_points  = 700*((10.^(mel_points/2595))-1);

MELFB = melfb_v2(20, 256, 8000);
plot(linspace(0, (8000/2), 129), MELFB');