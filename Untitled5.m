clc;
clear;
close all;
%  绘制目标函数曲线
figure(1)
[x,y]=meshgrid(-3:0.1:3,0:0.1:6);
z=(x-2).^2+(y-5).^2;
mesh(x,y,z)
view([157,38])
title('每代最优个体位置变化图','fontsize',12);
hold on
% 参数初始化
c1 = 2;%自我学习因子
c2 = 2;%群体学习因子
w=0.8;%惯性权重
maxgen = 100; % 进化次数
sizepop = 4; %种群规模
%速度边界
Vmax = 0.1;
Vmin = -0.1;
%位置边界
popmax = 10;
popmin = -10;
% 产生初始粒子位置和速度
x = [0 1;0 2;1 1;1 2]; %初始种群位置
v = [1 0;1 0;1 0;1 0]; %初始化速度
% 计算适应度
for i = 1:sizepop
fitness(i) = fun2(x(i,:)); %染色体的适应度
end
% 个体最佳位置和群体最佳位置
[bestfitness bestindex] = min(fitness);
xbest = x(bestindex,:); %群体最佳
gbest = x; %个体最佳
fitnessgbest = fitness; %个体最佳适应度值
fitnessxbest = bestfitness; %群体最佳适应度值
% 迭代寻优
for i = 1:maxgen
for j = 1:sizepop
v(j,:) = w*v(j,:)+c1*rand*(gbest(j,:)- x(j,:))+c2*rand*(xbest - x(j,:));%速度更新
%速度边界处理
v(j,find(v(j,:)>Vmax)) = Vmax;
v(j,find(v(j,:)<Vmin)) = Vmin;
x(j,:) = x(j,:) + v(j,:);%位置更新
%位置边界处理
x(j,find(x(j,:)>popmax)) = popmax;
x(j,find(x(j,:)<popmin)) = popmin;
fitness(j) = fun2(x(j,:));%适应度值更新
end
for j = 1:sizepop
% 个体最优位置更新
if fitness(j)<fitnessgbest(j)
gbest(j,:) = x(j,:);
fitnessgbest(j) = fitness(j);
end
% 群体最优位置更新
if fitness(j)<fitnessxbest
xbest = x(j,:);
fitnessxbest = fitness(j);
end
end
%描述寻优过程位置变化图
yy(i) = fitnessxbest;%每次迭代中的最优位置
plot3(xbest(1), xbest(2), fitnessxbest,'ro','MarkerFaceColor','r','linewidth',1.5);
pause(0.1);
end
% VII.输出结果
[fitnessxbest, xbest]%最优适应度值和最优位置
 plot3(xbest(1), xbest(2), fitnessxbest,'ko','MarkerFaceColor','k','linewidth',3)
 view([-70,-90])
 title('最优位置变化投影')
figure(2)
plot(yy)%绘制收敛过程
title('最优个体适应度变化图','fontsize',12);
xlabel('进化代数','fontsize',12);ylabel('适应度','fontsize',12);
