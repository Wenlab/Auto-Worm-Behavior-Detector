%% input data

%% get centerline
n = length(mcd);
distance_between_head_and_tail = zeros(n,1);
length_of_centerline = zeros(n,1);
length_of_Boundary_A = zeros(n,1);
length_of_Boundary_B = zeros(n,1);
count = 0;
for i = 1:n
    count = count + 1;
    
    centerline = convertCoordinates(mcd(i).SegmentedCenterline, mcd(i).StagePosition);
    boundary_A = convertCoordinates(mcd(i).BoundaryA, mcd(i).StagePosition);
    boundary_B = convertCoordinates(mcd(i).BoundaryB, mcd(i).StagePosition);
    
    length_of_centerline(i) = calculate_the_length_of_a_centerline(centerline);
    length_of_Boundary_A(i) = calculate_the_length_of_a_centerline(boundary_A);
    length_of_Boundary_B(i) = calculate_the_length_of_a_centerline(boundary_B);
    
    distance_between_head_and_tail(i) = sum((centerline(:,1) - centerline(:,100)).^2);
    
end

figure(1)
histogram(length_of_centerline);
xlabel('mm');
title('f(length of centerline)');
figure(2)
histogram(length_of_Boundary_A);
xlabel('mm');
title('f(length of Boundary A)');
figure(3)
histogram(length_of_Boundary_B);
xlabel('mm');
title('f(length of Boundary B)');

data = {length_of_centerline, length_of_Boundary_A, length_of_Boundary_B};
titles = {'Length of Centerline', 'Length of Boundary A', 'Length of Boundary B'};

for i = 1:length(data)
    figure(i);
    histogram(data{i});
    xlabel('mm');
    title(['f(' titles{i} ')']);
end

%% Tukey test
IQR_index = 10;
[number_of_up_outliers, number_of_down_outliers, mask_up, mask_down, up_limit, down_limit] = Tukey_test(train_feature, IQR_index);
IQR_index_max = 20;
table = plot_number_of_outliers_vs_IQR_index(length_of_centerline, IQR_index_max);

%% label
label = zeros(n,1);