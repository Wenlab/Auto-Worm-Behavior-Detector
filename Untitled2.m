function Untitled2
    data = [
        1671 1680 2;
        1681 1790 3;
        1791 1800 3;
        1801 1920 2;
        1921 1930 2;
        1931 2020 3;
        2021 2040 0;
        2041 2050 0;
        2051 2130 0;
        2131 2140 3
    ];

    % 初始化结果变量
    result = [];
    currentRow = data(1, :);

    % 遍历数据行
    for i = 2:size(data, 1)
        % 如果当前行和下一行第三列相同，将其合并为一行
        if data(i, 3) == currentRow(3)
            currentRow(2) = data(i, 2);
        else
            % 将合并的行添加到结果中
            result = [result; currentRow];
            % 更新当前行为下一行
            currentRow = data(i, :);
        end
    end

    % 将最后一行添加到结果中
    result = [result; currentRow];

    disp(result);
end