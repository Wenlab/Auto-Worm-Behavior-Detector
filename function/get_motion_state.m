function state = get_motion_state(curvature_of_centerline_all, eigen_basis, frame_window, std2mean)
   
    if nargin < 3
        frame_window = 10;
    end
    
    if nargin < 4
        std2mean = 0.6;
    end
    
    eigenworm = curvature_of_centerline_all * eigen_basis(:, 1:2);
    L = size(curvature_of_centerline_all, 1);
    phase = atan2(eigenworm(:, 2), eigenworm(:, 1));
    phase_unwrap = unwrap(phase);
    phase_unwrap_sm = conv(phase_unwrap, ones(1, 15) / 15, 'same');
    dphase = gradient(phase_unwrap_sm, 0.01);
    state = zeros(floor(L / frame_window) + 1, 1);
    
    for i = 1:numel(state) % Here, the algorithm is serial, so it can be designed for online label of behaviors.
        start_idx = (i - 1) * frame_window + 1;
        end_idx = min(i * frame_window, L);
        mean_ps = mean(dphase(start_idx:end_idx));
        std_ps = std(dphase(start_idx:end_idx));
        
        if std_ps < std2mean * mean_ps && mean_ps > 0
            state(i) = 2;
        elseif std_ps < std2mean * abs(mean_ps) && mean_ps < 0
            state(i) = 3;
        else
            state(i) = 0;
        end
    end
    
    % smooth to eliminate fluctuation
    for i = 2:length(state)-1
        if state(i-1) == state(i+1) && state(i-1)~= state(i)
            state(i) = state(i-1);
        end
    end
    
end