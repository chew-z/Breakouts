% skrypt do importu sygna³ów z MQL
clear MQL

fid=fopen('USDJPY60_03.csv');
% Read header line
header=textscan(fid,'%*s %*s %*s %s %s %s %s %s %s %s %s',1,'Delimiter',';','CollectOutput',1); 
data = textscan(fid,'%u %u %u %f %f %f %f %f %f %f %f','HeaderLines',1,'Delimiter',';','CollectOutput',1);
fclose(fid);

tits = header{1};     % tytu³y - nag³ówki
SYNC = data{1};       % to ewentualnie mo¿na u¿yæ do synchronizacji datetime
MQL = data{2};        % biorê same dane, bez licznika barów MQL-a

clear data header fid