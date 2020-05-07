clear all
load('my_database.dat','-mat');
sound_id=length(data_save);
my_net={length(data_save{1,1})};
data_out=zeros(5,sound_id);
data_in=[];

for km=1:centroid   %length(data_save{1,1})
    for kn=1:sound_id
    my_data = data_save{kn,1};    
    data_in = [data_in, my_data(:,km)];
    data_out(data_save{kn,2},kn) = 1;
    end
    r=rand(1,sound_id);
    [temp,index]=sort(r);
    Net=newff(data_in,data_out,20,{'tansig','purelin'});
    Net.trainParam.goal=0.0000001;
    Net.trainParam.epochs=300;
    Net=train(Net,data_in(:,index),data_out(:,index));
    data_in=[];
    my_net{km} = Net;
    save('my_database.dat','data_save','my_net','-append');
end
 
save('my_database.dat','data_save','my_net','-append');