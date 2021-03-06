data = xlsread('pk', 1);

params = zeros(10, 5);
t = linspace(0, 100, 1000);
sph = zeros(1, 10);
F = 0.7; % absorbtion rate
DOSE = 5; % size of single dose
for i = 1:10:100
    % i = 81;
    index = round(i / 10) + 1;
    t_data = data(i:i+9, 2);
    c_data = data(i:i+9, 3);
    sideEffect_data = data(i:i+9, 4);
    % k = [k_a, lambda, A, mu, B]
    f = @(t, k) 3 * DOSE * F * k(1) * (k(3) / (k(1) - k(2)) * (exp(-k(2) * t) - exp(-k(1) * t) ) + k(5) / (k(1) - k(4)) * (exp(-k(4) * t) - exp(-k(1) * t)));
    % k = [A, lambda, B, mu]
    % f = @t, k) k(1) .* exp(-k(2) .* t) + k(3) .* exp(-k(4) .* t);
    k0 = [0.04, 0.01, 1, 0.01, 1];
    % k0 = [1, 0.5, 1, 2];
    k_fit = fit(t_data, c_data, f, k0);
    disp(index + ": " + k_fit)
    [k_el, AUC, CL, MRT, V_ss] = find_params(f, k_fit, 3 * DOSE);
    params(index, :) = [k_el, AUC, CL, MRT, V_ss];
    f_causal = @(t) (t > 0) .* f(t, k_fit);
    % g = @(t) poly_exp(t, f_causal, 1.5, 8, 48);
    % sph = plot_data(sph, index, f, k_fit, t, t_data, c_data, sideEffect_data);
    % sph(index) = subplot(5, 2, index);
    % plot(t, g(t))
    % yline(1, 'g')
    % yline(3, 'r')
    % xlabel("Tid [h]")
    % if index == 1 || index == 6
    %     ylabel("Koncentation i plasma [mg/L]")
    % end
end
% linkaxes(sph, 'y')
% ax = axis;
% axis([ax(1:2) 0 8])
% sgtitle("Uppmätt data, anpassad funktion samt biverkningar")
% print("base_data", "-dpng")
disp("params:")
disp(params)
disp("---- min ---- mean ---- max ---- std ---- std/mean ---- (max-min)/mean")
k_el_summ = stat_summary(params(:, 1))
AUC_summ = stat_summary(params(:, 2))
CL_summ = stat_summary(params(:, 3))
MRT_summ = stat_summary(params(:, 4))
V_ss_summ = stat_summary(params(:, 5))
