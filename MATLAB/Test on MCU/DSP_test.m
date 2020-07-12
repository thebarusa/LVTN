clear all
clc
close all

addpath('MY FUNCTIONS');
load('my_database.dat','-mat');

%% Intilize paramters %%
fs = 8000;
sound_id=length(data_save);

%% Read binary file %%
fileID = fopen('rec_data.bin');
rec_data = fread(fileID,[4800 1],'float');
fclose(fileID);
%figure
%plot(rec_data);
%rec_uint = (typecast(int16(rec_int), 'uint16'));

%% Signal processing %%
%tach_data = endcut(rec_data, 16, 0.5E-3, 0.06);
len = hex2dec('9B0');
rec_data = rec_data(1:len);
mfcc_data = mfcc(rec_data, fs);
speech_id = nhandang(mfcc_data, 30, fs);
data_play = audioplayer(rec_data,fs);

m_pho = fft(rec_data);
L = length(rec_data);
m_pho = abs(m_pho/L);
m_pho = m_pho(1:L/2+1);
m_pho(2:end-1) = 2*m_pho(2:end-1);
f = fs*(0:(L/2))/L;
filter_bank = melfb_v2(20, 256, fs)'.*max(m_pho);
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

hFig=figure('Position',[200 200 3000 3000]);
movegui(hFig,'center')
subplot(2,2,1)
plot(rec_data);
grid on
title('Pre-emphasis & tach tu');

subplot(2,2,2);
plot(f,m_pho,'k');
%hold on; plot(linspace(0, (fs/2), 129), filter_bank, 'linewidth', 1);
xlabel('f (Hz)')
title('Pho tin hieu');
        
subplot(2,2,3)
plot(mfcc_data);
title(['MFCC cua tu "' data_save{speech_id,3} '"']);

subplot(2,2,4)
plot(data_save{speech_id, 1});
title('Database');