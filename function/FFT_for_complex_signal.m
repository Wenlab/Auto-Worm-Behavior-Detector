% 创建一个复数信号
Fs = 10000; % 采样频率
t = 0:1/Fs:1-1/Fs; % 时间向量
f1 = 10; % 频率1
f2 = 100; % 频率2
signal = cos(2*pi*f1*t) + 1i*(sin(2*pi*f1*t)+0.05*sin(2*pi*f2*t)); % 复数信号

% 使用FFT将信号转换到频域
N = length(signal);
fftSignal = fft(signal, N);

% 创建一个低通滤波器
f_cutoff = 50; % 截止频率
filter = zeros(1, N);
filter(1:f_cutoff) = 1;
filter(end-f_cutoff+1:end) = 1; % 对于FFT，频率分量是对称的

% 在频域上应用滤波器
filteredFftSignal = fftSignal .* filter;

% 使用逆FFT将滤波后的信号转换回时域
filteredSignal = ifft(filteredFftSignal);

% 在二维坐标系中绘制滤波前后的信号
figure;
plot(real(signal), imag(signal));
title('Original Signal');
xlabel('cos(2*pi*f1*t)');
ylabel('sin(2*pi*f2*t)');
xlim([-1 +1]);
axis equal;

figure;
plot(real(filteredSignal), imag(filteredSignal));
title('Filtered Signal');
xlabel('cos(2*pi*f1*t)');
ylabel('sin(2*pi*f2*t)');
xlim([-1 +1]);
axis equal;