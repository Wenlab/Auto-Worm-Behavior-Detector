% Add path of this function.
%
% 2023-10-13, Yixuan Li
%

function my_add_path
cdpath = mfilename('fullpath');
cdpath = fileparts(cdpath);
cd(cdpath); % enter the folder of .m file
addpath(genpath('..')); % add the parent folder to path
end