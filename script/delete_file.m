clc;clear;close all;
path = uigetdir;
if path ~= 0
    list = get_all_files_of_a_certain_type_in_a_rootpath(path,'*HUDS_labelled_by_machine_label_frame_window_10.avi');
    [indx,tf] = listdlg('ListString',list,'ListSize',[800,600],'Name','Chose files to convert');
    if tf==1
        for i = indx
%             full_path = list{i};
%             delete(full_path);
        end
    end
end