%clear all
clc
close all

for i =1:length(data_save)
disp(data_save{i,3});
data_play = audioplayer(data_save{i,5},fs);
play(data_play);
while (isplaying(data_play))
  disp('...')
  pause(0.5);
end
end
