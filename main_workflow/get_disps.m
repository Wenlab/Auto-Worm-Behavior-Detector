% get disp(mm) in the absolute reference frame from start frame to end
% frame. start_frame, end_frame are n*1 array
%
% 2023-09-17, Yixuan Li
%

function disps = get_disps(mcd,start_frame,end_frame)

% consider the mean of start_segment:end_segment as the center of mass
start_segment = 40;
end_segment = 60;

% loop to get the disp for each period
n = length(start_frame);
disps = cell(n,1);
for i = 1:n

    % Create array of frames
    frames = start_frame(i):end_frame(i);
    
    % Initialize
    x = nan(1, length(frames));
    y = nan(1, length(frames));

    % Loop over frames
    for j = 1:length(frames)

        centerline = convert_coordinates_and_add_stage_position(mcd(frames(j)).SegmentedCenterline, mcd(frames(j)).StagePosition);
        x(j) = mean(centerline(1,start_segment:end_segment),'omitnan');
        y(j) = mean(centerline(2,start_segment:end_segment),'omitnan'); 

    end

    % store
    disps{i,1} = [x(~isnan(x)); y(~isnan(y))];

end

end