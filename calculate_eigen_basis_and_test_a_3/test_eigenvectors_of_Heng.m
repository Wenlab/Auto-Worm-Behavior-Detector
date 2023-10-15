% load eigen_basis
load('eigen_basis_with_turn.mat');

% from Heng
eigenvectors = EigenWorms;

% plot first 4
plot_first_4_coeff(eigenvectors);

% plot r
figure;
radius = sqrt(eigenvectors(:, 1).^2 + eigenvectors(:, 2).^2);
plot(radius);
xlabel('segment');
ylabel('sqrt(a_1^2 + a_2^2)');