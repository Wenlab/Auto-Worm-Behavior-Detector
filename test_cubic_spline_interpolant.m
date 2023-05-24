figure
scatter(centerline(1,:),centerline(2,:));
hold on;
f = csaps(d,centerline,spline_p);
fnplt(f,'red')
f = csaps(d,centerline,0);
fnplt(f,'green')
f = csaps(d,centerline,1);
fnplt(f,'blue')
legend('exp data','p = 5*10^(-4)','p = 0','p = 1');

figure
f_1 = csaps(d,centerline(1,:),spline_p);
fnplt(f_1)

figure
f_2 = csaps(d,centerline(2,:),spline_p);
fnplt(f_2)