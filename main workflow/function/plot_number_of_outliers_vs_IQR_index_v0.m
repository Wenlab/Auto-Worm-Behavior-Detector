function table_v0 = plot_number_of_outliers_vs_IQR_index_v0(train_feature, IQR_index_max)
    
    x = [1 1.5 2:IQR_index_max - 1];
    number_of_outliers = zeros(size(x));
    
    count = 0;
    for IQR_index = x
        count = count + 1;
        [number_of_outliers(count), ~] = Tukey_test_v0(train_feature, IQR_index);        
    end
    
    figure;
    scatter(x, number_of_outliers);
    xlabel('IQR index');
    ylabel('number of outliers');
    title('Number of Outliers vs IQR Index');

    table_v0 = [x', number_of_outliers'];
    
end
