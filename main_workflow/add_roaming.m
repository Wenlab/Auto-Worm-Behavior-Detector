function label_rearranged = add_roaming(mcd,label_rearranged)

% reconstruct
label = anti_rearrange(label_rearranged);

% integrate forward and reversal
label_rearranged = integrate_forward_and_reversal(label_rearranged);
label_rearranged = re_rearrange_label(label_rearranged);

% get mask
global label_number_forward_reversal
mask = label_rearranged(:,3) == label_number_forward_reversal;
indices = find(mask);

% get disps
disps_of_forward_reversal = get_disps_for_certain_motion_state(mcd, label_rearranged, label_number_forward_reversal);

% histogram of mean speed in a frame-window
global s2frame
t_threshold = 1; % s
frame_threshold = t_threshold * s2frame;
path_length_sum_all = [];
for i = 1:size(disps_of_forward_reversal,1)
    start_frame = label_rearranged(indices(i),1);
    disp = disps_of_forward_reversal{i,1};
    if size(disp,2) > frame_threshold
        for j = 1:size(disp,2) - frame_threshold

            % calculate path length
            disp_within_frame_window = disp(:,j:j + frame_threshold);
            path_length_sum = calculate_path_length(disp_within_frame_window);
            path_length_sum_all(end+1) = path_length_sum;

            % label roaming
            down_threshold = 0.10; % mm
            if path_length_sum < down_threshold
                frame_now = j + start_frame - 1;
                label(frame_now:frame_now+frame_threshold) = 4;
            end

        end
    end
end

% rearrange label
label_rearranged = rearrange_label(label);

%% Tukey test
% histogram
figure;
histogram(path_length_sum_all);
xlabel(sprintf('path length of %d second (mm)',t_threshold));
ylabel('counts');
title(sprintf('f(path length of %d second)',t_threshold));

% perform Tukey test
IQR_index = 1.5; % super parameter % bigger, stricter
[~, ~, ~, ~,...
    up_limit, down_limit, upper_bound, lower_bound] = ...
    Tukey_test(path_length_sum_all, IQR_index);

% add annotation to the histogram
annotation('textbox', [0.8, 0.8, 0.1, 0.1], 'String', sprintf('IQR index = %0.1f',IQR_index));

% visulize
draw_lines(up_limit, down_limit, upper_bound, lower_bound);

% add line
xline(down_threshold,'green--', 'Label', sprintf('%0.2f mm',down_threshold), 'LineWidth', 2);
xline(0.10,'green--', 'Label', '0.10 mm', 'LineWidth', 2);

end