clc;
clear;
close all;

%% ��������
%% ��������
% ��������
Coil=struct();
Coil.I=20;       % ��Ȧ����
Coil.R=0.25;     % ��Ȧ�뾶/m
Coil.f=1000;     % �ź�Ƶ��
Coil.Postion=[0 0 0];   %��Ȧλ��
% Ŀ������(��Ч��ż����)����
Target=struct();
x0 = 1;     y0 = 1;     z0 = -1;
Target.Postion=[1 1 -1];  % Ŀ��λ�ã���Ȧ����Ϊ����ԭ�㣩
Target.MagPolar=[ 10 3 1];  % Ŀ������ż�����,����x,y,z
Target.Theta=0;            % ������        
Target.Phi=0;              % ��ת�� ps:���нǶ�Ϊ0ʱ���������Ἣ����������Ȧ����ϵ��x,y,z�غ�
Target.Psi=0;              % ����ǣ���ֱ���õ�������û�еģ�

% �۲�ƽ�����
Plane=struct();
Plane.h=0;                % �۲�ƽ��߶ȣ���z����
Plane.Xrange=[-5 5];      % �۲�ƽ��x����Χ
Plane.Xinterval=0.1;      % x����������
Plane.Yrange=[-5 5];      % �۲�ƽ��y����Χ
Plane.Yinterval=0.1;      % y����������

Plane.v_x=Plane.Xrange(1):Plane.Xinterval:Plane.Xrange(2);  % x����ȡ������
Plane.v_y=Plane.Yrange(1):Plane.Yinterval:Plane.Yrange(2);  % y����ȡ������
[Plane.m_x,Plane.m_y]=meshgrid(Plane.v_x,Plane.v_y);        % �۲���ɨ������

% ����Ŀ���������
u=1;                % �ŵ��ʣ�Ĭ����ͭ��
sigma=5.17*10^7;    % �絼�ʣ�Ĭ����ͭ��
SphereR=0.2;        % ����뾶   
SpherePostion=[ 1 1 -1];% ����λ��

% Բ����Ŀ���������
Cu=1;                % �ŵ��ʣ�Ĭ����ͭ��
Csigma=5.17*10^7;    % �絼�ʣ�Ĭ����ͭ��
CR=0.2;        % ����뾶   
CPostion=[ 1 1 -1];% ����λ��


   

%% ż����ģ�� Mx,My,Mz->Hscx,Hscy,Hscz

    Hx=zeros(size(Plane.m_x));
    Hy=zeros(size(Plane.m_x));
    Hz=zeros(size(Plane.m_x));
  
    for i=1:length(Plane.v_x)          % �Զ�ά����ĵ�Ԫ�����ɨ�裬������ƶ���Ȧ
        for j=1:length(Plane.v_y)
            x=Plane.v_x(i);            % ��ǰ��Ȧ��x����
            y=Plane.v_y(j);            % ��ǰ��Ȧ��y����
            Coil.Postion(1:2)=[x y ];  % ��Ȧλ�ã�Ĭ�ϸ߶�Ϊ0���ֲ���   
            [Hx(i,j),Hy(i,j),Hz(i,j)]=SecondField(Coil,Target,struct('Postion', Coil.Postion));           % ���㵱ǰλ�ö��γ�
        end
    end


%% ��ͼ
Ht=sqrt(abs(Hx.^2)+abs(Hy.^2)+abs(Hz.^2));  % �����ܳ���С
% SHt=sqrt(abs(SHx.^2)+abs(SHy.^2)+abs(SHz.^2));
SHt=Ht;
nHt=awgn(Ht,20,'measured');                 % ������
surf(Plane.m_x,Plane.m_y,abs(Ht));                      % ԭʼ����
xlabel('m');
ylabel('m');
zlabel('nT');
figure();

surf(Plane.m_x,Plane.m_y,abs(nHt));                      % ����������
xlabel('m');
ylabel('m');
zlabel('nT');
figure('name','Secondary Field of Sphere')
surf(Plane.m_x,Plane.m_y,abs(SHt));                      % ����������
xlabel('m');
ylabel('m');
zlabel('nT');
figure('name','Image of SimpleDipole');
contourf(Plane.m_x,Plane.m_y,Ht,5);                     % ��ͼ
colorbar;
xlabel('m');
ylabel('m');

figure('name','Image of Sphere');
contourf(Plane.m_x,Plane.m_y,SHt,5);                     % ��ͼ
colorbar;
xlabel('m');
ylabel('m');
    