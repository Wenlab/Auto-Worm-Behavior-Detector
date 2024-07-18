% Tukey test of the Euclidean distance between the head and the tail.
%
% 2023-10-13, Yixuan Li
%

function label = Tukey_test_of_a_3_test(label, centerlines_camera)

% only label the unlabelled
mask = label == 0;

% read eigen basis
eigen_basis = readmatrix('eigen_basis.csv');

% rearrange label
label_rearranged = rearrange_label(label);

% loop to process each state
curvature_of_centerline_all = [];
for i = 1:size(label_rearranged,1)
    if ~label_rearranged(i,3)
        
        % get curvature
        start_frame = label_rearranged(i,1);
        end_frame = label_rearranged(i,2);
        curvature_of_centerline_new = calculate_curvatures_of_centerlines(centerlines_camera,start_frame,end_frame);
        
        % vertcat
        curvature_of_centerline_all = vertcat(curvature_of_centerline_all,curvature_of_centerline_new);
        
    end
end

% calculate a_3
a_3 = curvature_of_centerline_all * eigen_basis(:, 3);

% histogram
figure;
histogram(a_3);
xlabel('a_3');
ylabel('number of frames');
title('f(Length of the centerline)');
title('f(a_3)');

% perform Tukey test
IQR_index = 2; % super parameter % bigger, stricter
[~, ~, mask_up, mask_down,...
    up_limit, down_limit, upper_bound, lower_bound] = ...
    Tukey_test(a_3, IQR_index);

% add annotation to the histogram
annotation('textbox', [0.8, 0.8, 0.1, 0.1], 'String', sprintf('IQR index = %0.1f',IQR_index));

% visulize
draw_lines(up_limit, down_limit, upper_bound, lower_bound);

% add label
label(mask) = mask_down * 1 + mask_up * 1;

end