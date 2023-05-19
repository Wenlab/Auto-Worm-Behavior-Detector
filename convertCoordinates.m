function coordinates = convertCoordinates(coord, stagePosition)
    coordinates = reshape(coord, 2, 100);
    coordinates = coordinates * (1 / 0.0297) + stagePosition'; % (1 / 0.0297) is given by Runhui
    coordinates = coordinates * 0.05 / 10^3; % 1 pixel = 0.05um = 0.05/10^3 mm
end