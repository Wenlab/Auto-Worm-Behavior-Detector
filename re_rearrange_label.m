function result = re_rearrange_label(label_rearranged_v4)

    % I always write this kind of code when learning C, but I forget these
    % skills now.

    % 初始化结果变量
    result = [];
    currentRow = label_rearranged_v4(1, :);

    % 遍历数据行
    for i = 2:size(label_rearranged_v4, 1)
        % 如果当前行和下一行第三列相同，将其合并为一行
        if label_rearranged_v4(i, 3) == currentRow(3)
            currentRow(2) = label_rearranged_v4(i, 2);
        else
            % 将合并的行添加到结果中
            result = [result; currentRow];
            % 更新当前行为下一行
            currentRow = label_rearranged_v4(i, :);
        end
    end

    % 将最后一行添加到结果中
    result = [result; currentRow];

    disp(result);

end