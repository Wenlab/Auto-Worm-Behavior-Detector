% Save an array to .mat, where the filename is the name of the var
%
% 2023-10-14, Yixuan Li
%

function save_as_mat(save_folder, var_value)

    % get var_name
    var_name = inputname(2);  % '2' specifies the second input argument
    
    % re-get var_value
    eval([var_name '= var_value;']);
    
    % save
    save_full_path = fullfile(save_folder, [var_name, '.mat']);
    save(save_full_path, var_name);
    
    % disp
    disp([var_name, '.mat saved successfully!']);
    
end