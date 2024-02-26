function label = xlsx_to_label(data,add_1)

T = data;
T.label = categorical(T.label); % Convert the 'label' column to categorical
T.label = renamecats(T.label, {'turn', 'forward', 'reversal'}, {'1', '2', '3'});
T.label = str2double(cellstr(T.label));
num_array = table2array(T);
if add_1
    num_array(:,1:2) = num_array(:,1:2) + 1;
end
label = anti_rearrange_label(num_array);

end