clc
clear
close all% 初始化种群
f= @(x,y)(x-2)^2+(y-5)^2; % 函数表达式
figure(1);
ezplot(f,[-10,10],[0,30]);
N = 4;                         % 初始种群个数
d = 2;                          % 空间维数
gernerationmax= 100;                      % 最大迭代次数     
% limit = [-10, 10];                % 设置位置参数限制
% vlimit = [-1, 1];               % 设置速度限制
w = 0.8;                        % 惯性权重
c1 = 2;                       % 自我学习因子
c2 = 2;                       % 群体学习因子 
x = [0 1;0 2;1 1;1 2];%初始种群的位置
v = [1 0;1 0;1 0;1 0];                  % 初始种群的速度
xm = x;                          % 每个个体的历史最佳位置
ym = zeros(1, d);                % 种群的历史最佳位置
fxm = zeros(N, 1);               % 每个个体的历史最佳适应度
fym = inf;                      % 种群历史最佳适应度
hold on
plot(xm, f(xm), 'ro');title('初始状态图');
figure(2)% 群体更新
generation = 1;
record = zeros(gernerationmax, 1);          % 记录器
while generation <= gernerationmax
     for i=1:4
     fx(i)=f(x(i,1),x(i,2))
     end
     fx=fx';% 个体当前适应度
     for i = 1:N      
        if fxm(i) < fx(i)
            fxm(i) = fx(i);     % 更新个体历史最佳适应度
            xm(i,:) = x(i,:);   % 更新个体历史最佳位置
        end 
     end
if fym < min(fxm)
        [fym, nmax] = min(fxm);   % 更新群体历史最佳适应度
        ym = xm(nmax, :);      % 更新群体历史最佳位置
 end
    v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% 速度更新
    % 边界速度处理
    v(v > vlimit(2)) = vlimit(2);
    v(v < vlimit(1)) = vlimit(1);
    x = x + v;% 位置更新
    % 边界位置处理
    x(x > limit(2)) = limit(2);
    x(x < limit(1)) = limit(1);
    record(generation) = fym;%最大值记录
%     x0 = 0 : 0.01 : 20;
%     plot(x0, f(x0), 'b-', x, f(x), 'ro');title('状态位置变化')
%     pause(0.1)
    generation = generation+1;
end
figure(3);plot(record);title('收敛过程')
x0 = 0 : 0.01 : 20;
figure(4);plot(x0, f(x0), 'b-', x, f(x), 'ro');title('最终状态位置')
disp(['最大值：',num2str(fym)]);
disp(['变量取值：',num2str(ym)]);