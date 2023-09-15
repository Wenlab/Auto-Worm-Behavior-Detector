function length_of_centerline = calculate_the_length_of_a_centerline(centerline)
v_direction = (centerline(:,2:end) - centerline(:,1:end-1));
path_length = sqrt(sum(v_direction.^2,1));
length_of_centerline = sum(path_length);
end