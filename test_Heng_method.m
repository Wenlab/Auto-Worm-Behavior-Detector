eigen_basis = readmatrix('eigen_basis.csv');
state = get_motion_state(curvature_of_centerline_all, eigen_basis);