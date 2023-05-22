% Function to save cell array to CSV file
function cell2csv(filename, cellArray, delimiter)
    % Open the file
    file = fopen(filename, 'w');
    
    % Loop over rows and columns
    for row = 1:size(cellArray, 1)
        for col = 1:size(cellArray, 2)
            % Get the cell value
            cellValue = cellArray{row, col};
            
            % Check if the cell value is a numeric array
            if isnumeric(cellValue)
                % Convert numeric array to string
                cellValue = num2str(cellValue);
            end
            
            % Write the cell value to the file
            fprintf(file, '%s', cellValue);
            
            % Add delimiter if it's not the last column
            if col ~= size(cellArray, 2)
                fprintf(file, delimiter);
            end
        end
        
        % Add newline character after each row
        fprintf(file, '\n');
    end
    
    % Close the file
    fclose(file);
end