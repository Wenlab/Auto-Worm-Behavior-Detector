function pj_code_Yixuan_Li_modified(mcd,filename,title_of_fig_1,run_number,istart,iend)

%% choose the clip frames and calculate variables
% 0-15% head 40-60% body

spline_p = 0.0005; % [0,1], 0 is linear fit (using Least Square), 1 is smooth connecting

% answer1 = inputdlg({'Start frame', 'End frame'}, '', 1);
% istart = str2num(answer1{1});
% iend = str2num(answer1{2});
% flip = str2num(answer{4}); %头尾翻转，不需要

n_frames = iend-istart+1; % number of frames
n_curvpts = 100; % number of curve points, also number of the points of the centerline

curvature_of_centerline_all = zeros(n_frames,n_curvpts);
angle_data = zeros(n_frames,n_curvpts+1);
time = zeros(n_frames,1);

Head_position = mcd(istart).Head;
Tail_position = mcd(istart).Tail;

worm_length=0; % body length in terms of pixels

j1=0;
j2=0;

for j = 1:n_frames
    
    % basic
    i = istart+j-1;
    centerline = reshape(mcd(i).SegmentedCenterline,2,[]);
    time(j)=mcd(i).TimeElapsed; % time of this frame
    
    % calculate d of the centerline
    df = diff(centerline,1,2); % Y = diff(X,n,dim) dim = 2 means  by rows
    d = cumsum([0, sqrt([1 1]*(df.^2))]);
    worm_length = worm_length + d(end);
    
    % use csaps to do interpolation of the centerline, cubic spline interpolation
    f = csaps(d,centerline,spline_p);
    centerline_2 = fnval(f, d);
    df_2 = diff(centerline_2,1,2);
    d_2 = cumsum([0, sqrt([1 1]*(df_2.^2))]);
    
    % use interp1 to do interpolation of the centerline, linear interpolation
    centerline_3 = interp1(d_2+.00001*(0:length(d_2)-1), centerline_2', 0:(d_2(end)-1)/(n_curvpts+1):(d_2(end)-1));
    df_3 = diff(centerline_3,1,1); 
    
    % use atan2 and unwrap to get the angle
    theta = unwrap(atan2(-df_3(:,2), df_3(:,1))); % Why there is a '-' ??? ; and here should be no unwrap; if you only want d theta, the '-'brings no mistake 
    angle_data(j,:) = theta';
    
    % use unwrap to get the delta theta
    curv = unwrap(diff(theta,1));
    curvature_of_centerline_all(j,:) = curv';    
    
end

cmap=redgreencmap;
cmap(:,3)=cmap(:,2);
cmap(:,2)=0;
origin=10;
radius=8;

worm_length = worm_length/n_frames; % average

% for filter
% answer2 = inputdlg({'time filter', 'body coord filter', 'mean=0, median=1'}, '', 1, {num2str(5), num2str(10), '0'});
answer2 = cell(3,1);
answer2{1,1} = '5';
answer2{2,1} = '10';
answer2{3,1} = '0';
timefilter = str2double(answer2{1});
bodyfilter = str2double(answer2{2});

%% plot the curvature diagram to verify the wave transmission(from head to tail)
h = fspecial('average', [timefilter bodyfilter]); % The average value of the neighborhood around each pixel was calculated to smooth the data
curvdatafiltered = imfilter(curvature_of_centerline_all*100,  h , 'replicate'); % N-D filtering of multidimensional images

figure(2);
imagesc(curvdatafiltered(:,:)); % imagesc is MATLAB function
colormap(cmap);
colorbar;
caxis([-10 10]);

hold on;
title('cuvature diagram');
set(gca,'XTICK',[1 20 40 60 80 100]);
set(gca,'XTICKLABEL',[0 0.2 0.4 0.6 0.8 1]);
y_tick=get(gca,'YTICK');
set(gca,'YTICKLABEL',time(y_tick));
xlabel('fractional distance along the centerline (head=0; tail=1)');
ylabel('time (s)');

%% extract the curvature of head and body
for i = 1:5
    CH(:,i) = mean(curvature_of_centerline_all(:,i:i+9),2); % 0-15% head; curvature_data is N*100, which means N samples and 100 features; dim = 2 is mean for each row
end
ch = mean(CH,2).*100; % head; why * 100?
cb = mean(curvature_of_centerline_all(:,40:60),2).*100; % 40-60% head

%% mark which clip sequence you're analyzing and plot curvature
% answer3 = inputdlg('Enter clip sequence:');
answer3 = cell(1,1);
answer3{1,1} = '1';

%% figure 1
figure(1)
x = istart:iend;%statframe endframe
plot(time,ch,'red',time,cb,'blue')
xlabel('time (s)')
ylabel('curvature*L')
legend('curvature of head','curvature of body')
title(title_of_fig_1)
% saveas(gcf,char(name))
fs = size(curvature_of_centerline_all,1)/(time(end)-time(1));

%% vmd of the head
[imfv,residualv,infov] = vmd(ch); % Variational mode decomposition
% plot each imf
figure(3);
for i=1:length(imfv(1,:))    
    subplot(3,2,i);
    plot(time,imfv(:,i), 'r');
    title(['IMF_' num2str(i)])
    xlabel('time (s)');
    ylabel('curvature*L');
end

imfhh = imfv(:,2)+imfv(:,3)+imfv(:,4); % 1 is noise, so just 2+3+4
imfhf = imfv(:,2)+imfv(:,3)+imfv(:,4)+imfv(:,5);

%% figure 4
figure(4)
plot(time,imfv(:,5), 'red',time,cb, 'blue');
xlabel('time (s)')
ylabel('curvature*L')
legend('IMF5','curvature of body')
title('IMF5 vs curvature of body')

%% figure 5
figure(5)
plot(time,imfv(:,5), 'red',time,imfhh, 'blue');
xlabel('time (s)')
ylabel('curvature*L')
legend('IMF5','IMF2 + IMF3 + IMF4')
title('IMF2 + IMF3 + IMF4 vs IMF 5')

%% plot original signal minus imfs
% figure(4)
% 
% subplot(3,2,1)
% plot(ch) %original signal
% xlabel('frames');
% ylabel('curvature*L');
% title('curvature of head')
% 
% subplot(3,2,2)
% plot(imfv(:,5)+imfv(:,4)+imfv(:,3)+imfv(:,2))
% xlabel('frames');
% ylabel('curvature*L');
% title('imf5+imf4+imf3+imf2')
% 
% subplot(3,2,3)
% plot(imfv(:,5)+imfv(:,4)+imfv(:,3))
% xlabel('frames');
% ylabel('curvature*L');
% title('imf5+imf4+imf3')
% 
% subplot(3,2,4)
% plot(imfv(:,5)+imfv(:,4))
% xlabel('frames');
% ylabel('curvature*L');
% title('imf5+imf4')
% 
% subplot(3,2,5)
% plot(imfv(:,5))
% xlabel('frames');
% ylabel('curvature*L');
% title('imf5')
% 
% subplot(3,2,6) %compare imf5 with the body signal
% plot(cb)
% xlabel('frames');
% ylabel('curvature*L');
% title('curvature of body')

%% plot Power Spectrum Density of each imf
% clear ifqv pxxh5 fh5 pxxhh fhh pxxhf fhf pxxb fb
% for i = 1:size(imfv,2)
%     ifqv(:,i) = instfreq(imfv(:,i),fs);
% end
% figure(5)
% for i=1:length(imfv(1,:))    
%     [pxxh5(:,i),fh5(:,i)] = periodogram(imfv(:,i),rectwin(length(imfv(:,i))),length(imfv(:,i)),fs);
%     avefreq(i) = (fh5(:,i)'*pxxh5(:,i))/sum(pxxh5(:,i));
%     areafp(i) = trapz(fh5(:,i),pxxh5(:,i));%integral power of each imf
%     subplot(4,2,i);
%     plot(fh5(:,i),pxxh5(:,i))
%     grid on
%     xlabel('Frequency (Hz)')
%     xlim([0,max(ifqv(:,i))])
%     ylabel('PSD(W/Hz)')
%     title(['Power Spectrum Density of imf ' num2str(i)])
% end
% subplot(4,2,7);
% [pxxhh,fhh] = periodogram(imfhh,rectwin(length(imfhh)),length(imfhh),fs);
% areafp(7) = trapz(fhh,pxxhh);%integral power of head high movement in the 7th column
% avefreq(7) = (fhh'*pxxhh)/sum(pxxhh);
% plot(fhh,pxxhh)
% grid on
% title('PSD of imf 2+imf 3+imf 4')
% xlim([0,5])
% xlabel('Frequency (Hz)')
% ylabel('PSD(W/Hz)')
% subplot(4,2,6);
% [pxxhf,fhf] = periodogram(imfhf,rectwin(length(imfhf)),length(imfhf),fs);
% areafp(6) = trapz(fhf,pxxhf);%integral power of head filtered movement in the 6th column
% avefreq(6) = (fhf'*pxxhf)/sum(pxxhf);
% plot(fhf,pxxhf)
% grid on
% title('PSD of imf 2+imf 3+imf 4 +imf 5')
% xlim([0,5])
% xlabel('Frequency (Hz)')
% ylabel('PSD(W/Hz)')
% subplot(4,2,8)
% cbf = lowpass(cb,3,fs);%filter body movement <3Hz
% [pxxb,fb] = periodogram(cbf,rectwin(length(cbf)),length(cbf),fs);
% areafp(8) = trapz(fb,pxxb);%integral power of body movement in the 8th column
% avefreq(8) = (fb'*pxxb)/sum(pxxb);
% plot(fb,pxxb)
% grid on
% title('filt curvature of body by 3HZ')
% xlim([0,3])
% xlabel('Frequency (Hz)')
% ylabel('PSD(W/Hz)')

%% save variables 'avefreq8','areafp8','chb','IMFV'
% avefreq8(str2double(answer3),:) = avefreq;
% areafp8(str2double(answer3),:) = areafp;
% chb{str2double(answer3)}(:,1) = istart:iend;
% chb{str2double(answer3)}(:,2) = ch; %second column being the original head data
% chb{str2double(answer3)}(:,3) = cb; %third column being the original body data
% chb{str2double(answer3)}(:,4) = imfhf;%fourth column being the vmd-based noise filtered head data
% chb{str2double(answer3)}(:,5) = cbf;% fifth column being the lowpass-based noise filtered body data
% chb{str2double(answer3)}(:,6) = time;% sixth column being the time index
% IMFV{str2double(answer3)}(:,1) = istart:iend;
% IMFV{str2double(answer3)}(:,2:6) = imfv;
% IMFV{str2double(answer3)}(:,7) = time;
% fss(str2double(answer3)) = fs;%sample frequency

%% Hausdorff distance calculation and plot
% [fh,xh] = ksdensity(ch);
% %set points
% [fa(1,:),xia(1,:)] = ksdensity(imfv(:,4)+imfv(:,3)+imfv(:,2)+imfv(:,1)); %remove imf5
% [fa(2,:),xia(2,:)] = ksdensity(imfv(:,5)+imfv(:,3)+imfv(:,2)+imfv(:,1)); %remove imf4
% [fa(3,:),xia(3,:)] = ksdensity(imfv(:,5)+imfv(:,4)+imfv(:,2)+imfv(:,1)); %remove imf3
% [fa(4,:),xia(4,:)] = ksdensity(imfv(:,5)+imfv(:,4)+imfv(:,3)+imfv(:,1)); %remove imf2
% [fa(5,:),xia(5,:)] = ksdensity(imfv(:,5)+imfv(:,4)+imfv(:,3)+imfv(:,2)); %remove imf1
% P = [xh;fh]';
% for i = 1:size(imfv,2)
%     Q{i} = [xia(i,:);fa(i,:)]';
%     hds(str2double(answer3),i) = HausdorffDist(P,Q{i});
% end
% hds = flip(hds); % reverse the array

% plot Hausdorff Distance hds
% figure(6)
% plot([1:1:size(imfv,2)],hds(str2double(answer3),:));
% xlabel('raw data minus 1,2,3,4,5')
% ylabel('Hausdorff Distance')

folder_name = fullfile('C:\Users\11097\Desktop\figure',filename,['run_' num2str(run_number)]);
mkdir(folder_name);

for i = [1,2,3,4,5]
    figure(i);  % 切换到第i个图
    % 这里是你的绘图代码，确保当前图是你想保存的图
    file_name_fig = sprintf('fig%d.png', i);  % 指定保存文件的名称
    full_file_path = fullfile(folder_name, file_name_fig);
    saveas(gcf, full_file_path);  % 保存当前图为PNG格式文件
end

end