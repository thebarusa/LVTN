function y = zerocross(x,n)

y = 0;
for k = 1:(length(x)-1)
  if ((x(k) < 0) && (x(k + 1) >= 0 ) || ((x(k) >= 0) && (x(k + 1) < 0)))
    y = y + 1;
  end
end
y = y/n;