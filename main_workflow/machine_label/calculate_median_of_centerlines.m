function M = calculate_median_of_centerlines(centerlines_lab)

centerlines_lab_tmp = vertcat(centerlines_lab{:});
odd_rows = centerlines_lab_tmp(1:2:end, :);
M = median(median(odd_rows,"omitmissing"),"omitmissing");

end