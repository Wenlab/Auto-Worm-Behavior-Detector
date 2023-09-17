function label_rearranged_new = integrate_forward_and_reversal(label_rearranged)

mask = label_rearranged(:,3) == 1 | label_rearranged(:,3) == 3;
label_rearranged(mask,3) = 103;
label_rearranged_new = label_rearranged;

end