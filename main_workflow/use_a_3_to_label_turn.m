function label = use_a_3_to_label_turn(mcd,label)

% read eigen basis
eigen_basis = readmatrix('eigen_basis.csv');

% rearrange label
label_rearranged = rearrange_label(label);

% loop to process each state
curvature_of_centerline = [];
label_idx = [];
for i = 1:size(label_rearranged,1)
    if ~label_rearranged(i,3)
        
        % get curvature
        start_frame = label_rearranged(i,1);
        end_frame = label_rearranged(i,2);
        [curvature_of_centerline_new, ~] = get_the_curvature_of_a_period(mcd,...
            start_frame,end_frame);
        
        % vertcat
        curvature_of_centerline = vertcat(curvature_of_centerline,curvature_of_centerline_new);
        label_idx = vertcat(label_idx,(start_frame:end_frame)');
        
    end
end

% calculate a_3
a_3 = curvature_of_centerline * eigen_basis(:, 3);

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

% visulize
draw_lines(up_limit, down_limit, upper_bound, lower_bound);

end