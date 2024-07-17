% Use the phase trajectory in the 2D space of a_1 and a_2 to label forward 
% and reversal.
%
% 2023-10-13, Yixuan Li
%

function label = use_phase_trajectory_to_label_forward_and_reversal_test(centerlines_camera,label,frame_window)

% read eigen basis
eigen_basis = readmatrix('eigen_basis.csv');

% rearrange label
label_rearranged = rearrange_label(label);

% loop to process each motion state
for i = 1:size(label_rearranged,1)
    if ~label_rearranged(i,3)
        
        % get curvature
        start_frame = label_rearranged(i,1);
        end_frame = label_rearranged(i,2);
        curvature_of_centerline_all = calculate_curvatures_of_centerlines(centerlines_camera,start_frame,end_frame);
        
        % calculate motion state
        state = get_motion_state(curvature_of_centerline_all, eigen_basis, frame_window);
        
        % add label
        for j = 1:length(state) - 1
            label(start_frame+(j-1)*frame_window:start_frame+j*frame_window-1) = state(j);
        end
        
        % add label for the last period
        j = j + 1;
        label(start_frame+(j-1)*frame_window:end_frame) = state(j);
        
    end
end

end