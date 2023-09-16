function label_rearranged = machine_label(mcd)

%% get centerlines
all_centerline = get_all_centerline(mcd);
lengths_of_centerlines = get_lengths(all_centerline);
n_frames = length(all_centerline);
label = zeros(n_frames,1);

%% handle outliers: label NaN as outliers
label = process_nan(label,lengths_of_centerlines);

%% protect beyond edge situation when labelling turn
label = beyond_the_edge(mcd, label);

%% label turn

% round 1, using length of the centerline
label = Tukey_test_of_length_of_centerline(label,lengths_of_centerlines);

% round 2, using Euclidean distance between head and tail
label = Tukey_test_of_distance_between_head_and_tail(label,all_centerline);

% round 3, using a_3
global frame_window
% label = use_a_3_to_label_turn(mcd,label,frame_window);

% output figs for human-double-check
global folder_of_saved_files
output_figures(folder_of_saved_files);

% end protection of beyond edge situation
global label_number_beyond_edge
label(label == label_number_beyond_edge) = 0;

%% label forward and reversal
label = use_phase_trajectory_to_label_forward_and_reversal(mcd,label,frame_window);
label_rearranged = rearrange_label(label);

%% smooth to eliminate fluctuations
label_rearranged = check_unlabelled(label_rearranged,frame_window);

end