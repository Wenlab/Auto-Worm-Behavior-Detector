% Integrate forward and reversal as a new motion state in label_rearranged.
%
% 2023-10-13, Yixuan Li
%

function label_rearranged_new = integrate_forward_and_reversal(label_rearranged)

global label_number_forward_reversal
mask = label_rearranged(:,3) == 2 | label_rearranged(:,3) == 3;
label_rearranged(mask,3) = label_number_forward_reversal;
label_rearranged_new = label_rearranged;

end