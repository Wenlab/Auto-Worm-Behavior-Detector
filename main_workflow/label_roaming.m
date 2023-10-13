% Label roaming by the path length of a time window 
%
% 2023-10-13, Yixuan Li
%

function label_rearranged = label_roaming(mcd,label_rearranged)

global s2frame
global label_number_forward_reversal

% reconstruct
label = anti_rearrange_label(label_rearranged);

% integrate forward and reversal
label_rearranged = integrate_forward_and_reversal(label_rearranged);
label_rearranged = re_rearrange_label(label_rearranged);

% get mask
mask = label_rearranged(:,3) == label_number_forward_reversal;
indices = find(mask);

% get disps
disps_of_forward_reversal = get_disps_for_certain_motion_state(mcd, label_rearranged, label_number_forward_reversal);

% set super-parameter
t_threshold = 1; % s

% s2frame
frame_threshold = t_threshold * s2frame;

% init
path_length_sum_all = [];

% loop to process each frame window
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

% show Tukey test
Tukey_test_of_speed(path_length_sum_all, t_threshold, down_threshold);

end