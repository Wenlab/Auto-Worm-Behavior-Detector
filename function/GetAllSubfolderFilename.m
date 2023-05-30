function list = GetAllSubfolderFilename(rootpath,filetype)

list=[];
Folderlist=[];
Filelist=[];
Genpath=genpath(rootpath);
semicolon_num=findstr(Genpath,';');
count = 1;
for i = 1:length(semicolon_num)
    Folderlist{i} = Genpath(count:semicolon_num(i)-1);
    count = semicolon_num(i)+1;
end
l=1;
for i = 1:length(Folderlist)
    Filelist=dir(fullfile(Folderlist{i},filetype));
    for j = 1:length(Filelist)
        list{l}=fullfile(Filelist(j).folder,Filelist(j).name);
        l=l+1;
    end
end

end