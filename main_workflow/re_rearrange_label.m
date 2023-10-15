% Merge neighbors with the same motion state in label_rearranged.
%
% 2023-10-13, Yixuan Li
%

function result = re_rearrange_label(label_rearranged)

    % init
    result = [];
    currentRow = label_rearranged(1, :);

    % loop to process each row
    for i = 2:size(label_rearranged, 1)

        % if currentRow's motion state is the same as next row's, merge them
        if label_rearranged(i, 3) == currentRow(3)
            currentRow(2) = label_rearranged(i, 2);
        else

            % put current row into the result
            result = [result; currentRow];

            % update
            currentRow = label_rearranged(i, :);

        end

    end

    % put the last row into the result
    result = [result; currentRow];

end