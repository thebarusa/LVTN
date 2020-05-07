clear all;
close all;
clc;
load('HMM_data.dat','-mat'); % load HMM data
load('my_database.dat','-mat'); % load datasave

M=5;
% NHAN DANG
idx_reg  = [];
data_mfcc = mfcc(data_save{1,5},8000);
[idx_reg,cb_reg]= kmeans(data_mfcc',M);
k = find(isnan(idx_reg));
idx_reg(k) = 5;
for i = 1:4
   [PSTATES{i},logpseq(i)] = hmmdecode(idx_reg',transmat{i},emismat{i});
end

[max_val num] = max(abs(logpseq));
fprintf('TU VUA NHAN DANG LA %s',data_save{num*3+1,3});