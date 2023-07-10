load('C:\Users\11097\Nutstore\1\DATA_Wenlab\23.3.10 - N2 taxis Colbert - wo rawdata\data\NC\NC20230312\w1\NC20230312w1_mcd_corred.mat');
mcd = NC20230312w1_mcd;

start_frame = 12140;
end_frame = 15319;
fps = 66;
[x,y] = plot_the_trajectory_of_the_C_elegan(mcd,start_frame,end_frame,fps);

% 计算极径和极角
r = sqrt(x.^2 + y.^2);
theta = atan2(y, x);

% 对极径进行傅里叶变换
R = fft(r);

% 设计一个低通滤波器，滤掉高于0.5Hz的分量
% 这里假设你的视频的帧率是framerate
f_sample = fps;
N = length(r);
f = (0:N-1)*(f_sample/N); % 频率向量
H = f < 0.5; % 低通滤波器，对于高于0.5Hz的频率，H为0；否则，H为1

% 应用滤波器
R_filtered = R .* H;

% 逆傅里叶变换，得到滤波后的极径
r_filtered = real(ifft(R_filtered));

% 将滤波后的极径和原始的极角转换回x和y坐标
x_filtered = r_filtered .* cos(theta);
y_filtered = r_filtered .* sin(theta);
