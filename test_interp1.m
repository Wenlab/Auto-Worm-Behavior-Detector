x = 0:pi/4:2*pi; 
v = sin(x);
xq = 0:pi/16:2*pi;
figure
vq1 = interp1(x,v,xq);
plot(x,v,'o',xq,vq1,':.');
xlim([0 2*pi]);
title('(Default) Linear Interpolation');

figure
x = splen+.00001*[0:length(splen)-1];
v = cv2;
xq = [0:(splen(end)-1)/(n_curvpts+1):(splen(end)-1)];
cv2i = interp1(x, v, xq);
% plot(x,v,'o');
plot(xq,cv2i,'--');

%% 3 centerlinefigure
scatter(centerline(1,:),centerline(2,:),'black');
hold on;
scatter(centerline_2(1,:),centerline_2(2,:),'red');
scatter(centerline_3(:,1),centerline_3(:,2),'blue');
axis equal