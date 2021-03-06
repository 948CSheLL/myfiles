clc;
clear;
close all;


%% Fig.圆柱体水平位置估计精度 vs 俯仰角
% 数据
v_true=[0.0000 + 0.0000i   0.0000 + 0.0000i  -1.0000 + 0.0000i...
    1.8169 - 0.0263i   1.7315 - 0.0275i   2.9206 - 0.0111i   0.0000 + 0.0000i -0.3186 - 0.0044i   0.0000 + 0.0000i];
Phi=[ 0 45 90];
Thetas=[0 15 30 45 60 75 90];
m_alpha_0=[ 
         0.0018    0.0015    0.0632    0.1559    0.1551    0.9100    0.0095    0.0103    0.0087;...% 0
         0.0391    0.0017    0.0595    0.2149    0.1495    0.8238    0.0101    0.2928    0.0100;...% 15
         0.0713    0.0017    0.0582    0.3829    0.1521    0.7181    0.0092    0.4931    0.0090;...% 30
         0.0898    0.0017    0.0589    0.5806    0.1768    0.6206    0.0088    0.5399    0.0088;...% 45
         0.0852    0.0016    0.0141    0.2853    0.0576    0.1733    0.0105    0.3951    0.0090;...% 60
         0.0527    0.0019    0.0723    0.5997    0.2648    0.9294    0.0145    0.1535    0.0148;...% 75
         0.0018    0.0016    0.1281    1.4490    0.4192    1.7065    0.0168    0.0134    0.0155;...% 90
         ];
 m_alpha_45=[
         0.0017    0.0892    0.0584    0.1946    0.6022    0.6158    0.0084    0.0092    0.5394;...% 0
         0.0318    0.0843    0.0253    0.1137    0.3929    0.2390    0.1247    0.1809    0.4814;...% 15
         0.0574    0.0702    0.0205    0.2011    0.2794    0.1793    0.1866    0.3040    0.3717;...% 30
         0.0696    0.0492    0.0117    0.1261    0.0620    0.1933    0.1279    0.3141    0.2220;...% 45
         0.0632    0.0256    0.0504    0.2982    0.2522    0.6705    0.0312    0.2160    0.0881;...% 60
         0.0379    0.0073    0.1009    1.1141    0.4902    1.3221    0.1258    0.0811    0.0197;...% 75
         0.0018    0.0018    0.1235    1.5868    0.5661    1.6427    0.0192    0.0140    0.0163;...% 90
         ];
 m_alpha_90=[        
         0.0019    0.0017    0.1308    0.5955    1.6937    1.7662    0.0203    0.0171    0.0140;...% 0
         0.0018    0.0018    0.1301    0.6622    1.6074    1.7471    0.2688    0.0163    0.0144;...% 15
         0.0019    0.0017    0.1295    0.8646    1.4012    1.7312    0.4705    0.0174    0.0149;...% 30
         0.0017    0.0016    0.1237    1.0796    1.0804    1.6312    0.5110    0.0140    0.0144;...% 45
         0.0018    0.0021    0.1310    1.4194    0.8724    1.7570    0.4737    0.0153    0.0164;...% 60
         0.0033    0.0030    0.1212    1.2966    0.4658    1.5914    0.2451    0.0248    0.0273;...% 75
         0.0030    0.0026    0.1119    1.2586    0.3740    1.4455    0.0334    0.0205    0.0230;...% 90
         ];
v_ehor_0=100*sqrt(sum(m_alpha_0(:,1:2).^2,2));
v_edepth_0=100*m_alpha_0(:,3);
v_ehor_45=100*sqrt(sum(m_alpha_45(:,1:2).^2,2));
v_edepth_45=100*m_alpha_45(:,3);
v_ehor_90=100*sqrt(sum(m_alpha_90(:,1:2).^2,2));
v_edepth_90=100*m_alpha_90(:,3);
% 绘图
fig1=figure('name','圆柱体水平位置估计误差 vs 俯仰角');

% linestyles={'-bo','-rd','-cs','-k^','-gv','-m*'};	%marker类型
plot(Thetas,v_ehor_0,'-bo');
hold on;
plot(Thetas,v_ehor_45,'-rd');
plot(Thetas,v_ehor_90,'-gs');

xlabel('\fontsize{12}\fontname{宋体}俯仰角\theta/^0');
ylabel('\fontsize{12}\fontname{宋体}水平位置估计误差/cm');
grid on;
title('水平位置估计误差 vs 俯仰角');
legend('侧倾角\phi=0^0','侧倾角\phi=45^0','侧倾角\phi=90^0');
set(gca,'FontSize',12,'FontName', '宋体'); 
set(gca,'LineWidth',1);                                 % 坐标轴框线粗细

% 绘图
fig2=figure('name','圆柱体深度估计误差 vs 俯仰角');

% linestyles={'-bo','-rd','-cs','-k^','-gv','-m*'};	%marker类型
plot(Thetas,v_edepth_0,'-bo');
hold on;
plot(Thetas,v_edepth_45,'-rd');
plot(Thetas,v_edepth_90,'-gs');
xlabel('\fontsize{12}\fontname{宋体}俯仰角\theta/^0');
ylabel('\fontsize{12}\fontname{宋体}深度估计误差误差/cm');
grid on;
title('深度估计误差 vs 俯仰角');
legend('侧倾角\phi=0^0','侧倾角\phi=45^0','侧倾角\phi=90^0');
set(gca,'FontSize',12,'FontName', '宋体'); 
set(gca,'LineWidth',1);                                 % 坐标轴框线粗细
print(fig1,'output/球体水平位置估计精度 vs 俯仰角',"-dpng","-r600");
print(fig2,'output/球体深度估计精度 vs 俯仰角',"-dpng","-r600");