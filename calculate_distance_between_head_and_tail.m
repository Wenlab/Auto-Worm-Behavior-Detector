n = length(mcd);
distance_between_head_and_tail = zeros(n,1);
length_of_centerline = zeros(n,1);
length_of_Boundary_A = zeros(n,1);
length_of_Boundary_B = zeros(n,1);
count = 0;
for i = 1:n
    count = count + 1;
    
    centerline = reshape(mcd(i).SegmentedCenterline,2,100); % row 1 is x coordinate and row 2 is y coordinate
    centerline = centerline*(1/0.0297)+(mcd(i).StagePosition)';
    centerline = centerline*0.05/10^3; % 1 pixel = 0.05um = 0.05/10^3 mm
    
    boundary_A = reshape(mcd(i).BoundaryA,2,100); % row 1 is x coordinate and row 2 is y coordinate
    boundary_A = boundary_A*(1/0.0297)+(mcd(i).StagePosition)';
    boundary_A = boundary_A*0.05/10^3; % 1 pixel = 0.05um = 0.05/10^3 mm
    
    boundary_B = reshape(mcd(i).BoundaryB,2,100); % row 1 is x coordinate and row 2 is y coordinate
    boundary_B = boundary_B*(1/0.0297)+(mcd(i).StagePosition)';
    boundary_B = boundary_B*0.05/10^3; % 1 pixel = 0.05um = 0.05/10^3 mm
    
    distance_between_head_and_tail(i) = sum((centerline(:,1) - centerline(:,100)).^2);
    length_of_centerline(i) = calculate_the_length_of_a_centerline(centerline);
    length_of_Boundary_A(i) = calculate_the_length_of_a_centerline(boundary_A);
    length_of_Boundary_B(i) = calculate_the_length_of_a_centerline(boundary_B);
    
end

figure(1)
histogram(length_of_centerline);
figure(2)
histogram(length_of_Boundary_A);
figure(3)
histogram(length_of_Boundary_B);