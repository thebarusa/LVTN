clear all
clc
%close all

addpath('MY FUNCTIONS');
load('my_database.dat','-mat');

%% Intilize paramters %%
fs = 8000;
centroid=16;
sound_id=length(data_save);

%% Read binary file %%
fileID = fopen('Wr.bin');
%rec_data = fread(fileID,[4096*2 1],'int16');
rec_data = fread(fileID,[5000 1],'float');
fclose(fileID);
%figure
%plot(rec_data);
%rec_uint = (typecast(int16(rec_int), 'uint16'));

%% Signal processing %%
tach_data = endcut(rec_data, 16, 0.5E-3, 0.06);
mfcc_data = mfcc(tach_data, fs);
speech_id = nhandang(mfcc_data, 30, fs);
data_play = audioplayer(tach_data,fs);
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

figure
subplot(2,2,1)
plot(rec_data);
title('Non pre-emphasis');

subplot(2,2,3)
%plot(preem_data);
title('Pre-emphasis');

subplot(2,2,2)
plot(tach_data);
title('Tach tu');

subplot(2,2,4)
plot(mfcc_data);
title('MFCC');