%clear all
clc
close all

file = fopen('mfcc_data.bin');
mfcc_data1 = fread(file,[600 1],'float');
fclose(file);

size = (floor((len-256)/100) + 1);
mfcc_data1 = mfcc_data1(1:(size*20));
z_data = reshape(mfcc_data1, [30 20])';
%r_data = dct(log(z_data));
speech_id = nhandang(z_data, 30, fs);
