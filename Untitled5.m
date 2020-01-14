clc;
clear;
close all;
%  ����Ŀ�꺯������
figure(1)
[x,y]=meshgrid(-3:0.1:3,0:0.1:6);
z=(x-2).^2+(y-5).^2;
mesh(x,y,z)
view([157,38])
title('ÿ�����Ÿ���λ�ñ仯ͼ','fontsize',12);
hold on
% ������ʼ��
c1 = 2;%����ѧϰ����
c2 = 2;%Ⱥ��ѧϰ����
w=0.8;%����Ȩ��
maxgen = 100; % ��������
sizepop = 4; %��Ⱥ��ģ
%�ٶȱ߽�
Vmax = 0.1;
Vmin = -0.1;
%λ�ñ߽�
popmax = 10;
popmin = -10;
% ������ʼ����λ�ú��ٶ�
x = [0 1;0 2;1 1;1 2]; %��ʼ��Ⱥλ��
v = [1 0;1 0;1 0;1 0]; %��ʼ���ٶ�
% ������Ӧ��
for i = 1:sizepop
fitness(i) = fun2(x(i,:)); %Ⱦɫ�����Ӧ��
end
% �������λ�ú�Ⱥ�����λ��
[bestfitness bestindex] = min(fitness);
xbest = x(bestindex,:); %Ⱥ�����
gbest = x; %�������
fitnessgbest = fitness; %���������Ӧ��ֵ
fitnessxbest = bestfitness; %Ⱥ�������Ӧ��ֵ
% ����Ѱ��
for i = 1:maxgen
for j = 1:sizepop
v(j,:) = w*v(j,:)+c1*rand*(gbest(j,:)- x(j,:))+c2*rand*(xbest - x(j,:));%�ٶȸ���
%�ٶȱ߽紦��
v(j,find(v(j,:)>Vmax)) = Vmax;
v(j,find(v(j,:)<Vmin)) = Vmin;
x(j,:) = x(j,:) + v(j,:);%λ�ø���
%λ�ñ߽紦��
x(j,find(x(j,:)>popmax)) = popmax;
x(j,find(x(j,:)<popmin)) = popmin;
fitness(j) = fun2(x(j,:));%��Ӧ��ֵ����
end
for j = 1:sizepop
% ��������λ�ø���
if fitness(j)<fitnessgbest(j)
gbest(j,:) = x(j,:);
fitnessgbest(j) = fitness(j);
end
% Ⱥ������λ�ø���
if fitness(j)<fitnessxbest
xbest = x(j,:);
fitnessxbest = fitness(j);
end
end
%����Ѱ�Ź���λ�ñ仯ͼ
yy(i) = fitnessxbest;%ÿ�ε����е�����λ��
plot3(xbest(1), xbest(2), fitnessxbest,'ro','MarkerFaceColor','r','linewidth',1.5);
pause(0.1);
end
% VII.������
[fitnessxbest, xbest]%������Ӧ��ֵ������λ��
 plot3(xbest(1), xbest(2), fitnessxbest,'ko','MarkerFaceColor','k','linewidth',3)
 view([-70,-90])
 title('����λ�ñ仯ͶӰ')
figure(2)
plot(yy)%������������
title('���Ÿ�����Ӧ�ȱ仯ͼ','fontsize',12);
xlabel('��������','fontsize',12);ylabel('��Ӧ��','fontsize',12);
