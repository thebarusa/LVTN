function id = nhandang(x, saiso, fs)

load('my_database.dat','-mat');  
sound_id=length(data_save);
distmin = Inf;
k1 = 0;
      
for i=1:sound_id
  d = disteu(x, data_save{i,1});
  dist = sum(min(d,[],2)) / size(d,1);
  message=strcat('# ',num2str(i), ' "', data_save{i,3}, '" Distance : ',num2str(dist));
  disp(message);
             
  if dist < distmin
    distmin = dist;
    k1 = i;
  end
end
      
  if distmin < saiso
    min_index = k1;
    dis = sprintf('Ban vua noi "%s" khop voi file so %d', data_save{min_index,3},min_index );
    msgbox(dis);
    data_play = audioplayer(data_save{min_index,5},fs);
    play(data_play);
    id = min_index;
  else
    id = NaN;
    msgbox('Khong nhan dang duoc');
  end
end