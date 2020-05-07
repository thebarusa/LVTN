
N = 128;
for k=1:length(preem_data)/N
    zcr(k)=zerocross(preem_data((k-1)*N+1:k*N));
end