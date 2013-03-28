function B = cross3(MQL, N, M)
% cross3 - analizuje breakouty i fady
% jeśli nastąpiło przebicie L/H, to w ciągu M barów
% jaki był zakres ruchu do góry a jaki w dół [w pipsach]

if nargin < 3; M = 23; end
if nargin < 2; N = length(MQL)-1; end

OHLC = MQL(end-N:end,[1:4]);
HL = MQL(end-N:end,[5,6]);

B = zeros(length(OHLC), 3);

for i = 1:length(OHLC) - M
	L = HL(i,2); H = HL(i,1);
	% breakout L
	if OHLC(i, 4) < L & OHLC(i, 1) > L
		[mn, in] = min(OHLC(i+1:i+M,3));
		[mx, ix] = max(OHLC(i+1:i+M,2));
		B(i, 1) = -1; 
		B(i, 2) = (L - mn) * 10000; % up move
		B(i, 3) = (mx - L) * 10000; % down move
	end
	% breakout H
	if OHLC(i, 4) > H & OHLC(i, 1) < H
		[mn, in] = min(OHLC(i+1:i+M,3));
		[mx, ix] = max(OHLC(i+1:i+M,2));
		B(i, 1) = 1; 
		B(i, 3) = (H - mn) * 10000; % down move
		B(i, 2) = (mx - H) * 10000; % up move
	end 
end
