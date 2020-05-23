clc

i = 5;
word = 'dung';
vector = vqlbg(mfcc_data, 16);
data_save{i,1} = vector;
data_save{i,3} = word;
data_save{i,5} = rec_data;

save('my_database.dat','data_save','-append');
run('database2cfile.m');