% plot number of outliers versus IQR_index to find suitable IQR_index.
%
% 2023-10-13, Yixuan Li
%

function table = plot_number_of_outliers_vs_IQR_index(train_feature, IQR_index_max)

x = [1:0.5:5 6:1:IQR_index_max];
number_of_outliers = zeros(size(x));
number_of_up_outliers = zeros(size(x));
number_of_down_outliers = zeros(size(x));

count = 0;
for IQR_index = x
    count = count + 1;
    [number_of_up_outliers(count),number_of_down_outliers(count)] = Tukey_test(train_feature, IQR_index);
    number_of_outliers(count) = number_of_up_outliers(count) + number_of_down_outliers(count);
end

figure;
scatter(x, number_of_outliers);
xlabel('IQR index');
ylabel('Number of outliers');
title('Number of Outliers vs IQR Index');

figure;
scatter(x, number_of_up_outliers);
xlabel('IQR index');
ylabel('Number of up outliers');
title('Number of Up Outliers vs IQR Index');

figure;
scatter(x, number_of_down_outliers);
xlabel('IQR index');
ylabel('Number of down outliers');
title('Number of Down Outliers vs IQR Index');

table = [x', number_of_outliers'];
end