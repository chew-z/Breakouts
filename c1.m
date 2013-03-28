B = cross3(MQL, 15000, 48);
ind = find(B(:,1));
b = B(ind,:);

x = b(:,1) .* (b(:,2) - b(:,3));
histfit(x);figure(gcf);