function label_rearranged = add_a_new_column(label_rearranged, mcd)

    % change label str from number to nature language
    global label_number_outlier label_number_beyond_edge label_number_human_flip
    label_rearranged(:, 4) = label_rearranged(:, 3);
    label_number = [0,1,11,2,3,200,...
        label_number_outlier,label_number_beyond_edge,label_number_human_flip];
    for i = 1:numel(label_number)
        [str,mask] = from_number_to_str(label_rearranged, label_number(i));
        label_rearranged(mask, 4) = {str};
    end
    label_rearranged(:, 3) = [];
    
    % add a new column to calculate the time
    label_rearranged{1,4} = 'time_s';
    for i = 2:size(label_rearranged,1)
        label_rearranged{i,4} = round((mcd(label_rearranged{i,2}).TimeElapsed - mcd(label_rearranged{i,1}).TimeElapsed),2);
    end

end

function [str,mask] = from_number_to_str(output,label_number)

    global label_number_outlier label_number_beyond_edge label_number_human_flip
    mask = logical([0 [output{2:end, 3}] == label_number]);
    switch label_number
        case 0
            str = 'unlabelled';
        case {1, 11}
            str = 'turn';
        case 2
            str = 'forward';
        case 3
            str = 'reversal';
        case label_number_outlier
            str = 'outlier';
        case 200
            str = 'reorientation';
        case label_number_beyond_edge
            str = 'beyond the edge';
        case label_number_human_flip
            str = 'head tail human flip';
    end
    
end