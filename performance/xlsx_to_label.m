function label = xlsx_to_label(table_from_csv, add_1)

% anti output label
label_rearranged = anti_output_label(table_from_csv, add_1);

% Apply anti-rearrange function to the numeric array
label = anti_rearrange_label(label_rearranged);

end