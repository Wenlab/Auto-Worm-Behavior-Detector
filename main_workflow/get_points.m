% Get points (mm) of the center of mass of C.elegans in the absolute 
% reference frame from the start frame to the end frame.
%
% The center of mass is defined as the Euclidean geometry center of 
% start_segment:end_segment. 40:60 is recommended, because in roaming, the
% central region of C.elegans is usually in a low speed while the head is
% usually being shaken.
% 
% start_frame, end_frame are n*1 numerical array
%
% 2023-09-17, Yixuan Li
%

function points = get_points(mcd,start_frame,end_frame)

% consider the Euclidean geometry center of start_segment:end_segment as the center of mass
start_segment = 40;
end_segment = 60;

% loop to get the disp for each period
n_period = length(start_frame);
points = cell(n_period,1);
for i = 1:n_period

    % Create array of frames
    frames = start_frame(i):end_frame(i);
    
    % Initialize
    x = nan(1, length(frames));
    y = nan(1, length(frames));

    % Loop over frames
    for j = 1:length(frames)

        % get centerline (mm) in the absolute frame
        centerline = convert_coordinates_and_add_stage_position(mcd(frames(j)).SegmentedCenterline, mcd(frames(j)).StagePosition);
        
        % get x and y coordinates
        x(j) = mean(centerline(1,start_segment:end_segment),'omitnan');
        y(j) = mean(centerline(2,start_segment:end_segment),'omitnan'); 

    end

    % store
    points{i,1} = [x(~isnan(x)); y(~isnan(y))];

end

end