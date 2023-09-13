%% Prepare data
% Create some example data (n_samples x n_features)
X = curvature_of_centerline_all;

% centerlize the data
X_centerlized = X - mean(X);

%% Perform PCA by build-in function
[coeff, score, latent, tsquared, explained, mu] = pca(X_centerlized);

% Display explained variance
disp('Explained variance by each component:');
disp(explained);

% Cumulative explained variance
cumulative_explained = cumsum(explained);
disp('Cumulative explained variance:');
disp(cumulative_explained);

% plot first 4
for i = 1:4
    subplot(2, 2, i);
    plot(coeff(:, i));
    xlabel('segment');
    ylabel(['a_' num2str(i)]);
end

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
for i = 1:4
    subplot(2, 2, i);
    plot(eigenvectors(:, i));
    xlabel('segment');
    ylabel(['a_' num2str(i)]);
end

% plot r
figure;
radius = sqrt(eigenvectors(:, 1).^2 + eigenvectors(:, 2).^2);
plot(radius);
xlabel('segment');
ylabel('sqrt(a_1^2 + a_2^2)');

%% distribution of a_3
a_3 = curvature_of_centerline_all * eigenvectors(:, 3);
figure;
histogram(a_3,'Normalization','pdf');
xlabel('a_3');
ylabel('pdf');
title('distribution of a_3');