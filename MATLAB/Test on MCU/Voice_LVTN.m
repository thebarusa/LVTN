clear all;
close all;
clc;
addpath('MY FUNCTIONS');

saiso = 19; % sai so khi nhan dang bang VQ
fs = 8000;
data_save={8,5};
data_in=[];
data_out=zeros(5,14);
centroid=16;
load('my_database.dat','-mat');
sound_id=length(data_save);
%save('my_database.dat','data_save');
%% Tao menu 
max_menu_id = 8;
m_choice = 0;

while m_choice ~= max_menu_id
    m_choice = menu('HE THONG NHAN DANG TIENG NOI',...
            'GHI AM',...
            'PHAN TICH TIN HIEU',...
            'MFCC va CODEBOOK',...
            'Machine learning',...
            'Luu vao database',...
            'NHAN DANG',...
            'Tat figures',...
            'Exit');
    disp('                                                                  ');
    
    %% Ghi am
    if m_choice==1      
        drawnow();
        durata = input('Hay nhap thoi luong ghi am (s):');
        if isempty(durata)
           durata = 1;          
        end
        dis = sprintf('Thoi luong ghi am la:%ds', (durata) );
        disp(dis);
        rec = audiorecorder(fs,8,1);
        disp('Bat dau thu am:');
        record(rec,durata);
        while (isrecording(rec)==1)
           disp('--> Dang ghi am...');
           pause(0.5);
        end
        %recordblocking(rec,2);      
        disp('Da thu am. Bat dau phat lai...');
        play(rec);
        data_rec = getaudiodata(rec);
        data_rec = data_rec/abs(max(data_rec));
        data_plot = data_rec;
        %data_plot = bandpass(data_plot,[500;3000],fs);
        
    end
    
    %% Phan tich tin hieu audio
    if m_choice==2
        figure
        m_draw=0;
        disp('Ve tin hieu audio...');
        subplot(2,2,1);
        plot(data_rec,'b');
        title('Non pre-emphasis');
        hold on
        
        subplot(2,2,1);
        title('Pre-emphasis');  
        data_plot = filter([1 -0.9375], 1, data_rec);
        %data_plot = bandpass(data_plot,[50;3000],fs);
        plot(data_plot, 'm');
        %legend ('y = sinx','z =cosx')
        
        subplot(2,2,2);    
        data_tach = endcut(data_plot, 16, 0.3E-3, 0.06);
        plot((data_tach), 'r');
        title('Tach tu, cat khoang lang');
        
        disp('Ve pho tin hieu...');
        m_pho = fft(data_tach);
        L = length(data_tach);
        m_pho = abs(m_pho/L);
        m_pho = m_pho(1:L/2+1);
        m_pho(2:end-1) = 2*m_pho(2:end-1);
        f = fs*(0:(L/2))/L;
        subplot(2,2,3);
        plot(f,m_pho);
        xlabel('f (Hz)')
        title('Pho tin hieu');
      
        subplot(2,2,4);
        data_bao = short_energy(data_tach,128);
        plot(data_bao,'k');
        title('Duong bao tin hieu noi');
        
        
        while m_draw~=2 
            m_draw = menu('Tin hieu audio','Phat lai tin hieu da tach','Exit');
            if m_draw == 1 
              recsound=audioplayer(data_tach, fs);
              play(recsound);       
            end
            
        end
        hold off              
    end
    
    %% MFCC va tao codebook
    if m_choice==3
      disp('Ve bieu do MFCC...');
      figure
      subplot(2,1,1);
      data_mfcc = mfcc(data_tach, fs);
      plot(data_mfcc);
      title('MFCC');
      
      vector_vq = vqlbg(data_mfcc,centroid);
      subplot(2,1,2);
      plot(vector_vq);
      title('CODE BOOK');
    end
    
    %% Machine learning
    if m_choice==4
        m_machine=0;
        while m_machine~=4  
            m_machine = menu('Machine learning','HMM','NEURAL NETWORK','Exit');
            % HMM
            if m_machine==1
                m_hmm = 0;                
                while m_hmm ~= 3
                    m_hmm = menu('Hidden Markov Model','Train','Nhan dang','Exit');
                    % train
                    if m_hmm==1
                        
   
                        
                        
                end
                    
            end
            % HMM
            if m_machine==2
               
            end
            end

        
        
        end
    end
    
    %% Luu vao database
    if m_choice==5
      if (exist('my_database.dat','file')==2)
        load('my_database.dat','-mat'); 
        
        id_input = input('Nhap id cua file audio:');
        if isempty(id_input)
           id_input = sound_id + 1;
           sound_id = sound_id + 1;
           disp( num2str(id_input) );
        end
        
        reg_word = input('Nhap tu ban vua noi:','s');
        id_out = input('Nhap dau ra cua tu do:');
        man_id = input('Nhap ten nguoi noi:','s');
        data_save{id_input,1} = vector_vq;
        data_save{id_input,2} = id_out;
        data_save{id_input,3} = reg_word;
        data_save{id_input,4} = man_id;
        data_save{id_input,5} = data_tach;
        save('my_database.dat','data_save','-append');
        msgbox('Sound added to database','Database result','help');
        dis = sprintf('Da luu vao file so %d', (id_input) );
        disp(dis);
      else
        msgbox('Khong co database');
      end
    end
    
    %% NHAN DANG 
    if m_choice==6
      load('my_database.dat','-mat');  
      sound_id=length(data_save);
      distmin = Inf;
      k1 = 0;
      
      for i=1:sound_id
        d = disteu(data_mfcc, data_save{i,1});
        dist = sum(min(d,[],2)) / size(d,1);
        message=strcat('For file #',num2str(i),' Dist : ',num2str(dist));
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
      else
         msgbox('Khong nhan dang duoc');
      end
    end
    
    %% CAP NHAT DATABASE
    if m_choice==7
      disp('Tat figure...');
      close all;    
    end
end

%% EXIT
%clear all;
%close all;








