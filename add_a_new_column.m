function output = add_a_new_column(output)

    output(:, 4) = output(:, 3);
    label_number = [0,1,11,100];
    for i = 1:numel(label_number)
        [str,mask] = from_number_to_str(output, label_number(i));
        output(mask, 4) = {str};
    end

end

function [str,mask] = from_number_to_str(output,label_number)

    mask = logical([0 [output{2:end, 3}] == label_number]);
    switch label_number
        case 0
            str = 'unlabeled';
        case {1, 11}
            str = 'turn';
        case 2
            str = 'forward';
        case 3
            str = 'reversal';
        case 100
            str = 'outlier';
    end
    
end