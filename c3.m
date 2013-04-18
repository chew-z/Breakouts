B = cross3a(MQL, 6000, 12);
T = MQL(end-6000:end,8); % 7 - trending L; 8 - trending H

ind = find(B(:,1));
b = B(ind,:); t = T(ind);

% zerujemy małe down moves 
for i = 1:length(b(:,3))
	if b(i,3) < 25
		b(i,3) = 0;
	end	
end
iind =  find(b(:,3));

x = t(iind) .* (b(iind,2) - b(iind,3)); % b(,3) down move - 


histfit(x);figure(gcf);