function label_rearranged = check_neighbor_of_turn(label_rearranged)

global s2frame
t_threshold_forward = 1.5; % s
t_threshold_reversal = 1; % s
for i = 2:length(label_rearranged)-1    
    if label_rearranged(i,3) == 1
        
        % last neighbor should not be short forward
        if label_rearranged(i-1,3) == 2 &&...
                label_rearranged(i-1,2) - label_rearranged(i-1,1) <= t_threshold_forward*s2frame
            label_rearranged(i-1,3) = 1;
        end
        
        % next neighbor should not be short reversal
        if label_rearranged(i+1,3) == 3 &&...
                label_rearranged(i+1,2) - label_rearranged(i+1,1) <= t_threshold_reversal*s2frame
            label_rearranged(i+1,3) = 1;
        end
        
    end    
end
label_rearranged = re_rearrange_label(label_rearranged);

end