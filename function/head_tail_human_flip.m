function head_tail_human_flip(mcd)

% handle outliers: label NaN as outliers
all_centerline = get_all_centerline(mcd);
lengths_of_centerlines = get_lengths(all_centerline);
n_frames = length(all_centerline);
label = zeros(n_frames,1);
label = process_nan(label,lengths_of_centerlines);

% get centerline before unit conversion
global label_number_human_flip
n_frames = numel(mcd);
start_frame = 1;
end_frame = n_frames;
[centerline_all,~,~] = get_centerlines_v2(mcd,start_frame,end_frame);

mask = label == 0; % only label the unlabelled
label_flip_temp = zeros(sum(mask),1);
centerline_all = centerline_all(mask);

for i = 2:numel(label_flip_temp)-1
    head_x = centerline_all{i,1}(1,1);
    head_y = centerline_all{i,1}(2,1);
    tail_next_x = centerline_all{i+1,1}(1,100);
    tail_next_y = centerline_all{i+1,1}(2,100);
    pixel_threshold = 5;
    if abs(head_x - tail_next_x) <= pixel_threshold && abs(head_y - tail_next_y) <= pixel_threshold
        label_flip_temp(i - 1) = label_number_human_flip; % virtual Dub starts from frame 0.
        label_flip_temp(i) = label_number_human_flip;
    end
end

label_flip = zeros(n_frames,1);
label_flip(mask) = label_flip_temp;
label_flip = rearrange_label(label_flip);
label_flip = remain_rows(label_flip,label_number_human_flip);

% save
global folder_of_saved_files
file_name = 'head_tail_human_flip.csv';
output_label(label_flip, folder_of_saved_files, file_name, mcd)

end