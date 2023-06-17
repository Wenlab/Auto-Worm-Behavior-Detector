function label_rearranged = machine_label(mcd)

%% prepare
n_frames = length(mcd);
label = zeros(n_frames,1);

%% get centerlines
[length_of_centerline,centerline_all] = get_data_needed(mcd);

%% handle outliers: label NaN as outliers
label = process_nan(label,length_of_centerline);

%% bonus: label head-tail-human-flip
head_tail_human_flip(mcd, label);

%% protect beyond edge situation when labelling turn
label = beyond_the_edge(mcd, label);

%% label turn
% round 1, using length of the centerline
label = Tukey_test_of_length_of_centerline(label,length_of_centerline);

% round 2, using Euclidean distance between head and tail
label = Tukey_test_of_distance_between_head_and_tail(label,centerline_all);

% output figs to check the labelling of turn
global folder_of_saved_files
output_figures(folder_of_saved_files);

%% label forward and reversal
global label_number_beyond_edge
label(label == label_number_beyond_edge) = 0; % end protection
global frame_window
label = use_phase_trajectory_to_label_forward_and_reversal(mcd,label,frame_window);
label_rearranged = rearrange_label(label);

%% smooth to eliminate fluctuations
label_rearranged = check_unlabelled(label_rearranged,frame_window);

%% check neighbor of turns
label_rearranged = check_neighbor_of_turn(label_rearranged);

end