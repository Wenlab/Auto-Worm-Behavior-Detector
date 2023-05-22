% Example array
array = [1; 1; 1; 0; 0; 2; 2; 2; 2; 0; 0; 1; 1; 1; 2; 2; 0; 0; 0; 1; 1; 1];

% Initialize variables
label = array(1);
start_frame = 1;
end_frame = 1;
result = [];

% Iterate over the array
for i = 2:numel(array)
    if array(i) ~= label
        % Add the start, end, and label to the result array
        result = [result; start_frame, end_frame, label];
        
        % Update the label, start_frame, and end_frame
        label = array(i);
        start_frame = i;
        end_frame = i;
    else
        % Update the end_frame
        end_frame = i;
    end
end

% Add the last label sequence to the result array
result = [result; start_frame, end_frame, label];

% Display the result
disp(result);
