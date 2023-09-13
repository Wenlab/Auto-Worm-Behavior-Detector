function [number_of_outliers, mask] = Tukey_test_v0(train_feature, IQR_index)
    
    % calculate Inter Quartile Range
    upper_percentile = 75;
    lower_percentile = 25;
    upper_bound = prctile(train_feature, upper_percentile);
    lower_bound = prctile(train_feature, lower_percentile);
    IQR = upper_bound - lower_bound;
    
    % find outliers
    up_limit = upper_bound + IQR * IQR_index;
    down_limit = lower_bound - IQR * IQR_index;
    mask_down = train_feature < down_limit ;
    mask_up = train_feature > up_limit;
    mask = mask_up | mask_down;
%     mask = train_feature >= down_limit & train_feature <= up_limit; % mask is normal, ~mask is outlier
    number_of_outliers = sum(mask_down) + sum(mask_up);
    
end
