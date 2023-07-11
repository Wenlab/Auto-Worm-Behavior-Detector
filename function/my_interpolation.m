% 计算原始向量的长度
n = length(x);
n_insert = 3;
x_new = zeros(1, (n-1)*n_insert + n);

for i=1:n-1
    x_new( (i-1)*(n_insert+1)+1 : (i)*(n_insert+1)+1 ) = linspace(x(i), x(i+1), n_insert+2);
end
x_new(end) = x(end); 

% 使用三次样条插值计算新的y值
y_new = interp1(x, y, x_new, 'spline');

figure
scatter(x,y);
axis equal

figure
scatter(x_new,y_new);
axis equal