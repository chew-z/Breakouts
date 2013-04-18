% skrypt do importu sygna��w z MQL
clear MQL

fid=fopen('USDJPY60_03.csv');
% Read header line
header=textscan(fid,'%*s %*s %*s %s %s %s %s %s %s %s %s',1,'Delimiter',';','CollectOutput',1); 
data = textscan(fid,'%u %u %u %f %f %f %f %f %f %f %f','HeaderLines',1,'Delimiter',';','CollectOutput',1);
fclose(fid);

tits = header{1};     % tytu�y - nag��wki
SYNC = data{1};       % to ewentualnie mo�na u�y� do synchronizacji datetime
MQL = data{2};        % bior� same dane, bez licznika bar�w MQL-a

clear data header fid