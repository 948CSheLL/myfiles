clc;
clear;
close all;


%% Fig.球体水平位置估计精度 vs SNR
% 数据

SNRs=[0 5 10 15 20 25 30 35 40];
m_alpha=[
         0.0091    0.0105    0.1080    0.9122    0.9105    1.4848    0.0976    0.0621    0.0686;...% 0
         0.0073    0.0076    0.0642    0.5263    0.5299    1.0096    0.0717    0.0507    0.0490;...% 5
         0.0058    0.0058    0.0519    0.4211    0.4228    0.8471    0.0418    0.0393    0.0395;...% 10
         0.0038    0.0039    0.0456    0.3809    0.3792    0.7626    0.0252    0.0252    0.0270;...% 15
         0.0026    0.0022    0.0567    0.5027    0.5013    0.9282    0.0129    0.0167    0.0143;...% 20
         0.0017    0.0015    0.0623    0.5592    0.5589    1.0080    0.0067    0.0098    0.0090;...% 25
         0.0010    0.0009    0.0627    0.5641    0.5649    1.0136    0.0038    0.0056    0.0054;...% 30
         0.0006    0.0006    0.0627    0.5648    0.5651    1.0135    0.0025    0.0032    0.0032;...% 35
         0.0004    0.0004    0.0627    0.5657    0.5654    1.0134    0.0012    0.0021    0.0022;...% 40
         ];
v_ehor=100*sqrt(sum(m_alpha(:,1:2).^2,2));
v_edepth=100*m_alpha(:,3);
% 绘图
fig1=figure('name','球体水平位置估计精度 vs SNR');

% linestyles={'-bo','-rd','-cs','-k^','-gv','-m*'};	%marker类型
plot(SNRs,v_ehor,'-ro');
xlabel('\fontsize{12}\fontname{Times New Roman}SNR/dB');
ylabel('\fontsize{12}\fontname{宋体}水平位置估计误差/cm');
grid on;
title('水平位置估计误差 vs SNR');
set(gca,'FontSize',12,'FontName', '宋体'); 
set(gca,'LineWidth',1);                                 % 坐标轴框线粗细

% 绘图
fig2=figure('name','球体深度估计精度 vs SNR');

% linestyles={'-bo','-rd','-cs','-k^','-gv','-m*'};	%marker类型
plot(SNRs,v_edepth,'-bo');
xlabel('\fontsize{12}\fontname{Times New Roman}SNR/dB');
ylabel('\fontsize{12}\fontname{宋体}水平位置估计误差/cm');
grid on;
title('深度估计误差 vs SNR');
set(gca,'FontSize',12,'FontName', '宋体'); 
set(gca,'LineWidth',1);                                 % 坐标轴框线粗细
print(fig1,'output/球体水平位置估计精度 vs SNR',"-dpng","-r600");
print(fig2,'output/球体深度估计精度 vs SNR',"-dpng","-r600");