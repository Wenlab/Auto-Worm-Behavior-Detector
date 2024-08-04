function label_rearranged = integrate_into_reorientation_and_eliminate_short_run(label_rearranged)

%% integrate turn and reversal into reorientation
global s2frame
mask = label_rearranged(:,3) == 1 | label_rearranged(:,3) == 3 | label_rearranged(:,3) == 4;
label_rearranged(mask,3) = 200;

% rearrange
label_rearranged = re_rearrange_label(label_rearranged);

%% eliminate runs shorter than threshold

% label as reorientation
t_threshold_run = 5; % s
n_behavior_state = size(label_rearranged,1);
for i = 2:n_behavior_state - 1
    if label_rearranged(i,3) == 2 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold_run * s2frame
        label_rearranged(i,3) = 200;
    end
end

% for the first and the last, label as unlabelled
for i = [1, n_behavior_state]
    if label_rearranged(i,3) == 2 &&...
            label_rearranged(i,2) - label_rearranged(i,1) <= t_threshold_run * s2frame
        label_rearranged(i,3) = 0;
    end
end

% rearrange
label_rearranged = re_rearrange_label(label_rearranged);

end