% 假设 x 和 y 是你原始的数据向量
% x = [...];  % x坐标向量
% y = [...];  % y坐标向量

% 计算原始向量的长度
n = length(x);

% 你希望在每两个原始数据点之间插入的新点的数量
n_insert = 4;

% 生成新的t向量，包含原始t向量中的点以及你想要插入的新点
t = 0:(n-1);  % 原始的参数向量
t_new = zeros(1, (n-1)*(n_insert+1) + 1);  % 初始化新t向量，长度为(n-1)*(n_insert+1) + 1

% 将原始的t向量和新的t值插入到新的t向量中
for i=1:n-1
    t_new((i-1)*(n_insert+1)+1:(i)*(n_insert+1)+1) = linspace(t(i), t(i+1), n_insert+2);
end

% 分别对x(t)和y(t)进行三次样条插值
x_new = interp1(t, x, t_new, 'spline');
y_new = interp1(t, y, t_new, 'spline');

% 新的x和y向量即为x_new和y_new
figure
scatter(x,y);
axis equal

figure
scatter(x_new,y_new);
axis equal