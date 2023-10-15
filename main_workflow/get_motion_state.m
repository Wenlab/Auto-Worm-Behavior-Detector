% Get the motion state of each frame window.
%
% 2023-10-13, Yixuan Li
%

function state = get_motion_state(curvature_of_centerline_all, eigen_basis, frame_window, std2mean)

if nargin < 3
    frame_window = 10;
end

if nargin < 4
    std2mean = 0.6;
end

% calculate the time series of a_1 and a_2
eigenworm = curvature_of_centerline_all * eigen_basis(:, 1:2);

% calculate dphase
phase = atan2(eigenworm(:, 2), eigenworm(:, 1));
phase_unwraped = unwrap(phase); % use unwrap to handle 2 pi problem
phase_unwrap_smoothed = conv(phase_unwraped, ones(1, 15) / 15, 'same'); % smooth by mean
dphase = gradient(phase_unwrap_smoothed); % calculate finite difference (rad/frame)

% initial state
L = size(curvature_of_centerline_all, 1); % number of samples/frames
state = zeros(floor(L / frame_window) + 1, 1);

% loop to process each time window
% Here, the algorithm is serial, so it can be designed for online label of behaviors.
for i = 1:numel(state)
    start_idx = (i - 1) * frame_window + 1;
    end_idx = min(i * frame_window, L);
    mean_ps = mean(dphase(start_idx:end_idx));
    std_ps = std(dphase(start_idx:end_idx));
    
    if std_ps < std2mean * mean_ps && mean_ps > 0
        state(i) = 2; % forward
    elseif std_ps < std2mean * abs(mean_ps) && mean_ps < 0
        state(i) = 3; % reversal
    else
        state(i) = 0; % unlabelled
    end
end

% smooth to eliminate fluctuation
for i = 2:length(state)-1
    if state(i-1) == state(i+1) && state(i-1)~= state(i)
        state(i) = state(i-1);
    end
end

end