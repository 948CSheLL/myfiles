clc;
clear;
close all;


%% Fig.����ˮƽλ�ù��ƾ��� vs SNR
% ����
v_true=[  0         0   -1.0000         0         0         0    3.2959    3.2959    3.2959]; % λ�ã���̬�����Ἣ����
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
% ��ͼ
fig1=figure('name','����λ�ù��ƾ��� vs SNR');

% linestyles={'-bo','-rd','-cs','-k^','-gv','-m*'};	%marker����
plot(SNRs,v_ehor,'-ro');
xlabel('\fontsize{12}\fontname{Times New Roman}SNR/dB');
ylabel('\fontsize{12}\fontname{����}λ�����/cm');
grid on;
title('����λ����� vs SNR');
set(gca,'FontSize',12,'FontName', '����'); 
set(gca,'LineWidth',1);                                 % ��������ߴ�ϸ

% ��ͼ
fig2=figure('name','������ȹ��ƾ��� vs SNR');

% linestyles={'-bo','-rd','-cs','-k^','-gv','-m*'};	%marker����
plot(SNRs,v_betax,'-bo');
hold on;
% plot(SNRs,v_betay,'-rd');
% plot(SNRs,v_betaz,'-k^');
xlabel('\fontsize{12}\fontname{Times New Roman}SNR/dB');
ylabel('\fontsize{12}\fontname{����}���Ἣ�������/%');
grid on;
title('�������Ἣ������� vs SNR');
% legend('\beta','\beta_y','\beta_z');
set(gca,'FontSize',12,'FontName', '����'); 
set(gca,'LineWidth',1);                                 % ��������ߴ�ϸ
print(fig1,'output/����λ����� vs SNR vs SNR',"-dpng","-r600");
print(fig2,'output/�������Ἣ������� vs SNR',"-dpng","-r600");