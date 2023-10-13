% Perform Tukey test
%
% 2023-10-13, Yixuan Li
%

function [number_of_up_outliers, number_of_down_outliers, mask_up, mask_down,...
    up_limit, down_limit, upper_bound, lower_bound] =...
    Tukey_test(train_feature, IQR_index)
    
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
    number_of_down_outliers = sum(mask_down);
    number_of_up_outliers = sum(mask_up);
    
end
