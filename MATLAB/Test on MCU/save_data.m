clc

i = 7
vector = vqlbg(mfcc_data, 16);
data_save{i,1} = vector;
save('my_database.dat','data_save','-append');