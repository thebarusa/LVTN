clc

N = 128;
for k=1:length(rec_data)/N,
    Es(k) = rec_data((k-1)*N+1:k*N)'*rec_data((k-1)*N+1:k*N)/N;
end
%Es = Es./N;
imx = max(Es);
imn = min(Es);
I1 = 0.03*( imx - imn ) + imn;
I2 = 4 * imn;
ITL = min (I1,I2);
ITU = 5* ITL;