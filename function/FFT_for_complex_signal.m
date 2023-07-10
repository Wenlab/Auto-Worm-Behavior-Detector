% 创建一个复数信号
Fs = 1000; % 采样频率
t = 0:1/Fs:1-1/Fs; % 时间向量
f1 = 10; % 频率1
f2 = 300; % 频率2
signal = cos(2*pi*f1*t) + 1i*sin(2*pi*f2*t); % 复数信号

% 使用FFT将信号转换到频域
N = length(signal);
fftSignal = fft(signal, N);

% 创建一个低通滤波器
f_cutoff = 200; % 截止频率
filter = zeros(1, N);
filter(1:f_cutoff) = 1;
filter(end-f_cutoff+1:end) = 1; % 对于FFT，频率分量是对称的

% 在频域上应用滤波器
filteredFftSignal = fftSignal .* filter;

% 使用逆FFT将滤波后的信号转换回时域
filteredSignal = ifft(filteredFftSignal, 'symmetric');

% 绘制原始信号和滤波后的信号
figure;
subplot(2,1,1);
plot(t, abs(signal));
title('Original Signal');
subplot(2,1,2);
plot(t, abs(filteredSignal));
title('Filtered Signal');
