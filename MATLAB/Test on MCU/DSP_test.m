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
fileID = fopen('rec_data.bin');
%rec_data = fread(fileID,[4096*2 1],'int16');
rec_data = fread(fileID,[4800 1],'float');
fclose(fileID);
%figure
%plot(rec_data);
%rec_uint = (typecast(int16(rec_int), 'uint16'));

%% Signal processing %%
%tach_data = endcut(rec_data, 16, 0.5E-3, 0.06);
len = hex2dec('a30');
rec_data = rec_data(1:len);
mfcc_data = mfcc(rec_data, fs);
speech_id = nhandang(mfcc_data, 30, fs);
data_play = audioplayer(rec_data,fs);
play(data_play);
while (isplaying(data_play))
  disp('Tin hieu sau khi tach');
  pause(0.5);
end
data_play1 = audioplayer(data_save{speech_id,5},fs);
play(data_play1);
message=strcat('Khop voi tu: ',upper(data_save{speech_id,3}));
while (isplaying(data_play1))
  disp(message);
  pause(0.5);
end

subplot(3,1,1)
plot(rec_data);
grid on
title('Pre-emphasis & tach tu');

subplot(3,1,2)
plot(mfcc_data);
title('MFCC');

subplot(3,1,3)
plot(data_save{speech_id, 1});
title('database');