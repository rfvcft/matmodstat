function y = poly_exp(t, f, dose, interval, n)
	y = zeros(1, 1000);
	halved = 0;
	for i = 0:n-1
		% x = t - i * interval;
		% w = 1/3 * f(x);
		% y = y + dose * w;
		% y
		if i > 1 
			if ~halved
				if any(y((i - 1) * interval * 10 : end) > 3)
					% (i+1) * interval
					halved = 1;
					dose = dose / 2;
					% interval = interval + 2;
				end
			else
				halved = 0;
			end
		end
		y = y + dose * 1/3 * f(t - i * interval);
	end
end