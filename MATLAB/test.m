close all
clc
clear all

s = zeros(1,64);
s(1:9) = [1 2 3 4 5 6 7 8 9];
n = 32;
m = 1;

n2 = 1 + floor(n / 2);
dt = [1 2 3 4];
df = fft(dt,32);


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

m4 = abs(m3(1:n2, :)).^2;