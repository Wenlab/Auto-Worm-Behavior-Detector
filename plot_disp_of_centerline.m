clc;clear;close all;
folder = 'F:\1_learning\research\Colbert\NC';
worm = 'NC20230312\w3';
file_name = 'NC20230312w3_mcd';
file_path = fullfile(folder,worm,file_name);
load(file_path);
frame_range = 1:10000;
center_of_centerline = zeros(length(frame_range),2);
for i = frame_range
    centerline = NC20230312w3_mcd(i).SegmentedCenterline;
    center_of_centerline(i-frame_range(1)+1,1:2) = calculate_the_center_of_a_centerline(centerline) + NC20230312w3_mcd(i).StagePosition;
end

% Extract x and y coordinates from the data array
x = center_of_centerline(:, 1)*1.6*10^(-3); % mm
y = center_of_centerline(:, 2)*1.6*10^(-3);

% Plot the x and y coordinates
plot(x, y, 'blue-o');

% Set plot title and axis labels (optional)
title('center of the centerline in a run');
xlabel('x (mm)');
ylabel('y (mm)');