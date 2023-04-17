function center = calculate_the_center_of_a_centerline(centerline)

% Extract odd-indexed elements (1, 3, 5, 7, etc.)
odd_elements = centerline(1:2:end);

% Extract even-indexed elements (2, 4, 6, 8, etc.)
even_elements = centerline(2:2:end);

new_centerline = [odd_elements' even_elements'];

center = mean(new_centerline);

end