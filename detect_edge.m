% return the x_max x_min y_max y_min of this video
function [x_max,x_min,y_max,y_min] = detect_edge(centerline_all)

    x_max_temp = zeros(numel(centerline_all),1);
    x_min_temp = zeros(numel(centerline_all),1);
    y_max_temp = zeros(numel(centerline_all),1);    
    y_min_temp = zeros(numel(centerline_all),1);
    for i = 1:numel(centerline_all)
        temp = max(centerline_all{i, 1},[],2);
        x_max_temp(i) = temp(1);
        y_max_temp(i) = temp(2);

        temp = min(centerline_all{i, 1},[],2);
        x_min_temp(i) = temp(1);
        y_min_temp(i) = temp(2);
    end
    x_max = max(x_max_temp);
    y_max = max(y_max_temp);
    x_min = min(x_min_temp);
    y_min = min(y_min_temp);
    
end