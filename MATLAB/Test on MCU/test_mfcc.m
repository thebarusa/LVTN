%clear all
clc
close all

size = (floor((len-256)/100) + 1);
file = fopen('mfcc_data.bin');
mfcc_data1 = fread(file,[size 20],'float');
fclose(file);


mfcc_data1 = mfcc_data1';
%z_data = reshape(mfcc_data1, [29 20])';
speech_id = nhandang(mfcc_data1, 30, fs);

