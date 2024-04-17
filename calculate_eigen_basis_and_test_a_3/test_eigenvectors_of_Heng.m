%% load

% from Heng
load('eigen_basis_with_turn.mat');
eigenvectors = EigenWorms;

% % from Yixuan
% eigenvectors = load_data_from_csv('eigen_basis_without_turn.csv');
% 
% % from Tosif
% load('eigen_basis_Tosif.mat');
% eigenvectors = EigenWorms;

%% plot

% plot first 4
plot_first_4_coeff(eigenvectors);

% plot r
figure;
radius = sqrt(eigenvectors(:, 1).^2 + eigenvectors(:, 2).^2);
plot(radius);
xlabel('segment');
ylabel('sqrt(a_1^2 + a_2^2)');

%% dot
inner_product = eigenvectors' * eigenvectors;
inner_product(abs(inner_product) < 1e-3) = 0;