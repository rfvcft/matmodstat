function [k_el, AUC, CL, MRT, V_ss] = find_params(f, k, dose)
	k_el = min([k(1) k(2) k(4)]);
	% if k_el < 0
	% 	k_el = 0;
	% end
	AUC = integral(@(x) f(x, k), 0, Inf);
	CL = dose / AUC;
	MRT = integral(@(x) x .* f(x, k), 0, Inf) / AUC;
	V_ss = CL * MRT;
end