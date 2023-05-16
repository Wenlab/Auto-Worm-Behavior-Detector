clear;clc;close all;

% load human label file 
option = 2;
switch option
    case 1
        human_label_file_name = 'human_label_N2.mat';
        start = 1;
        root_dir = 'C:\Users\11097\Nutstore\1\DATA_Wenlab\23.3.10 - N2 taxis Colbert - without rawdata\data';
        group = 'N2';
    case 2
        human_label_file_name = 'human_label_RIA.mat';
        start = 2;
        root_dir = 'C:\Users\11097\Nutstore\1\DATA_Wenlab\23.5.12 - RIA-twk18 Colbert no gradient - without rawdata\data';
        group = 'RIA-twk18';
end
load(human_label_file_name)
len = size(human_label, 1);

for i = start:len
    
    % load mcd
    str = char(human_label{i,1});
    filename = [str '_mcd'];    
    
    splitIndex = strfind(str, 'w');
    part1 = str(1:splitIndex-1);
    part2 = str(splitIndex:end);
    if contains(str,'Ctl')
        part3 = str(1:3);
    else
        part3 = str(1:2);
    end
    data_filename = [str '_mcd_corred.mat'];
    
    dir = fullfile(root_dir,part3,part1,part2,data_filename);
    load(dir);
    
    % main
    mcd = eval(filename); % cool
    run_number = human_label{i,2};
    istart = human_label{i,3};
    iend = human_label{i,4};
    if strcmp(part3,'WG')
        part3 = 'Ctl';
    end
    
    count = 0;
    cell_centerline = cell(iend-istart,1);
    for frame = istart:iend
        count = count + 1;
        Centerline = mcd(frame).SegmentedCenterline;
        Centerline = reshape(Centerline,2,[]);
        Centerline = Centerline*(1/0.0297)+(mcd(frame).StagePosition)';
        Centerline = Centerline*0.05/10^3; % 1 pixel = 0.05um = 0.05/10^3 mm
        cell_centerline{count} = Centerline;
    end
    human_label{i,5} = cell_centerline;
    
end