function machine_label = load_machine_label(n_frame)

root_path = uigetdir;
if root_path ~= 0
    list = get_all_files_of_a_certain_type_in_a_rootpath(root_path,'*.csv');
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],...
        'Name','Chose files to convert');

    % if at least 1 file is choosed
    if tf==1
        for i = indx
            full_path_to_csv = list{i};
            data = load_data_from_csv(full_path_to_csv);
            data = data(:,1:3);
            add_1 = false;
            machine_label = xlsx_to_label(data,add_1);
        end

        % cut
        machine_label = machine_label(1:n_frame);

        % label roaming as forward
        machine_label(machine_label == 4) = 2;

    end
end
end