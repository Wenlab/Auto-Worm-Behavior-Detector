function plot_the_C_elegan(mcd,start_frame,end_frame)

global pixel2um unit2um
pixel2um = 1.6835;
unit2um = 0.05;

root_folder_path = 'F:\1_learning\research\Colbert\fig';
child_folder_name = ['from_' num2str(start_frame) '_to_' num2str(end_frame)];
child_folder_path = fullfile(root_folder_path,child_folder_name);
if ~isfolder(child_folder_path)
    mkdir(child_folder_path);
end

count = 0;
for i = start_frame:end_frame
    count = count + 1;
    
    centerline = convertCoordinates(mcd(i).SegmentedCenterline, mcd(i).StagePosition);
    boundary_A = convertCoordinates(mcd(i).BoundaryA, mcd(i).StagePosition);
    boundary_B = convertCoordinates(mcd(i).BoundaryB, mcd(i).StagePosition);
    
    figure(count)
    scatter(centerline(1,:),centerline(2,:),'black');
    axis equal
    hold on
    scatter(boundary_A(1,:),boundary_A(2,:),'red');
    scatter(boundary_B(1,:),boundary_B(2,:),'blue');
    
    file_name = ['frame_' num2str(i) '.png'];
    file_path = fullfile(child_folder_path,file_name);
    saveas(gcf,file_path)
    
    close;
end

end