% Get all files containing a certain name pattern in a rootpath.
%
% 2023-10-13, Yixuan Li
%

function list = get_all_files_of_a_certain_type_in_a_rootpath(rootpath, filetype)

% Obtain all the subfolders recursively
folders = string(split(genpath(rootpath), pathsep));
folders = folders(1:length(folders)-1);

% Initialize an empty cell array to hold filenames
list = {};

% Convert string array to cell array for the loop
folders = cellstr(folders);

% Loop over all folders
for i = 1:length(folders)
    % Get a list of all files in the folder that match the filetype
    files = dir(fullfile(folders{i}, filetype));
    
    % Loop over all files and append to the list
    for j = 1:length(files)
        list{end+1} = fullfile(files(j).folder, files(j).name);
    end
    
end

end