function label = use_a_3_to_label_turn(mcd,label,frame_window)

% read eigen basis
eigen_basis = readmatrix('eigen_basis.csv');

% rearrange label
label_rearranged = rearrange_label(label);

% loop to process each state
for i = 1:size(label_rearranged,1)
    if ~label_rearranged(i,3)
        start_frame = label_rearranged(i,1);
        end_frame = label_rearranged(i,2);
        [curvature_of_centerline_all, ~] = get_the_curvature_of_a_period(mcd,...
            start_frame,end_frame);
        state = get_a_3(curvature_of_centerline_all, eigen_basis, frame_window);
        for j = 1:length(state) - 1
            label(start_frame+(j-1)*frame_window:start_frame+j*frame_window-1) = state(j);
        end
        j = j + 1;
        label(start_frame+(j-1)*frame_window:end_frame) = state(j);
    end
end

end