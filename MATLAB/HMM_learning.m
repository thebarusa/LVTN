clear all
clc;

N = 4; % N : So trang thai
M = 5; 
max_iter = 600; % So lan lap
load('my_database.dat','-mat'); % load datasave


% initial guess of parameters
for i = 1:4
   transmat{i} = (rand(N,N));
   emismat{i} = (rand(N,M));
end


% train 1
disp('HUAN LUYEN TU <DI TOI>');
seq{1} = [];
idx  = [];
for i=1:4
    
    [idx,codebook{1}]= kmeans(data_save{i,1}',M);
    idx = idx';
    seq{1} = [seq{1};idx];
end
hmmtrain(seq{1},transmat{1},emismat{1},'maxiterations',max_iter);


% train 2
disp('HUAN LUYEN TU <DI LUI>');
seq{2} = [];
idx  = [];
for i=5:8
    [idx,codebook{2}]= kmeans(data_save{i,1}',M);
    idx = idx';
    k = find(isnan(idx));
    idx(k) = 4;
    seq{2} = [seq{2};idx];
end
hmmtrain(seq{2},transmat{2},emismat{2},'maxiterations',max_iter);

% train 3
disp('HUAN LUYEN TU <RE TRAI>');
seq{3} = [];
idx  = [];
for i=9:12
    [idx,codebook{3}]= kmeans(data_save{i,1}',M);
    idx = idx';
    seq{3} = [seq{3};idx];
end
hmmtrain(seq{3},transmat{3},emismat{3},'maxiterations',max_iter);

% train 4
disp('HUAN LUYEN TU <RE PHAI>');
seq{4} = [];
idx  = [];
for i=13:16
    [idx,codebook{4}]= kmeans(data_save{i,1}',M);
    idx = idx';
    seq{4} = [seq{4};idx];
end
hmmtrain(seq{4},transmat{4},emismat{4},'maxiterations',max_iter);

% NHAN DANG
idx_reg  = [];
data_mfcc = mfcc(data_save{1,5},8000);
[idx_reg,cb_reg]= kmeans(data_mfcc',M);
k = find(isnan(idx_reg));
idx_reg(k) = 5;
for i = 1:4
   [PSTATES{i},logpseq(i)] = hmmdecode(idx_reg',transmat{i},emismat{i});
end

[max_val num] = max(logpseq);
fprintf('TU VUA NHAN DANG LA %s',data_save{num*3+1,3});
save('HMM_data.dat','transmat','emismat','-append');