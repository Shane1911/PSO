clc
clear
close all% ��ʼ����Ⱥ
f= @(x,y)(x-2)^2+(y-5)^2; % �������ʽ
figure(1);
ezplot(f,[-10,10],[0,30]);
N = 4;                         % ��ʼ��Ⱥ����
d = 2;                          % �ռ�ά��
gernerationmax= 100;                      % ����������     
% limit = [-10, 10];                % ����λ�ò�������
% vlimit = [-1, 1];               % �����ٶ�����
w = 0.8;                        % ����Ȩ��
c1 = 2;                       % ����ѧϰ����
c2 = 2;                       % Ⱥ��ѧϰ���� 
x = [0 1;0 2;1 1;1 2];%��ʼ��Ⱥ��λ��
v = [1 0;1 0;1 0;1 0];                  % ��ʼ��Ⱥ���ٶ�
xm = x;                          % ÿ���������ʷ���λ��
ym = zeros(1, d);                % ��Ⱥ����ʷ���λ��
fxm = zeros(N, 1);               % ÿ���������ʷ�����Ӧ��
fym = inf;                      % ��Ⱥ��ʷ�����Ӧ��
hold on
plot(xm, f(xm), 'ro');title('��ʼ״̬ͼ');
figure(2)% Ⱥ�����
generation = 1;
record = zeros(gernerationmax, 1);          % ��¼��
while generation <= gernerationmax
     for i=1:4
     fx(i)=f(x(i,1),x(i,2))
     end
     fx=fx';% ���嵱ǰ��Ӧ��
     for i = 1:N      
        if fxm(i) < fx(i)
            fxm(i) = fx(i);     % ���¸�����ʷ�����Ӧ��
            xm(i,:) = x(i,:);   % ���¸�����ʷ���λ��
        end 
     end
if fym < min(fxm)
        [fym, nmax] = min(fxm);   % ����Ⱥ����ʷ�����Ӧ��
        ym = xm(nmax, :);      % ����Ⱥ����ʷ���λ��
 end
    v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, N, 1) - x);% �ٶȸ���
    % �߽��ٶȴ���
    v(v > vlimit(2)) = vlimit(2);
    v(v < vlimit(1)) = vlimit(1);
    x = x + v;% λ�ø���
    % �߽�λ�ô���
    x(x > limit(2)) = limit(2);
    x(x < limit(1)) = limit(1);
    record(generation) = fym;%���ֵ��¼
%     x0 = 0 : 0.01 : 20;
%     plot(x0, f(x0), 'b-', x, f(x), 'ro');title('״̬λ�ñ仯')
%     pause(0.1)
    generation = generation+1;
end
figure(3);plot(record);title('��������')
x0 = 0 : 0.01 : 20;
figure(4);plot(x0, f(x0), 'b-', x, f(x), 'ro');title('����״̬λ��')
disp(['���ֵ��',num2str(fym)]);
disp(['����ȡֵ��',num2str(ym)]);