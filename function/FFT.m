load('C:\Users\11097\Nutstore\1\DATA_Wenlab\23.3.10 - N2 taxis Colbert - wo rawdata\data\NC\NC20230312\w1\NC20230312w1_mcd_corred.mat');
mcd = NC20230312w1_mcd;

start_frame = 12140;
end_frame = 15319;
fps = 66;
[x,y] = plot_the_trajectory_of_the_C_elegan(mcd,start_frame,end_frame,fps);

% 首先，将质心轨迹转化为复数形式
complex_trajectory = x + 1i*y;

% 计算频率向量
N = length(complex_trajectory);
f_sample = fps; % 帧率
f = f_sample*(0:floor(N/2))/N; % 频率向量

% 进行FFT
Y = fft(complex_trajectory);

% 计算振幅谱
P2 = abs(Y/N); 

% 只取一半的频谱
P1 = P2(1:floor(N/2)+1);

% 对于非直流和Nyquist频率的分量，乘以2来补偿丢失的负频率部分
P1(2:end-1) = 2*P1(2:end-1);

%
plot(f,P1) 
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

% low pass
T = 2; % s
f_threshold = 1/T;
low_pass_filter = (f < f_threshold);
low_pass_filter = [low_pass_filter, zeros(1, length(P1) - length(low_pass_filter))];



% 进行滤波
Y_filtered = Y .* low_pass_filter;

% 逆傅立叶变换
filtered_trajectory = ifft(Y_filtered);

% 分离出x和y的滤波后的轨迹
filtered_x = real(filtered_trajectory);
filtered_y = imag(filtered_trajectory);

%% plot
figure;

subplot(2,1,1)
plot(t, x, 'b-o', t, y, 'r-o');
axis equal
xlabel('t (s)');
ylabel('amplitude');
title('Original');
legend('x(t)', 'y(t)');

subplot(2,1,2)
plot(t, x_filtered, 'b-o', t, y_filtered, 'r-o');
axis equal
xlabel('t (s)');
ylabel('amplitude');
title('Filtered');
legend('x filtered(t)', 'y filtered(t)');

figure;

subplot(2,1,1)
plot(x,y,'o')
axis equal
xlabel('x(mm)');
ylabel('y(mm)');
title('Original');

subplot(2,1,2)
plot(x_filtered,y_filtered,'o')
axis equal
xlabel('x filtered(mm)');
ylabel('y filtered(mm)');
title('Filtered');