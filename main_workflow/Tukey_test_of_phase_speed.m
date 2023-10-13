% Tukey test of the phase speed in the 2D space of a_1 and a_2.
%
% 2023-10-13, Yixuan Li
%

function Tukey_test_of_phase_speed(mcd,label)

% read eigen basis
eigen_basis = readmatrix('eigen_basis.csv');

% rearrange label
label_rearranged = rearrange_label(label);

% loop to process each motion state
dphase_abs_sum_all = [];
for i = 1:size(label_rearranged,1)
    if ~label_rearranged(i,3)
        
        % get curvature
        start_frame = label_rearranged(i,1);
        end_frame = label_rearranged(i,2);
        [curvature_of_centerline_all, ~] = get_the_curvature_of_a_period(mcd,...
            start_frame,end_frame);
        
        % calculate the time series of a_1 and a_2
        eigenworm = curvature_of_centerline_all * eigen_basis(:, 1:2);
        
        % calculate dphase
        phase = atan2(eigenworm(:, 2), eigenworm(:, 1));
        phase_unwraped = unwrap(phase); % use unwrap to handle 2 pi problem
        phase_unwrap_smoothed = conv(phase_unwraped, ones(1, 15) / 15, 'same'); % smooth by mean
        dphase = gradient(phase_unwrap_smoothed); % calculate finite difference (rad/frame)
        
        % calculate sum of abs dphase for every time window
        frame_window = 10; % super-parameter
        dphase_abs = abs(dphase); % rad per frame
        extended_length = ceil(length(dphase_abs) / frame_window) * frame_window;
        dphase_abs_extended = [dphase_abs; zeros(extended_length - length(dphase_abs), 1)];
        dphase_abs_extended_reshaped = reshape(dphase_abs_extended, frame_window, []);
        dphase_abs_sum = sum(dphase_abs_extended_reshaped, 1)' / pi * 180; % angle per frame_window
        dphase_abs_sum_all = vertcat(dphase_abs_sum_all,dphase_abs_sum); % angle per frame_window
    end
end

% let the outliers to be the median
up_limit = 60;
dphase_abs_sum_all(dphase_abs_sum_all > up_limit) = median(dphase_abs_sum_all);

%% plot

% histogram
figure;
histogram(dphase_abs_sum_all);
xlabel(sprintf('$\\Delta \\theta$ (deg per %d frames)',frame_window), 'Interpreter', 'latex');
ylabel('counts');
title('$f(\Delta \theta)$', 'Interpreter', 'latex');
subtitle('Here, $\Delta \theta$ means phase angle difference', 'Interpreter', 'latex')

% perform Tukey test
IQR_index = 1.5; % super parameter % bigger, stricter
[~, ~, ~, ~,...
    up_limit, down_limit, upper_bound, lower_bound] = ...
    Tukey_test(dphase_abs_sum_all, IQR_index);

% add annotation to the histogram
annotation('textbox', [0.8, 0.8, 0.1, 0.1], 'String', sprintf('IQR index = %0.1f',IQR_index));

% visulize
draw_lines(up_limit, down_limit, upper_bound, lower_bound);

end