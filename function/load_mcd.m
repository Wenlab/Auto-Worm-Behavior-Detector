function mcd = load_mcd(full_path_to_mcd)

loaded_data = load(full_path_to_mcd);
mcd = loaded_data.(char(fieldnames(loaded_data)));
disp('mcd file loaded successfully.');

end