function output = add_a_new_column(output)

    global label_number_outlier label_number_beyond_edge label_number_human_flip
    output(:, 4) = output(:, 3);
    label_number = [0,1,11,2,3,200,...
        label_number_outlier,label_number_beyond_edge,label_number_human_flip];
    for i = 1:numel(label_number)
        [str,mask] = from_number_to_str(output, label_number(i));
        output(mask, 4) = {str};
    end
    output(:, 3) = [];
    
    global s2frame
    output{1,4} = 'time (s)';
    for i = 2:size(output,1)
        output{i,4} = round((output{i,2} - output{i,1})/s2frame,2);
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