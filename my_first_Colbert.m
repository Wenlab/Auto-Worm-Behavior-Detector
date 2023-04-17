% load('F:\1_learning\work\Colbert\NC\NC20230312\w2\NC20230312w2_mcd.mat')
frame_range = 1:580;
center_of_centerline = zeros(length(frame_range),2);
for i = frame_range
    centerline = NC20230312w2_mcd(i).SegmentedCenterline;
    center_of_centerline(i,1:2) = calculate_the_center_of_a_centerline(centerline);
end

% Extract x and y coordinates from the data array
x = center_of_centerline(:, 1);
y = center_of_centerline(:, 2);

% Plot the x and y coordinates
plot(x, y, 'blue-o');

% Set plot title and axis labels (optional)
title('center of the centerline in a run');
xlabel('x');
ylabel('y');