function k1 = fit(t_data, c_data, f, k0)
	mk = @(t, k, c) norm(c - f(t, k));

	k1 = fminsearch(@(k) mk(t_data, k, c_data), k0);
	% if k1(2) < 0
	% 	k1(2) = 0;
	% end
	% if k1(4) < 0
	% 	k1(4) = 0;
	% end
end