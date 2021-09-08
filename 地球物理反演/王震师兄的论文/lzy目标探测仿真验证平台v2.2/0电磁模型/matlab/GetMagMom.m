function [MagMoment] = GetMagMom(Amp,theta,phi)
%MAGNETIC 根据模型计算磁矩
%  Amp,幅度
%  theta,与z轴夹角
%  phi,xoy平面投影与x轴夹角
MagMoment=zeros(3,1);       %% 磁矩在x,y,z坐标系中三个分量中的值

MagMoment(1)=Amp*sin(theta)*sin(phi);   %% x分量
MagMoment(2)=Amp*sin(theta)*cos(phi);   %% y分量
MagMoment(3)=Amp*cos(theta);            %% z分量
end

