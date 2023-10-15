% Add a new column into the .csv file.
%
% 2023-10-13, Yixuan Li
%

function label_rearranged = add_a_new_column(label_rearranged, mcd)

%% change label str from number to nature language

% duplicate column 3 as column 4
label_rearranged(:, 4) = label_rearranged(:, 3);

% change column 4 from number to string
global label_number_outlier label_number_beyond_edge label_number_human_flip
label_number = [0,1,2,3,4,200,...
    label_number_outlier,label_number_beyond_edge,label_number_human_flip];
idx_original_column = 3;
for i = 1:numel(label_number)
    [str,mask] = from_number_to_str(label_rearranged, label_number(i), idx_original_column);
    label_rearranged(mask, 4) = {str};
end

% delete column 3
label_rearranged(:, 3) = [];

%% add a new column to calculate the time
label_rearranged{1,4} = 'time_s';
for i = 2:size(label_rearranged,1)
    label_rearranged{i,4} = round((mcd(label_rearranged{i,2}).TimeElapsed - mcd(label_rearranged{i,1}).TimeElapsed),2);
end

end

function [str,mask] = from_number_to_str(label_rearranged,label_number,idx_original_column)

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