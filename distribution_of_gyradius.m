for i = 1:length(mcd)
    centerline = reshape(mcd(i).SegmentedCenterline,2,100); % row 1 is x coordinate and row 2 is y coordinate
    centerline = centerline*1.6*10^(-3); % mm
    scatter(centerline(1,:),centerline(2,:));
    hold on;
    center_of_a_centerline = mean(centerline,2);
    scatter(center_of_a_centerline(1),center_of_a_centerline(2));
    distance_square = sum((centerline - center_of_a_centerline).^2,1);
    R_g = sqrt(sum(sum((centerline - center_of_a_centerline).^2,1)));
end