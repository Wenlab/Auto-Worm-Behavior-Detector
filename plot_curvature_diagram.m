function plot_curvature_diagram(curvature_of_centerline_all,time)

% for filter
timefilter = 5;
bodyfilter = 10;

% plot the curvature diagram to verify the wave transmission(from head to tail)
h = fspecial('average', [timefilter bodyfilter]); % The average value of the neighborhood around each pixel was calculated to smooth the data
curvdatafiltered = imfilter(curvature_of_centerline_all*100,  h , 'replicate'); % N-D filtering of multidimensional images

figure;
imagesc(curvdatafiltered(:,:)); % imagesc is MATLAB function
cmap=redgreencmap;
cmap(:,3)=cmap(:,2);
cmap(:,2)=0;
colormap(cmap);
colorbar;
caxis([-10 10]);
hold on;
title('curvature diagram');
set(gca,'XTICK',[1 20 40 60 80 100]);
set(gca,'XTICKLABEL',[0 0.2 0.4 0.6 0.8 1]);
% y_tick=get(gca,'YTICK');
% set(gca,'YTICKLABEL',time(y_tick));
xlabel('fractional distance along the centerline (head=0; tail=1)');
ylabel('time (s)');

end