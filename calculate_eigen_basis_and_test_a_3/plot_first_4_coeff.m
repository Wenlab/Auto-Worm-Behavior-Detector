function plot_first_4_coeff(coeff)

figure;
for i = 1:4
    subplot(2, 2, i);
    plot(coeff(:, i));
    xlabel('segment');
    ylabel(['a_' num2str(i)]);
end

end