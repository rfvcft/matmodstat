function sph = plot_data(sph, index, f, k, t, t_data, c_data, sideEffect_data)
    sph(index) = subplot(2, 5, index);
    plot(t, f(t, k))
    hold on
    plot(t_data, c_data)  
    bar(t_data, sideEffect_data)
    hold off
end