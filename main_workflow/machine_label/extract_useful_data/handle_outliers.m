% Label nan in centerlines as outliers.
%
% They are usually the situation of worm reaching edges.
%
% 2024-07-17, Yixuan Li
%

function label = handle_outliers(label,centerlines_lab)

global label_number_outlier
lengths_of_centerlines = get_lengths(centerlines_lab);
mask = isnan(lengths_of_centerlines);
label(mask) = label_number_outlier;

end