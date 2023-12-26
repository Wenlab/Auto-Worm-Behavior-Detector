function plot_trajectory_in_phase_space(curvature_of_centerline_all, eigen_basis)

figure;
trajectory = curvature_of_centerline_all * eigen_basis(:, 1:2);
scatter(trajectory(:,1),trajectory(:,2));
xlabel('a_1');
ylabel('a_2');
title('trajectory in phase space');
axis equal;
lim = 0.65;
xlim([-lim +lim]);
ylim([-lim +lim]);

end