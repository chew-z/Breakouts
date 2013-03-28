N = 100;

OHLC = MQL(end-N:end,[1:4]);
HL = MQL(end-N:end,[5,6]);

clf
cndlV2(OHLC); 
hold all; 
plot(HL);
hold off

clear N OHLC HL