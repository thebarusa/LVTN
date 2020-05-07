function s2=tachtu(s1,Nfr)

if( nargin < 2)
   N = 128;
else
   N = Nfr;
end


for k=1:length(s1)/N,
    Es(k)=s1((k-1)*N+1:k*N)'*s1((k-1)*N+1:k*N)/N;
end;

Emax = max(Es);
[temp,index]=find(Es>0.1*Emax);
start_frame=index(1);
end_frame=index(length(index));

s2=s1((start_frame-1)*N+1:end_frame*N);

end