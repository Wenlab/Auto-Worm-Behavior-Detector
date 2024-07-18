function [centerlines_camera, centerlines_lab, timestamps, idx_beyond_edge] = extract_useful_data(mcd)
centerlines_camera = get_all_centerlines_in_relative_frame(mcd, "offline");
centerlines_lab = get_all_centerlines_in_absolute_frame(mcd);
timestamps = get_all_timestamps(mcd)';
idx_beyond_edge = tail_beyond_edge(mcd);
end