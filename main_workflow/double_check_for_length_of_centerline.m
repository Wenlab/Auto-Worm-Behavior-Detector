% If the worm makes no Omega turn within a video, then Tukey test in 
% round 1 may not give the right result. To fix this, I introduce a 
% double check: if in a video, the total time under median*0.75 is longer
% than 2s, then pass.
%
% 2023-09-15 Yixuan Li

function is_passed = double_check_for_length_of_centerline(...
    length_of_centerline,...
    length_threshold,...
    t_threshold)

global s2frame
count = sum(length_of_centerline < length_threshold);
if count > t_threshold * s2frame
    is_passed = 1;
else
    is_passed = 0;
end

end