function test_edge(mcd,start_frame,end_frame)

    fold_name = ['from_' num2str(start_frame) '_to_' num2str(end_frame)];
    full_path_to_the_folder = 'F:\1_learning\research\Colbert\fig';
    fold_name = fullfile(full_path_to_the_folder,fold_name);
    mkdir(fold_name);    

    count = 0;
    for i = start_frame:end_frame
        count = count + 1; 
        
        centerline = reshape(mcd(i).SegmentedCenterline,2,100);
        boundary_A = reshape(mcd(i).BoundaryA,2,100);
        boundary_B = reshape(mcd(i).BoundaryB,2,100);

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