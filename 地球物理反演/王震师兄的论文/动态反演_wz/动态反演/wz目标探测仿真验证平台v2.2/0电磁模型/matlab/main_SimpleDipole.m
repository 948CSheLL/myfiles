clc;
clear;
close all;

%% ��������
% ��������
I=20;       % ��Ȧ����
R=0.25;     % ��Ȧ�뾶/m
f=1000;     % �ź�Ƶ��

% Ŀ������(��Ч��ż����)����
postion=[ 1 1 -1];  % Ŀ��λ�ã���Ȧ����Ϊ����ԭ�㣩
MagPolar=[ 10 3 1];  % Ŀ������ż�����,����x,y,z
theta=0;            % ������        
phi=0;              % ��ת�� ps:���нǶ�Ϊ0ʱ���������Ἣ����������Ȧ����ϵ��x,y,z�غ�
psi=0;              % ����ǣ���ֱ���õ�������û�еģ�

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

% �۲�ƽ�����
h=0;                % �۲�ƽ��߶ȣ���z����
Xrange=[-5 5];      % �۲�ƽ��x����Χ
Xinterval=0.1;      % x����������
Yrange=[-5 5];      % �۲�ƽ��y����Χ
Yinterval=0.1;      % y����������

%% ����ģ��->����Hx,Hy,Hz
    Hxyz=FirstField(I,R,f,postion); % �õ�Ŀ�����崦������(Ƶ��ģ��)
    
%% ����ģ��->��ż����Mx,My,Mz
    Mxyz=CalMoment(MagPolar,Hxyz,theta,phi,psi);  
    SphereMxyz=MomSphere(Hxyz,u,sigma,f,SphereR);
    
%% ����2Dɨ������
v_x=[Xrange(1):Xinterval:Xrange(2)];
v_y=[Yrange(1):Yinterval:Yrange(2)];
[m_x,m_y]=meshgrid(v_x,v_y);

%% ż����ģ�� Mx,My,Mz->Hscx,Hscy,Hscz
MM=[postion(:) Mxyz];
[Hx,Hy,Hz]=HFieldModel(MM,m_x,m_y,h);

SpereMM=[SpherePostion(:) SphereMxyz(:)];
[SHx,SHy,SHz]=HFieldModel(SpereMM,m_x,m_y,h);


%% ��ͼ
Ht=sqrt(abs(Hx.^2)+abs(Hy.^2)+abs(Hz.^2));  % �����ܳ���С
SHt=sqrt(abs(SHx.^2)+abs(SHy.^2)+abs(SHz.^2));
nHt=awgn(Ht,20,'measured');                 % ������
surf(m_x,m_y,abs(Ht));                      % ԭʼ����
xlabel('m');
ylabel('m');
zlabel('nT');
figure();

surf(m_x,m_y,abs(nHt));                      % ����������
xlabel('m');
ylabel('m');
zlabel('nT');
figure('name','Secondary Field of Sphere')
surf(m_x,m_y,abs(SHt));                      % ����������
xlabel('m');
ylabel('m');
zlabel('nT');
figure('name','Image of SimpleDipole');
contourf(m_x,m_y,Ht,5);                     % ��ͼ
colorbar;
xlabel('m');
ylabel('m');

figure('name','Image of Sphere');
contourf(m_x,m_y,SHt,5);                     % ��ͼ
colorbar;
xlabel('m');
ylabel('m');
    