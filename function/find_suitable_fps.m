load('C:\Users\11097\Nutstore\1\DATA_Wenlab\23.3.10 - N2 taxis Colbert - wo rawdata\data\NC\NC20230312\w1\NC20230312w1_mcd_corred.mat');
mcd = NC20230312w1_mcd;

start_frame = 12140;
end_frame = 15319;

for fps = 0.5
    [x,y] = plot_the_trajectory_of_the_C_elegan(mcd,start_frame,end_frame,fps);
end