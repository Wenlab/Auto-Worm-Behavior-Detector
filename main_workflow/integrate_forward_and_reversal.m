function label_rearranged_new = integrate_forward_and_reversal(label_rearranged)

global label_number_forward_reversal
mask = label_rearranged(:,3) == 2 | label_rearranged(:,3) == 3;
label_rearranged(mask,3) = label_number_forward_reversal;
label_rearranged_new = label_rearranged;

end