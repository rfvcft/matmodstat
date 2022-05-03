function vec = stat_summary(v)
	vec = zeros(1, 6);
	vec(1) = min(v);
	vec(2) = mean(v);
	vec(3) = max(v);
	vec(4) = std(v);
	vec(5) = vec(4) / vec(2);
	vec(6) = (vec(3) - vec(1)) / vec(2);
end