clc;
close all;
clear;
addpath(genpath('lib'));           % add libary
addpath('../0电磁模型/matlab');     % add model libary

%   探测定位主程序
%% Configuration
    %% Model selection 
    ModelName="Sphere";     
    %% I/O
    if ModelName=="Sphere"
        IFig=1;
    elseif ModelName=="Cylinder"
        IFig=2;
    end
    v_FigPath=["image/Sphere",...                           % 1
            "image/Cylinder",...                            % 2
            "image/Fig3.MCC&LS_vs_r",...                    % 3
            "image/Fig4.MCC&LS_vs_SNR",...                  % 4
            "image/Fig5.MCC&LS_vs_K",...                    % 5
            "image/Fig6.MCC&LS_vs_PC"];                     % 6
    v_FigFormat=["%s_SNR=%ddB;",...
                   "%s_Theta=%.0f;SNR=%ddB"];

%% Data source
    %% Generate grid data by dipole model
MM_attribute=[1 pi/2 0]';   % magnetic moment(r,theta,phi) 
MM_postion=[0 0 0]';     % Position(x,y,z) of MM          
Xleft=-5;                % 
Xright=5;                % Range of X axis
Xdiff=0.1;              % Scanning interval along the X axis
Ylow=-5;                 
Yhigh=5;
Ydiff=0.1;              % Scanning interval along the Y axis
v_h=[0.5];              % Height vector of observation surface
MM=[MM_postion ...
    GetMagMom(MM_attribute(1),MM_attribute(2),MM_attribute(3))];

v_x=[Xleft:Xdiff:Xright];
v_y=[Ylow:Ydiff:Yhigh];
[m_x,m_y]=meshgrid(v_x,v_y);

DHx=zeros(size(m_x,1),size(m_x,2),length(v_h));
DHy=zeros(size(m_x,1),size(m_x,2),length(v_h));
DHz=zeros(size(m_x,1),size(m_x,2),length(v_h));
for i=1:length(v_h)
    [DHx(:,:,i),DHy(:,:,i),DHz(:,:,i)]=HFieldModel(MM,m_x,m_y,v_h(i)); % nT
end

    %% Generate grid data by EMI model
    
    % 主场参数
    I=20;       % 线圈电流
    R=0.25;     % 线圈半径/m
    f=1000;     % 信号频率
    % 目标物体(等效的偶极子)参数
    postion=[ 1 1 -1];  % 目标位置（线圈中心为坐标原点）
    MagPolar=[ 10 3 1];  % 目标三轴磁极化率,依次x,y,z
    theta=0;            % 俯仰角        
    phi=0;           % 滚转角 ps:所有角度为0时，代表三轴极化方向与线圈坐标系的x,y,z重合
    psi=0;              % 航向角（垂直放置的物体是没有的）

    % 球体目标物体参数
    u=1;                % 磁导率（默认是铜）
    sigma=5.17*10^7;    % 电导率（默认是铜）
    SphereR=0.2;        % 球体半径   
    SpherePostion=[ 1 0 -1];% 球心位置

    % 圆柱体目标物体参数
    Cu=1;                % 磁导率（默认是铜）
    Csigma=5.17*10^7;    % 电导率（默认是铜）
    CR=0.2;              % 底侧球体半径   
    CPostion=[ 1 0 -1];  % 圆柱中心位置
    p=4;                 % 长宽比

    % 观测平面参数
    h=0;                % 观测平面高度，即z坐标
     
    SphereMxyz=MomSphere(FirstField(I,R,f,SpherePostion),u,sigma,f,SphereR);
    CMxyz=MomCylinder(FirstField(I,R,f,CPostion),Cu,Csigma,f,p,theta,phi,CR);
    SpereMM=[SpherePostion(:) SphereMxyz(:)];
    CMM=[CPostion(:) CMxyz(:)];
    
    
    [SHx,SHy,SHz]=HFieldModel(SpereMM,m_x,m_y,h);
    [CHx,CHy,CHz]=HFieldModel(CMM,m_x,m_y,h);
    if ModelName=="Sphere"
            Hx=abs(SHx);
            Hy=abs(SHy);
            Hz=abs(SHz);
            postion=SpherePostion;
    elseif ModelName=="Cylinder"
            Hx=abs(CHx);
            Hy=abs(CHy);
            Hz=abs(CHz);
            postion=CPostion;
    else 
            postion=MM_postion;
    end

%     
%     
    
