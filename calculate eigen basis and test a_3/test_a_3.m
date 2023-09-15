% get curvature
start_frame = 1;
end_frame = length(mcd);
[curvature_of_centerline_all, ~] = get_the_curvature_of_a_period(mcd,start_frame,end_frame);

% read eigen basis
eigen_basis = readmatrix('eigen_basis.csv');

% calculate time series of a_3
eigenworm_a_3 = curvature_of_centerline_all * eigen_basis(:, 3);

% 
for i = 1:4
    subplot(2, 2, i); % For a 2x2 grid
    plot(eigen_basis(:, i));
    xlabel('segment');
    ylabel(['a_' num2str(i)]);
end

figure;
radius = sqrt(eigen_basis(:, 1).^2 + eigen_basis(:, 2).^2);
plot(radius);
xlabel('segment');
ylabel('a_1^2 + a_2^2');

% hist
figure;
histogram(eigenworm_a_3,'Normalization','pdf');
xlabel('a_3');
ylabel('pdf');
title('distribution of a_3');

%% hist semilogy
% Calculate histogram data
[histCounts, histEdges] = histcounts(eigenworm_a_3, 'Normalization', 'probability');

% Calculate bin centers
binCenters = (histEdges(1:end-1) + histEdges(2:end)) / 2;

% Create semilogy plot
figure;
semilogy(binCenters, histCounts, 'bo-');
xlabel('a_3');
ylabel('pdf');
title('distribution of a_3 (semilogy)');

%% test Tukey
IQR_index_max = 10;
table = plot_number_of_outliers_vs_IQR_index(eigenworm_a_3, IQR_index_max);

% Tukey
IQR_index = 1;
[number_of_up_outliers, number_of_down_outliers, mask_up, mask_down,...
    up_limit, down_limit, upper_bound, lower_bound] =...
    Tukey_test(eigenworm_a_3, IQR_index);

%% label
label = zeros(length(mcd),1);
label(mask_up) = 111;
label(mask_down) = 111;
label_rearranged = rearrange_label(label);