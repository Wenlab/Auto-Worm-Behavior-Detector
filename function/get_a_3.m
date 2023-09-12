function state = get_a_3(curvature_of_centerline_all, eigen_basis, frame_window)

if nargin < 3
    frame_window = 10;
end

% calculate the time series of a_1 and a_2
eigenworm_a_3 = curvature_of_centerline_all * eigen_basis(:, 3);
histogram(eigenworm_a_3);

% temp
% initial state
L = size(curvature_of_centerline_all, 1); % number of samples/frames
state = zeros(floor(L / frame_window) + 1, 1);

end