%% noise corrupt
SNR=200;
for i=1:length(v_h)
    nHx(:,:,i)=awgn(Hx(:,:,i),SNR,'measured');
    nHy(:,:,i)=awgn(Hy(:,:,i),SNR,'measured');
    nHz(:,:,i)=awgn(Hz(:,:,i),SNR,'measured');
end

%% original map
Ht=sqrt(Hx.^2+Hy.^2+Hz.^2);
nHt=sqrt(nHx.^2+nHy.^2+nHz.^2);
Gnoise=nHt-Ht;

%% feature map

%% Preprocess
    %% Denoising
for i=1:length(v_h)
   denHt(:,:,i)=filter2(fspecial('average',3),nHt(:,:,i));   
   denHt(:,:,i)=filter2(fspecial('gaussian'),denHt(:,:,i));                  % gaussian filter 
%     [thr,sorh,keepapp]=ddencmp('den','wv',denHt(:,:,i));    
%     denHt(:,:,i)=wdencmp('gbl',denHt(:,:,i),'sym4',2,thr,sorh,keepapp);     % denoising by wavelet
   
end
    %% Enhancement 
    %  very bad result
%     enImage=histeq(round(mapminmax(nHt(:,:,1),0,255)));
%     hist(round(mapminmax(nHt(:,:,1),0,255)));
%     figure();
%     hist(enImage);
%% Anomaly Picker (image segmentation)
  Img=mapminmax(denHt(:,:,1),0,255);      % convert to gray figure
    %% Threshold 
    Threshold=10*std(Gnoise(:));
    AnomImage=PickAnomaly(denHt(:,:,1),Threshold);
    
    %% CV-Active Contour without edge
    
    nrow=length(m_y);
    ncol=length(m_x);
    ic=nrow/2;
    jc=ncol/2;
    r=10;       %起始圆半径
    initialLSF = sdf2circle(nrow,ncol,ic,jc,r);
    u=initialLSF;
    numIter = 500;  
    timestep = 0.5;
    lambda_1=1;
    lambda_2=1;
    h = 1;
    epsilon=1;
    nu = 0.001*255*255;  % tune this parameter for different images
    EdgeCV=EVOL_CV(Img, u, nu, lambda_1, lambda_2, timestep, epsilon, numIter);
    
    %% Watershed 
    L=watershed(Img);
    rgb = label2rgb(L,'jet',[.5 .5 .5]);
    
    %% Snake model
    
    %% 1-order Edge detection 
    Imedge=edge(uint8(mapminmax(nHt(:,:,1),0,255)),1);
    
%% Location Algorithm
    %% Peak detection
    [Hmax,index]=PeakDetection(denHt(:,:,1).*AnomImage);
    PDloc=[m_x(index(1),index(2)) m_y(index(1),index(2))]
    
    %% Geometric invariance moment
    x=sum(sum(denHt(:,:,1).*m_x.*AnomImage))/sum(sum(denHt(:,:,1)));
    y=sum(sum(denHt(:,:,1).*m_y.*AnomImage))/sum(sum(denHt(:,:,1)));
    GMloc=[x y]   
    x=sum(sum(denHt(:,:,1).*m_x))/sum(sum(denHt(:,:,1)));
    y=sum(sum(denHt(:,:,1).*m_y))/sum(sum(denHt(:,:,1)));
    GMloc2=[x y]   
    
    %% Hough transform
    step_r = 1;
    step_angle = 0.1;
    minr = 5;
    maxr = 50;
    thresh = 0.8;
    BW=edge(AnomImage,1);
    [hough_space,hough_circle,para] = FindCircle(BW,step_r,step_angle,minr,maxr,thresh);
    circleParaXYR=para;
    HTloc=[Xleft+(circleParaXYR(2)-1)*Xdiff Ylow+(circleParaXYR(1)-1)*Ydiff];

%% Figure
%  surf(m_x,m_y,nHt(:,:,1));    
%  xlabel('X/m');
%  ylabel('Y/m');
%  zlabel('H/nT');
% image(v_x,v_y,mapminmax(nHt(:,:,1),0,255));
% imwrite(mapminmax(AnomImage(:,:,1),0,255),sprintf('image/test_%.0fdB.png',SNR));
%  pcolor(m_x,m_y,nHz(:,:,1));


figure('name','3-D figure of orignal data');
subplot(2,1,1);
surf(m_x,m_y,Ht(:,:,1));
title('orignal data');
subplot(2,1,2);
surf(m_x,m_y,nHt(:,:,1));
title('orignal data corrupted by noise');

