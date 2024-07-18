function label = label_turn(label, centerlines_camera, centerlines_lab, idx_beyond_edge)

% start protection
global label_number_beyond_edge
mask = label == 0;
label(mask) = idx_beyond_edge * label_number_beyond_edge;

% round 1, using length of the centerline
lengths_of_centerlines = get_lengths(centerlines_lab);
label = Tukey_test_of_length_of_centerline(label, lengths_of_centerlines);

% round 2, using Euclidean distance between head and tail
label = Tukey_test_of_distance_between_head_and_tail(label, centerlines_lab);

% round 3, using a_3
label = Tukey_test_of_a_3_test(label, centerlines_camera);

% round 4, using phase speed;
% label = Tukey_test_of_phase_speed(label, centerlines_camera);

% end protection
label(label == label_number_beyond_edge) = 0;

end