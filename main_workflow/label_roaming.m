% Label roaming by the path length of a time window 
%
% 2023-10-13, Yixuan Li
%

function label_rearranged = label_roaming(mcd,label_rearranged)

global s2frame
global label_number_forward_reversal

%% prepare

% reconstruct
label = anti_rearrange_label(label_rearranged);

% integrate forward and reversal
label_rearranged = integrate_forward_and_reversal(label_rearranged);
label_rearranged = re_rearrange_label(label_rearranged);

% get mask
mask = label_rearranged(:,3) == label_number_forward_reversal;
indices = find(mask);

%% calculate path lengths
points_of_forward_reversal = get_points_for_certain_motion_state(mcd, label_rearranged, label_number_forward_reversal);

%% label

% set super-parameter
t_threshold = 1; % s
speed_threshold = 0.10; % mm/s

% s2frame
frame_threshold = t_threshold * s2frame;

% init
path_length_sum_all = [];

% loop to process each frame window
for i = 1:size(points_of_forward_reversal,1)
    start_frame = label_rearranged(indices(i),1);
    points = points_of_forward_reversal{i,1};
    if size(points,2) > frame_threshold
        for j = 1:size(points,2) - frame_threshold

            % calculate the path length
            points_within_frame_window = points(:,j:j + frame_threshold);
            path_length_sum = calculate_path_length(points_within_frame_window);
            path_length_sum_all(end+1) = path_length_sum;

            % label roaming
            if path_length_sum < speed_threshold
                frame_now = j + start_frame - 1;
                label(frame_now:frame_now+frame_threshold) = 4;
            end

        end
    end
end

% rearrange label
label_rearranged = rearrange_label(label);

%% show Tukey test
Tukey_test_of_speed(path_length_sum_all, t_threshold, speed_threshold);

end