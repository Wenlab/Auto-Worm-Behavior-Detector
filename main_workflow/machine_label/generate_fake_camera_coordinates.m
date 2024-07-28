function centerlines_camera = generate_fake_camera_coordinates(centerlines_lab)

% The smoothing algorithm I use when calculate the curvature of a
% centerline has best performance for coordinates ~ 10^2. So, if the user
% do not have centerlines in the camera coordinates, we can convert
% centerlines in lab coordinates to ~ 10^2.
%
% Yixuan Li, 2024-07-28
%

M_camera = 512; % from Colbert
M_lab = calculate_median_of_centerlines(centerlines_lab);
ratio = M_camera / M_lab;
centerlines_camera = cellfun(@(x) x*ratio, centerlines_lab, 'UniformOutput', false);

end