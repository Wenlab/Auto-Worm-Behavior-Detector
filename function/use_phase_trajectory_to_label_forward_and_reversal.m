function label = use_phase_trajectory_to_label_forward_and_reversal(mcd,label,frame_window)

eigen_basis = readmatrix('eigen_basis.csv'); % these 4 eigen vectors are calculated from T*100 matrix, where T is ~10^5
label_rearranged = rearrange_label(label);
for i = 1:size(label_rearranged,1)
    dbstop if error
    if ~label_rearranged(i,3)
        start_frame = label_rearranged(i,1);
        end_frame = label_rearranged(i,2);
        [curvature_of_centerline_all, ~] = get_the_curvature_of_a_period(mcd,...
            start_frame,end_frame);        
        state = get_motion_state(curvature_of_centerline_all, eigen_basis, frame_window);
        for j = 1:length(state) - 1
            label(start_frame+(j-1)*frame_window:start_frame+j*frame_window-1) = state(j);
        end
        j = j + 1;
        label(start_frame+(j-1)*frame_window:end_frame) = state(j);
    end
end

end