figure('name','Image and Preprocess');
subplot(2,2,1);
image(v_x,v_y,uint8(mapminmax(Ht(:,:,1),0,255)));
title('orignal image of amplitude');
subplot(2,2,2);
image(v_x,v_y,uint8(mapminmax(nHt(:,:,1),0,255)));
title('Feature image corrupted by noise');
subplot(2,2,3);
image(v_x,v_y,uint8(mapminmax(denHt(:,:,1),0,255)));
title('Denoising image');
subplot(2,2,4);
image(v_x,v_y,Imedge);
title('Gradient image');
% colormap gray;

figure('name','Segmentation using threshold');
subplot(2,1,1);
image(v_x,v_y,255*AnomImage);
title('Threshold Segmentation');
subplot(2,1,2);
image(v_x,v_y,edge(255*AnomImage,1));
title('Contour');
% colormap gray;


% figure('name','Watershed transform');
% imshow(rgb,'InitialMagnification','fit');
% title('Watershed transform ');

figure('name','CV-Active Contour without edge');
image(v_x,v_y,Img);
hold on;
contour(v_x,v_y,EdgeCV,[0 0],'r');
totalIterNum=[num2str(numIter), ' iterations']; 
title(['Final contour, ',totalIterNum]);
colorbar;
xlabel("m");
ylabel("m");
figname="Contour";
 if ModelName=="Sphere"
        filename=sprintf(v_FigFormat(IFig),figname,SNR);
    elseif ModelName=="Cylinder"
       filename=sprintf(v_FigFormat(IFig),figname,theta*180/pi,SNR);
end 
print(gcf,sprintf("%s/%s",v_FigPath(IFig),filename),"-dpng","-r600");
% colormap gray;

figure('name','Location result of peak detection and Geometric invariance moment');
contourf(m_x,m_y,nHt(:,:,1),5);
colorbar;
% colormap gray;
colorbar;
text(postion(1),postion(2),'\fontsize{20}x');
text(PDloc(1),PDloc(2),'\fontsize{20}*');
text(GMloc(1),GMloc(2),'\fontsize{20}+');
title(['x:Real postion; *:PD (xe=',num2str(abs(PDloc(1)-postion(1))),'m,ye=',...
    num2str(abs(PDloc(2)-postion(2))),'m); +:GIM','(xe=',num2str(abs(GMloc(1)-postion(1))),'m,ye=',...
    num2str(abs(GMloc(2)-postion(2))),'m)']);
xlabel("m");
ylabel("m");
figname="locationResult_PD_GIM";
 if ModelName=="Sphere"
        filename=sprintf(v_FigFormat(IFig),figname,SNR);
    elseif ModelName=="Cylinder"
       filename=sprintf(v_FigFormat(IFig),figname,theta*180/pi,SNR);
end 
print(gcf,sprintf("%s/%s",v_FigPath(IFig),filename),"-dpng","-r600");

 %标出圆
figure('name','Location result of Hough transform');
image(v_x,v_y,Img);
title(['location result,*:Real postion; +:HT (xe=',num2str(abs(HTloc(1)-postion(1))),'m,ye=',...
    num2str(abs(HTloc(2)-postion(2))),'m)']);
colorbar;
xlabel("m");
ylabel("m");


% colormap gray;
    hold on;
     plot((circleParaXYR(:,2)-1)*Xdiff+Xleft, (circleParaXYR(:,1)-1)*Ydiff+Ylow, 'r+');
     hold on;
     plot((postion(1)-Xleft)/Xdiff+1,(postion(2)-Ylow)/Ydiff+1,'k*');
     hold on;
     for k = 1 : size(circleParaXYR, 1)
      t=0:0.01*pi:2*pi;
      x=cos(t).*circleParaXYR(k,3)+circleParaXYR(k,2);y=sin(t).*circleParaXYR(k,3)+circleParaXYR(k,1);
      plot((x-1)*Xdiff+Xleft,(y-1)*Ydiff+Ylow,'r-');
     end
     
     figname="locationResult_HoughTransform";
 if ModelName=="Sphere"
        filename=sprintf(v_FigFormat(IFig),figname,SNR);
    elseif ModelName=="Cylinder"
       filename=sprintf(v_FigFormat(IFig),figname,theta*180/pi,SNR);
 end 
print(gcf,sprintf("%s/%s",v_FigPath(IFig),filename),"-dpng","-r600");