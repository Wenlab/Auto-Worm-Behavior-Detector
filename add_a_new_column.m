function output = add_a_new_column(output)

    output(:, 4) = output(:, 3);
    label_number = [0,1,11,2,3,100,200];
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
        case 100
            str = 'outlier';
        case 200
            str = 'reorientation';
    end
    
end