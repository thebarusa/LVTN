clc
clear all

addpath('MY FUNCTIONS');
load('my_database.dat','-mat');
ham = hamming(256);
mel = melfb_v2(20, 256, 8000);
word_id = {data_save{:,3}};
enum = unique(word_id, 'stable');

%% FILE .H
fid = fopen('dsp_coeffs.h','wt+');
fprintf(fid, '#ifndef __DSP_COEFFS_H\n');
fprintf(fid, '#define __DSP_COEFFS_H\n\n');
fprintf(fid, '#define WORD_NUM %d\n\n', length(data_save));
fprintf(fid, 'typedef enum\n{\n');
fprintf(fid, 'NO_VOICE = 0,\n');
fprintf(fid, '%s,\n', enum{1,:}); % day la ten cac word
fprintf(fid, '}voice_id;\n\n');
fprintf(fid, '#endif // __DSP_COEFFS_H\n\n');
fclose(fid);

%% FILE .C
fid = fopen('dsp_coeffs.c','wt+');
fprintf(fid, '#include <dsp_coeffs.h>\n');
fprintf(fid, '#include <math.h>\n\n');
fprintf(fid, '#define NaNf   NAN\n\n');
fprintf(fid, 'voice_id word_id[WORD_NUM] = {');
fprintf(fid, '%s,', word_id{1,:});
fprintf(fid, '};\n\n');
% du lieu hamming
fprintf(fid, 'const float HamWindow[256] = \n{\n');
for i = 1:16
  j = (i-1)*16+1;
  fprintf(fid, '%10ff,', ham(j:j+15));
  fprintf(fid, '\n');
end
fprintf(fid, '};\n\n');
% du lieu cua so mel
fprintf(fid, 'const float MelFb[20*129] = \n{\n');
for i = 1:20
  fprintf(fid, '%10ff,', mel(i,:));
  fprintf(fid, '\n');
end
fprintf(fid, '};\n\n');
% du lieu giong noi
fprintf(fid, 'const float Word[%d][20*16] = {\n',length(data_save));
for i = 1:length(data_save)
  fprintf(fid, '{ /* %s */\n', data_save{i,3});
  for j = 1:20
    fprintf(fid, '%10ff,', data_save{i,1}(j,:));
    fprintf(fid, '\n');
  end
  fprintf(fid, '},\n');
end
fprintf(fid, '};\n\n');
fclose(fid);