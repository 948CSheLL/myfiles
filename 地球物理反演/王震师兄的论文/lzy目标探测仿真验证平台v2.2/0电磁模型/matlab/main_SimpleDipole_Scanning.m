clc;
clear;
close all;

%% 参数定义
%% 参数定义
% 主场参数
Coil=struct();
Coil.I=20;       % 线圈电流
Coil.R=0.25;     % 线圈半径/m
Coil.f=1000;     % 信号频率
Coil.Postion=[0 0 0];   %线圈位置
% 目标物体(等效的偶极子)参数
Target=struct();
x0 = 1;     y0 = 1;     z0 = -1;
Target.Postion=[1 1 -1];  % 目标位置（线圈中心为坐标原点）
Target.MagPolar=[ 10 3 1];  % 目标三轴磁极化率,依次x,y,z
Target.Theta=0;            % 俯仰角        
Target.Phi=0;              % 滚转角 ps:所有角度为0时，代表三轴极化方向与线圈坐标系的x,y,z重合
Target.Psi=0;              % 航向角（垂直放置的物体是没有的）

% 观测平面参数
Plane=struct();
Plane.h=0;                % 观测平面高度，即z坐标
Plane.Xrange=[-5 5];      % 观测平面x方向范围
Plane.Xinterval=0.1;      % x方向样点间隔
Plane.Yrange=[-5 5];      % 观测平面y方向范围
Plane.Yinterval=0.1;      % y方向样点间隔

Plane.v_x=Plane.Xrange(1):Plane.Xinterval:Plane.Xrange(2);  % x方向取点坐标
Plane.v_y=Plane.Yrange(1):Plane.Yinterval:Plane.Yrange(2);  % y方向取点坐标
[Plane.m_x,Plane.m_y]=meshgrid(Plane.v_x,Plane.v_y);        % 观测面扫描网格

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


   

%% 偶极子模型 Mx,My,Mz->Hscx,Hscy,Hscz

    Hx=zeros(size(Plane.m_x));
    Hy=zeros(size(Plane.m_x));
    Hz=zeros(size(Plane.m_x));
  
    for i=1:length(Plane.v_x)          % 对二维区域的单元格进行扫描，相对于移动线圈
        for j=1:length(Plane.v_y)
            x=Plane.v_x(i);            % 当前线圈的x坐标
            y=Plane.v_y(j);            % 当前线圈的y坐标
            Coil.Postion(1:2)=[x y ];  % 线圈位置，默认高度为0保持不变   
            [Hx(i,j),Hy(i,j),Hz(i,j)]=SecondField(Coil,Target,struct('Postion', Coil.Postion));           % 计算当前位置二次场
        end
    end


%% 绘图
Ht=sqrt(abs(Hx.^2)+abs(Hy.^2)+abs(Hz.^2));  % 计算总场大小
% SHt=sqrt(abs(SHx.^2)+abs(SHy.^2)+abs(SHz.^2));
SHt=Ht;
nHt=awgn(Ht,20,'measured');                 % 加噪声
surf(Plane.m_x,Plane.m_y,abs(Ht));                      % 原始数据
xlabel('m');
ylabel('m');
zlabel('nT');
figure();

surf(Plane.m_x,Plane.m_y,abs(nHt));                      % 带噪声数据
xlabel('m');
ylabel('m');
zlabel('nT');
figure('name','Secondary Field of Sphere')
surf(Plane.m_x,Plane.m_y,abs(SHt));                      % 带噪声数据
xlabel('m');
ylabel('m');
zlabel('nT');
figure('name','Image of SimpleDipole');
contourf(Plane.m_x,Plane.m_y,Ht,5);                     % 成图
colorbar;
xlabel('m');
ylabel('m');

figure('name','Image of Sphere');
contourf(Plane.m_x,Plane.m_y,SHt,5);                     % 成图
colorbar;
xlabel('m');
ylabel('m');
    