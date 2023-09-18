% coordinates_new is (mm) and is the coordinate of absolute reference frame
function coordinates_new = convert_coordinates_and_add_stage_position(centerline, stage_position)
    global pixel2um unit2um
    coordinates_in_the_video = reshape(centerline, 2, 100);
    stage_position = stage_position';   
    coordinates_new = pixel2um / 10^3 * coordinates_in_the_video + unit2um / 10^3 * stage_position;
end