videoPath = 'F:\1_learning\research\Colbert\NC\NC20230312\w1\20230312_1921_w1_HUDS.avi';
playerPath = 'D:\Public\20220721_VirtualDub\VirtualDub-1.10.4-AMD64\Veedub64.exe';
command = sprintf('"%s" "%s"', playerPath, videoPath);
system(command);