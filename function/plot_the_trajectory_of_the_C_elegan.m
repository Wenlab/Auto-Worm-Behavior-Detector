function [x,y] = plot_the_trajectory_of_the_C_elegan(mcd,start_frame,end_frame,fps)

global pixel2um unit2um
pixel2um = 1.6835;
unit2um = 0.05;
s2frame = 66;

if nargin < 4
    fps = 66;
end

root_folder_path = 'F:\1_learning\research\taxis of C.elegans\data analysis of Colbert\result\fig';
child_folder_name = ['trajectory_from_' num2str(start_frame) '_to_' num2str(end_frame)];
child_folder_path = fullfile(root_folder_path,child_folder_name);
if ~isfolder(child_folder_path)
    mkdir(child_folder_path);
end

start_segment = 40;
end_segment = 60;

% n_frame = end_frame - start_frame + 1;

count = 0;
for i = start_frame:round(s2frame/fps):end_frame
    
    count = count + 1;
    centerline = convertCoordinates(mcd(i).SegmentedCenterline, mcd(i).StagePosition);
    x(count) = mean(centerline(1,start_segment:end_segment));
    y(count) = mean(centerline(2,start_segment:end_segment));
    
end

x = x(~isnan(x));
y = y(~isnan(y));

scatter(x,y,'black');
axis equal
xlabel('x(mm)');
ylabel('y(mm)');
title(['fps = ' num2str(fps) 'Hz']);

file_name = ['fps_' num2str(fps) '.png'];
file_path = fullfile(child_folder_path,file_name);
saveas(gcf,file_path)

close;

end