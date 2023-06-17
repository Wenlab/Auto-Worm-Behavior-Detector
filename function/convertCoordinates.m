function coordinates = convertCoordinates(centerline, stagePosition)
    global pixel2um unit2um
    coordinates = reshape(centerline, 2, 100);
    coordinates = coordinates * pixel2um / 10^3; % 1 frame = 1.6835 um
    stagePosition = stagePosition';
    stagePosition = stagePosition * unit2um / 10^3; % 1 unit = 0.05 um    
    coordinates = coordinates + stagePosition;
end