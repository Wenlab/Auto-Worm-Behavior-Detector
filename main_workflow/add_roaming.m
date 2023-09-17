function add_roaming(mcd,label_rearranged)

label_rearranged_new = integrate_forward_and_reversal(label_rearranged);
run_disp = process_labels(label_rearranged, mcd, "forward", f_sample);

end