function label = process_nan(label,length_of_centerline)

global label_number_outlier
mask = isnan(length_of_centerline);
label(mask) = label_number_outlier;

end