% Calculate path length from points.
% 
% points is 2*n numerical array
%
% 2023-10-13, Yixuan Li
%

function path_length_sum = calculate_path_length(points)

% delta_x and delta_y
disp_vectors = (points(:, 2:end) - points(:, 1:end - 1));

% sqrt(delta_x^2 + delta_y^2)
path_lengths = sqrt(sum(disp_vectors.^2, 1));

% sum
path_length_sum = sum(path_lengths);

end