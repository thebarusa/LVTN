function play_record(data,fs)
data_play = audioplayer(data,fs);
play(data_play);
while (isplaying(data_play))
  disp('Playing..');
  pause(0.5);
end
end