function plot_r(eigenvectors)

figure;
radius = sqrt(eigenvectors(:, 1).^2 + eigenvectors(:, 2).^2);
plot(radius);
xlabel('segment');
ylabel('sqrt(a_1^2 + a_2^2)');

end