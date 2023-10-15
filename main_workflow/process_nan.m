% Label nan in length of centerline as outliers.
%
% They are usually the situation of worm reaching edges.
%
% 2023-10-13, Yixuan Li
%

function label = process_nan(label,length_of_centerline)

global label_number_outlier
mask = isnan(length_of_centerline);
label(mask) = label_number_outlier;

end