function y = endcut(x, n, es, zcr)
% cat khoang lang ra khoi x.
% n là do dài frame, es là nguong nang luong.
%x = x - mean(x);

if nargin < 3
  es = 0.1E-3;
end

if nargin < 2
  n = 128;
end

y  = [];
t  = x(1:n);
e  = mean(t.^2);
i  = n+1;
ln = length(x) - n+1;

while i <= ln
  t  = x(i:i+n-1);
  e1 = mean(t.^2);
  zc = zerocross(t,n);
  if ~((e1<es) | (abs(e1-e)<es) | (zc < zcr))
    y = [y;t];
  end
  i = i+n;
end