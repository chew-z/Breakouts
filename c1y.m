B = cross3y(MQL, 6700, 6);
ind = find(B(:,1));
b = B(ind,:);

x = b(:,1) .* (b(:,2) - b(:,3));
histfit(x);figure(gcf);