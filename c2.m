B = cross3(MQL, 6000, 12);
T = MQL(end-6000:end,8); % 7 - trending L; 8 - trending H

ind = find(B(:,1));
b = B(ind,:); t = T(ind);

% zbyt syntetyczne
x = t .* b(:,2); % - b(:,3)); % b(,3) down move - ujemny oznacza nie było powrotu poniżej H


histfit(x);figure(gcf);