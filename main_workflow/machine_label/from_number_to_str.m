function [str,mask] = from_number_to_str(label_rearranged,label_number,idx_original_column)

% Function to convert a numeric label to its corresponding string representation and create a mask.
% Input:
%   label_rearranged - a cell array containing rearranged labels.
%   label_number - the numeric label to convert.
%   idx_original_column - the column index of the original label.
% Output:
%   str - the string representation of the label_number.
%   mask - a logical array indicating the positions of the label_number in the column.

global label_number_outlier label_number_beyond_edge label_number_human_flip
mask = logical([0 [label_rearranged{2:end, idx_original_column}] == label_number]);
switch label_number
    case 0
        str = 'unlabelled';
    case 1
        str = 'turn';
    case 2
        str = 'forward';
    case 3
        str = 'reversal';
    case 4
        str = 'roaming';
    case label_number_outlier
        str = 'outlier';
    case label_number_beyond_edge
        str = 'beyond the edge';
    case label_number_human_flip
        str = 'head tail human flip';
    case 200
        str = 'reorientation';
end

end