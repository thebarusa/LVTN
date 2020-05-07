function y = short_energy(s,N)

%s=s/max(abs(s));
%N=128;
for k=1:length(s)/N,
    Es(k)=s((k-1)*N+1:k*N)'*s((k-1)*N+1:k*N)/N;
end;
y = Es;
end