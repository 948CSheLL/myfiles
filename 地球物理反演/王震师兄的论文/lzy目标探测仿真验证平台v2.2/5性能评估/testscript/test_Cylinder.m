clc;
clear;
close all;
r0=2; %% radius
h0=4; %% height自已调整高度
NN=20;
[X,Y,Z]=cylinder(r0,NN);
Z=Z-0.5;
Z=h0*Z;
XX=X(2,: );
YY=Y(2,: );
Z1=Z(1,: );
Z2=Z(2,: );

%%% in this example I draw six cylinders
N=6;  %自己修改数目
%  rotate this cylinders by Euler angles (th1,th2,th3) 自己改倾斜角
TH1 = [0,2,30,50,20,50]/180 *pi;
TH2 = [0,20,-45,65,89,100]/180 *pi;
TH3 = [0,20,-45,65,89,100]/180 *pi;

%%% centers of the cylinders，自已修改柱中心坐标
x=[0,6,3,6,2,8];
y=[0,-5,4,-10,2,-1];
z=[0,3,-5,10,-10,4];

for k=1:6
   th1=TH1(k);th2=TH2(k);th3=TH3(k); 
   R1=[cos(th1),-sin(th1),0;sin(th1),cos(th1),0;0,0,1];
   R2=[1,0,0;0,cos(th2),-sin(th2);0,sin(th2),cos(th2)];
   R3=[cos(th3),-sin(th3),0;sin(th3),cos(th3),0;0,0,1];
    A=R1*R2*R3;
    
    for i=1:NN+1
       r=[X(1,i),Y(1,i),Z(1,i)]';
       rT=A*r;
       XC(1,i)=rT(1);YC(1,i)=rT(2);ZC(1,i)=rT(3);
       r=[X(2,i),Y(2,i),Z(2,i)]';
       rT=A*r;
       XC(2,i)=rT(1);YC(2,i)=rT(2);ZC(2,i)=rT(3);
       
       r=[XX(i),YY(i),Z1(i)]';
       rT=A*r;
       XX1C(i)=rT(1);YY1C(i)=rT(2);Z1C(i)=rT(3);
       r=[XX(i),YY(i),Z2(i)]';
       rT=A*r;
       XX2C(i)=rT(1);YY2C(i)=rT(2);Z2C(i)=rT(3);
       
       
    end
    
    hold on;
copper=[231 194 97]/255;
fill3(XX1C+x(k),YY1C+y(k),Z1C+z(k),copper,'EdgeColor','none');
hold on;
fill3(XX2C+x(k),YY2C+y(k),Z2C+z(k),copper,'EdgeColor','none');

hold on;
XC=XC+x(k);YC=YC+y(k);ZC=ZC+z(k);
surf(XC,YC,ZC,'FaceColor',copper,'EdgeColor','none');
    
end



daspect([1 1 1])
% axis tight;
view(3); axis tight
camlight 
lighting gouraud
