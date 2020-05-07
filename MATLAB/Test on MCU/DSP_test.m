clear all
clc
close all

addpath('MY FUNCTIONS');
load('my_database.dat','-mat');

%% Intilize paramters %%
fs = 8000;
centroid=16;
sound_id=length(data_save);

%% Read binary file %%
fileID = fopen('Wr.bin');
%rec_data = fread(fileID,[4096*2 1],'int16');
rec_data = fread(fileID,[4096*2 1],'float');
fclose(fileID);
%figure
%plot(rec_data);
%rec_uint = (typecast(int16(rec_int), 'uint16'));

%% Signal processing %%
nor_data = rec_data/abs(max(rec_data));
preem_data = filter([1 -0.9375], 1, nor_data);
figure
plot(preem_data);
tach_data = endcut(preem_data, 128, 0.3E-3, 12);
%tach_data = tachtu(preem_data);
figure
plot(tach_data);
mfcc_data = mfcc(tach_data, fs);
figure
plot(mfcc_data);
speech_id = nhandang(mfcc_data, 18, fs);
data_play = audioplayer(tach_data,fs);
play(data_play);