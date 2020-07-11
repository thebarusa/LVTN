clc

i = 20;
word = 'TUDONG';
word_id = 2;
centroid = 16*2;

if(length(mfcc_data) > centroid)
  vector = vqlbg(mfcc_data, centroid);
  data_save{i,1} = vector;
else
  data_save{i,1} = mfcc_data;
data_save{i,2} = word_id;
data_save{i,3} = word;
data_save{i,4} = 'hung'
data_save{i,5} = rec_data;

save('my_database.dat','data_save','centroid','-append');
run('database2cfile.m');