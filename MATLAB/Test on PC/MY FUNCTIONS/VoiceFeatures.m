function [xPit] = VoiceFeatures(data)
my_fft = fft(data);
plot(real(my_fft));
m = max(real(my_fft));
xPit = find(real(my_fft)==m,1);