start_frame = 1;
end_frame = numel(mcd);
% test_edge(mcd,start_frame,end_frame);
% plot_the_C_elegan(mcd,start_frame,end_frame);
[centerline_all,boundary_A_all,boundary_B_all] = get_centerlines_v2(mcd,start_frame,end_frame);

x_max = [];
x_min = [];
y_max = [];
y_min = [];
[x_max(end+1),x_min(end+1),y_max(end+1),y_min(end+1)] = detect_edge(centerline_all);
[x_max(end+1),x_min(end+1),y_max(end+1),y_min(end+1)] = detect_edge(boundary_A_all);
[x_max(end+1),x_min(end+1),y_max(end+1),y_min(end+1)] = detect_edge(boundary_B_all);

table = [x_max;x_min;y_max;y_min];

left_column = {[]; 'X Max'; 'X Min'; 'Y Max'; 'Y Min'};
headers = {'centerline','boundary A','boundary B'};
table = [headers; num2cell(table)];
table = [left_column, table];

% Writing the table to a .csv file
filename = 'edge_detection_w5.csv';
cell2csv(filename, table, ',');

% hist
figure;
histogram(x_max_temp)

figure;
histogram(x_min_temp)

figure;
histogram(y_max_temp)

figure;
histogram(y_min_temp)