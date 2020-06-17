clc

i = 16;
word = 'MOT';
word_id = 6;

vector = vqlbg(mfcc_data, 16);
data_save{i,1} = vector;
data_save{i,2} = word_id;
data_save{i,3} = word;
data_save{i,4} = 'hung'
data_save{i,5} = rec_data;

save('my_database.dat','data_save','-append');
run('database2cfile.m');