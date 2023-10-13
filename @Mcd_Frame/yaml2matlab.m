function mcdf=yaml2matlab(file)
% This function reads in a yaml file produced by the MindControl Software
% and exports an array of MindControl Data Frames (mcdf's) that is easy to
% manipulate in matlab.
%
% Andrew Leifer
% leifer@fas.harvard.edu
% 2 November 2010


fid = fopen(file); 

Mcd_Frame.seekToFirstFrame(fid);
k=1;
fprintf('Processing...\n');
while(~feof(fid))
    mcdf(k)=Mcd_Frame.readOneFrame(fid); %#ok<AGROW>
    k=k+1;
    if ~mod(k,10000)
        fprintf('%d frames completed\n',k);
    end
end
fprintf('%d frames completed\n',k - 1);
fclose(fid);
