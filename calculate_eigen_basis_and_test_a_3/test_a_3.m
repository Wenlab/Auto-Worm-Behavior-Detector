% Plot the histogram of a_3.
%
% input: N*100 numerical array
%
% 2023-10-14, Yixuan Li
%

function test_a_3(curvature_of_centerline_all)

% load eigen_basis
load('eigen_basis_with_turn.mat');

% calculate a_3
a_3 = curvature_of_centerline_all * EigenWorms(:,3);

% handle outliers
fprintf('Number of Outliers: %d\n', sum(abs(a_3) > 1));
a_3(abs(a_3) > 1) = 0;

% plot histogram and use Gauss to fit
Gauss_fit(a_3);

% Tukey
IQR_index = 2;
[number_of_up_outliers, number_of_down_outliers, mask_up, mask_down,...
    up_limit, down_limit, upper_bound, lower_bound] =...
    Tukey_test(a_3, IQR_index);

end