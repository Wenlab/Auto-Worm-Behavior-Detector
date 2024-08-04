% Do machine label to a single mcd.mat
%
% 2023-10-13, Yixuan Li
%

function label_rearranged = machine_label(centerlines_camera, centerlines_lab, idx_beyond_edge)

%% init
n_frames = size(centerlines_camera, 1);
label = zeros(n_frames,1);

%% handle outliers: label NaN as outliers
label = handle_outliers(label, centerlines_lab);

%% label turn

% if you do not have the info of tail-beyond-edge situation, make it all 0.
if nargin == 2
    idx_beyond_edge = false(n_frames,1);
end

% label turn
label = label_turn(label, centerlines_camera, centerlines_lab, idx_beyond_edge);

%% label forward and reversal
global frame_window
label = label_forward_and_reversal(label, centerlines_camera, frame_window);

%% smooth

% rearrange label
label_rearranged = rearrange_label(label);

% smooth motion states shorter than a frame window 
label_rearranged = smooth_under_frame_window(label_rearranged);

% process the unlabelled shorter than a time window
label_rearranged = process_the_unlabelled(label_rearranged);

%% label roaming
label_rearranged = label_roaming(label_rearranged, centerlines_lab);

%% output figs for human-double-check
global folder_of_saved_files
n_figs = 3;
output_figures(folder_of_saved_files, n_figs);

end