clc;
clear;
close all;

%% 参数定义
% 主场参数
I=20;       % 线圈电流
R=0.25;     % 线圈半径/m
f=1000;     % 信号频率

% 目标物体(等效的偶极子)参数
postion=[ 1 1 -1];  % 目标位置（线圈中心为坐标原点）
MagPolar=[ 10 3 1];  % 目标三轴磁极化率,依次x,y,z
theta=0;            % 俯仰角        
phi=0;              % 滚转角 ps:所有角度为0时，代表三轴极化方向与线圈坐标系的x,y,z重合
psi=0;              % 航向角（垂直放置的物体是没有的）

% 球体目标物体参数
u=1;                % 磁导率（默认是铜）
sigma=5.17*10^7;    % 电导率（默认是铜）
SphereR=0.2;        % 球体半径   
SpherePostion=[ 1 1 -1];% 球心位置

% 圆柱体目标物体参数
Cu=1;                % 磁导率（默认是铜）
Csigma=5.17*10^7;    % 电导率（默认是铜）
CR=0.2;        % 球体半径   
CPostion=[ 1 1 -1];% 球心位置

% 观测平面参数
h=0;                % 观测平面高度，即z坐标
Xrange=[-5 5];      % 观测平面x方向范围
Xinterval=0.1;      % x方向样点间隔
Yrange=[-5 5];      % 观测平面y方向范围
Yinterval=0.1;      % y方向样点间隔

%% 主场模型->主场Hx,Hy,Hz
    Hxyz=FirstField(I,R,f,postion); % 得到目标物体处的主场(频域模型)
    
%% 物体模型->磁偶极矩Mx,My,Mz
    Mxyz=CalMoment(MagPolar,Hxyz,theta,phi,psi);  
    SphereMxyz=MomSphere(Hxyz,u,sigma,f,SphereR);
    
%% 生成2D扫描网格
v_x=[Xrange(1):Xinterval:Xrange(2)];
v_y=[Yrange(1):Yinterval:Yrange(2)];
[m_x,m_y]=meshgrid(v_x,v_y);

%% 偶极子模型 Mx,My,Mz->Hscx,Hscy,Hscz
MM=[postion(:) Mxyz];
[Hx,Hy,Hz]=HFieldModel(MM,m_x,m_y,h);

SpereMM=[SpherePostion(:) SphereMxyz(:)];
[SHx,SHy,SHz]=HFieldModel(SpereMM,m_x,m_y,h);


%% 绘图
Ht=sqrt(abs(Hx.^2)+abs(Hy.^2)+abs(Hz.^2));  % 计算总场大小
SHt=sqrt(abs(SHx.^2)+abs(SHy.^2)+abs(SHz.^2));
nHt=awgn(Ht,20,'measured');                 % 加噪声
surf(m_x,m_y,abs(Ht));                      % 原始数据
xlabel('m');
ylabel('m');
zlabel('nT');
figure();

surf(m_x,m_y,abs(nHt));                      % 带噪声数据
xlabel('m');
ylabel('m');
zlabel('nT');
figure('name','Secondary Field of Sphere')
surf(m_x,m_y,abs(SHt));                      % 带噪声数据
xlabel('m');
ylabel('m');
zlabel('nT');
figure('name','Image of SimpleDipole');
contourf(m_x,m_y,Ht,5);                     % 成图
colorbar;
xlabel('m');
ylabel('m');

figure('name','Image of Sphere');
contourf(m_x,m_y,SHt,5);                     % 成图
colorbar;
xlabel('m');
ylabel('m');
    