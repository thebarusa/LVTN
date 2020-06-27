clc

i = 20;
word = 'TUDONG';
word_id = 2;
centroid = 16*2;

vector = vqlbg(mfcc_data, centroid);
data_save{i,1} = vector;
data_save{i,2} = word_id;
data_save{i,3} = word;
data_save{i,4} = 'hung'
data_save{i,5} = rec_data;

save('my_database.dat','data_save','centroid','-append');
run('database2cfile.m');