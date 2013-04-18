N = 6000;

OHLC = MQL(end-N:end,[1:4]);
HL = MQL(end-N:end,[5,6]);
% TR = MQL(end-N:end,[7,8]);

clf
% subplot(2,1,1)
cndlV2(OHLC); 
hold all; 
plot(HL);
hold off
% subplot(2,1,2)
% plot(TR)

clear N OHLC HL