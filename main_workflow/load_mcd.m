% Load a single mcd
%
% 2023-10-13, Yixuan Li
%

function mcd = load_mcd(full_path_to_mcd)

loaded_data = load(full_path_to_mcd);
mcd = loaded_data.(char(fieldnames(loaded_data))); % magic
disp('mcd file loaded successfully.');

end