function plot_the_C_elegan(mcd,start_frame,end_frame)

    fold_name = ['from_' num2str(start_frame) '_to_' num2str(end_frame)];
    full_path_to_the_folder = 'F:\1_learning\research\Colbert\fig';
    fold_name = fullfile(full_path_to_the_folder,fold_name);
    mkdir(fold_name);    

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
        full_path_to_the_file = fullfile(fold_name,file_name);
        saveas(gcf,full_path_to_the_file)
        
        close;
    end

end