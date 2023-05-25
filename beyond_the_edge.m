function label = beyond_the_edge(mcd,label)

n_frames = numel(mcd);
start_frame = 1;
end_frame = n_frames;
[centerline_all,~,~] = get_centerlines_v2(mcd,start_frame,end_frame);
[x_max,x_min,y_max,y_min] = detect_edge(centerline_all);
for i = 1:n_frames
end

end