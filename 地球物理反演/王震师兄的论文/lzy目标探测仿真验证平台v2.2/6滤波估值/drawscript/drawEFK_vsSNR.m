clc;
clear;
close all;


%% Fig.球体水平位置估计精度 vs SNR
% 数据
v_true=[  0         0   -1.0000         0         0         0    3.2959    3.2959    3.2959]; % 位置，姿态，主轴极化率
amp=sqrt(sum(v_true(4:9).^2));
SNRs=[20 25 30 35 40 45 50];
len=length(SNRs);
m_alpha=[
         0.0059    0.0044   -1.0084  -68.8303  -31.2408   13.5663    3.4021    3.3643    3.3575;...% 20
         -0.0000    0.0096   -1.0021    7.9645   82.5824   90.0000    3.3869    3.3080    3.2180;...% 25
         -0.0003    0.0020   -1.0056    4.5766  -42.2748   90.0000    3.3666    3.3553    3.4244;...% 30
         -0.0006    0.0025   -0.9999  -86.3215  -50.4171    2.0495    3.2551    3.3446    3.2993;...% 35
         0.0005    0.0007   -1.0014  -56.0060   56.9659  -64.5279    3.3231    3.3105    3.3105;...% 40
         0.0007   -0.0008   -1.0008  -81.1403   -4.3978   -4.4326    3.3177    3.3165    3.3089;...% 45
         -0.0000   -0.0006   -1.0003  -79.6329   60.0942  -17.9162    3.3027    3.3042    3.3008;...% 50
         ];
v_ehor=100*sqrt(sum((m_alpha(:,1:3)-repmat(v_true(1:3),len,1)).^2,2));
v_betax=100*abs(m_alpha(:,7)-repmat(v_true(7),len,1))./repmat(v_true(7),len,1);
v_betay=100*abs(m_alpha(:,8)-repmat(v_true(8),len,1))./repmat(v_true(8),len,1);
v_betaz=100*abs(m_alpha(:,9)-repmat(v_true(9),len,1))./repmat(v_true(9),len,1);
% 绘图
fig1=figure('name','球体位置估计精度 vs SNR');

% linestyles={'-bo','-rd','-cs','-k^','-gv','-m*'};	%marker类型
plot(SNRs,v_ehor,'-ro');
xlabel('\fontsize{12}\fontname{Times New Roman}SNR/dB');
ylabel('\fontsize{12}\fontname{宋体}位置误差/cm');
grid on;
title('球体位置误差 vs SNR');
set(gca,'FontSize',12,'FontName', '宋体'); 
set(gca,'LineWidth',1);                                 % 坐标轴框线粗细

% 绘图
fig2=figure('name','球体深度估计精度 vs SNR');

% linestyles={'-bo','-rd','-cs','-k^','-gv','-m*'};	%marker类型
plot(SNRs,v_betax,'-bo');
hold on;
% plot(SNRs,v_betay,'-rd');
% plot(SNRs,v_betaz,'-k^');
xlabel('\fontsize{12}\fontname{Times New Roman}SNR/dB');
ylabel('\fontsize{12}\fontname{宋体}主轴极化率误差/%');
grid on;
title('球体主轴极化率误差 vs SNR');
% legend('\beta','\beta_y','\beta_z');
set(gca,'FontSize',12,'FontName', '宋体'); 
set(gca,'LineWidth',1);                                 % 坐标轴框线粗细
print(fig1,'output/球体位置误差 vs SNR vs SNR',"-dpng","-r600");
print(fig2,'output/球体主轴极化率误差 vs SNR',"-dpng","-r600");