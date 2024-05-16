% Only remain the rows with certain motion state.
%
% 2023-10-13, Yixuan Li
%

function label_flip = remain_rows(label_flip,label_number_human_flip)
rows_deleted = [];
for i = 1:size(label_flip,1)
    if label_flip(i,3) ~= label_number_human_flip
        rows_deleted(end+1) = i;
    end
end
label_flip(rows_deleted,:) = [];
end