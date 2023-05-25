function [x_tail,y_tail] = get_tail_coord(centerline_all)

x_tail = zeros(numel(centerline_all),1);
y_tail = zeros(numel(centerline_all),1);
for i = 1:numel(centerline_all)
    x_tail(i) = centerline_all{i,1}(1,100);
    y_tail(i) = centerline_all{i,1}(2,100);
end

end