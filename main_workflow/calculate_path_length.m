function path_length_sum = calculate_path_length(points)

disp_vectors = (points(:, 2:end) - points(:, 1:end - 1));
path_lengths = sqrt(sum(disp_vectors.^2, 1)); % path_length is sqrt(delta_x^2 + delta_y^2)
path_length_sum = sum(path_lengths);

end