function coordinates = convertCoordinates(coord, stagePosition)
    global pixel2um unit2um
    coordinates = reshape(coord, 2, 100);
    stagePosition = stagePosition';
    stagePosition = stagePosition * unit2um / 10^3; % 1 unit = 0.05 um
    coordinates = coordinates * pixel2um / 10^3; % 1 frame = 1.6835 um
    coordinates = coordinates + stagePosition;
end