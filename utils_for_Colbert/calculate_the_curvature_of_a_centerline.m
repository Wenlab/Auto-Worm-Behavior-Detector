% Calculate the curvature of a centerline.
%
% Input: a 2*100 numerical array.
% Output: a 100*1 numerical array.
%
% 2023-10-13, Yixuan Li
%

function curvature_of_centerline = calculate_the_curvature_of_a_centerline(centerline)

%% calculate d of the centerline
df = diff(centerline,1,2); % Y = diff(X,n,dim) dim = 2 means  by rows
d = cumsum([0, sqrt([1 1]*(df.^2))]);

%% use csaps to do interpolation of the centerline, cubic spline interpolation
spline_p = 0.0005; % [0,1], 0 is linear fit (using Least Square), 1 is smooth connecting
f = csaps(d,centerline,spline_p); % Cubic smoothing spline
centerline_2 = fnval(f, d);
df_2 = diff(centerline_2,1,2);
d_2 = cumsum([0, sqrt([1 1]*(df_2.^2))]);

%% use interp1 to do interpolation of the centerline, linear interpolation
n_curvpts = 100;
centerline_3 = interp1(d_2+.00001*(0:length(d_2)-1), centerline_2', 0:(d_2(end)-1)/(n_curvpts+1):(d_2(end)-1));
df_3 = diff(centerline_3,1,1);

%% use atan2 and unwrap to get the angle
theta = unwrap(atan2(-df_3(:,2), df_3(:,1))); % Why there is a '-' ??? ; and here should be no unwrap; if you only want d theta, the '-'brings no mistake
curvature_of_centerline = unwrap(diff(theta,1));

end