% Perform PCA to the curvature.
%
% 2023-10-14, Yixuan Li
%

function perform_PCA(curvature_of_centerline_all)

%% Prepare data

% Create some example data (n_samples x n_features)
X = curvature_of_centerline_all;

% centerlize the data
X_centerlized = X - mean(X);

%% Perform PCA by build-in function
% [coeff, score, latent, tsquared, explained, mu] = pca(X_centerlized);
% 
% % Display explained variance
% disp('Explained variance by each component:');
% disp(explained);
% 
% % Cumulative explained variance
% cumulative_explained = cumsum(explained);
% disp('Cumulative explained variance:');
% disp(cumulative_explained);

%% Perform PCA by hand
X_covariance = X_centerlized' * X_centerlized;
[V, D] = eig(X_covariance);

% Extract the eigenvalues from the diagonal matrix D
eigenvalues = diag(D);

% Sort eigenvalues and get the sorting indices
[eigenvalues, idx] = sort(eigenvalues, 'descend');

% Sort the eigenvectors according to the sorting indices
eigenvectors = V(:, idx);

% Calculate fraction of eigenvalue
fraction_of_eigenvalue = zeros(length(eigenvalues),1);
sum_of_eigenvalue = sum(eigenvalues);
for i = 1:length(eigenvalues)
    fraction_of_eigenvalue(i) = eigenvalues(i) / sum_of_eigenvalue;
end
figure;
bar(fraction_of_eigenvalue);
xlabel('PC');
ylabel('fraction of eigenvalue');

% Calculate cumulative fraction of eigenvalue
cumulative_fraction_of_eigenvalue = cumsum(fraction_of_eigenvalue);
figure;
bar(cumulative_fraction_of_eigenvalue(1:10));
xlabel('PC');
ylabel('cumulative fraction of eigenvalue');

% plot first 4
plot_first_4_coeff(eigenvectors);

% plot r
plot_r(eigenvectors);

end