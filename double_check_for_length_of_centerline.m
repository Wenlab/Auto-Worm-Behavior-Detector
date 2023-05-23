function is_passed = double_check_for_length_of_centerline(...
    length_of_centerline,...
    length_threshold,...
    t_threshold)

count = sum(length_of_centerline < length_threshold);
if count > t_threshold*66
    is_passed = 1;
else
    is_passed = 0;
end

end