close all
clc
clear all

s = [1 2 3 4 5 6 7 8 9];
n = 4;
m = 1;



l = length(s);
nbFrame = floor((l - n) / m) + 1;
for i = 1:n
    for j = 1:nbFrame
        m1(i, j) = s(((j - 1) * m) + i); 
    end
end
h = hamming(n);
h1 = diag(h);
m2 = diag(h) * m1;
for i = 1:nbFrame
    m3(:, i) = fft(m2(:, i)); 
end
