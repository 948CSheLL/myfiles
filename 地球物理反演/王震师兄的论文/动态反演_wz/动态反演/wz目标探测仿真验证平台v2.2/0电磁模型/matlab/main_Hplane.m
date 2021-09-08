clc;
clear;
close all;


%% ��������
MM_attribute=[1 0 0]';   % �žص�������ϵ��ʾ
MM_postion=[0 0 0]';     % �ž�λ�ã��ѿ�������ϵ��ʾ��mΪ��λ          

Xleft=-5;
Xright=5;
Xdiff=0.25;
Ylow=-5;
Yhigh=5;
Ydiff=0.25;

v_h=[2 4 ];                    %% �۲���ĸ߶�����������ȡ��ͬ�߶ȵĹ۲��棩

%% ����ž�

MM=[MM_postion ...
    GetMagMom(MM_attribute(1),MM_attribute(2),MM_attribute(3))];
% MM=[MM_postion ...
%     [0.015;0;0]];

%% ɨ��2D����
v_x=[Xleft:Xdiff:Xright];
v_y=[Ylow:Ydiff:Yhigh];

[m_x,m_y]=meshgrid(v_x,v_y);



%% ����ƽ�泡�ֲ�
Hx=zeros(size(m_x,1),size(m_x,2),length(v_h));
Hy=zeros(size(m_x,1),size(m_x,2),length(v_h));
Hz=zeros(size(m_x,1),size(m_x,2),length(v_h));
for i=1:length(v_h)
    [Hx(:,:,i),Hy(:,:,i),Hz(:,:,i)]=HFieldModel(MM,m_x,m_y,v_h(i));
end

%% ��ͼ
% surf(m_x,m_y,Hz(:,:,1));    
Ht=sqrt(abs(Hx.^2)+abs(Hy.^2)+abs(Hz.^2));  % �����ܳ���С
% image(v_x,v_y,Ht(:,:,1));
% pcolor(m_x,m_y,Hz(:,:,1));
contourf(m_x,m_y,Ht(:,:,1),5);
% colorbar;
