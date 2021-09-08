clc;
clear;
close all;


%% 参数定义
MM_attribute=[1 0 0]';   % 磁矩的球坐标系表示
MM_postion=[0 0 0]';     % 磁矩位置，笛卡尔坐标系表示，m为单位          

Xleft=-5;
Xright=5;
Xdiff=0.25;
Ylow=-5;
Yhigh=5;
Ydiff=0.25;

v_h=[2 4 ];                    %% 观测面的高度向量（可能取不同高度的观测面）

%% 计算磁矩

MM=[MM_postion ...
    GetMagMom(MM_attribute(1),MM_attribute(2),MM_attribute(3))];
% MM=[MM_postion ...
%     [0.015;0;0]];

%% 扫描2D网格
v_x=[Xleft:Xdiff:Xright];
v_y=[Ylow:Ydiff:Yhigh];

[m_x,m_y]=meshgrid(v_x,v_y);



%% 计算平面场分布
Hx=zeros(size(m_x,1),size(m_x,2),length(v_h));
Hy=zeros(size(m_x,1),size(m_x,2),length(v_h));
Hz=zeros(size(m_x,1),size(m_x,2),length(v_h));
for i=1:length(v_h)
    [Hx(:,:,i),Hy(:,:,i),Hz(:,:,i)]=HFieldModel(MM,m_x,m_y,v_h(i));
end

%% 绘图
% surf(m_x,m_y,Hz(:,:,1));    
Ht=sqrt(abs(Hx.^2)+abs(Hy.^2)+abs(Hz.^2));  % 计算总场大小
% image(v_x,v_y,Ht(:,:,1));
% pcolor(m_x,m_y,Hz(:,:,1));
contourf(m_x,m_y,Ht(:,:,1),5);
% colorbar;
