function [H] = HxyzAlpha(Alpha,Coils)
%给定线圈参数，根据模型参数计算二次场
%   输出: 
%       H,观测数据向量，依次为x轴向量，y轴向量，z轴向量
%   输入: 
%       Coils，线圈所存在的位置
%       Alpha，1*9向量，依次为x,y,z,θ，φ，ψ，βx,βy,βz
Hx=zeros(length(Coils),1);
Hy=zeros(length(Coils),1);
Hz=zeros(length(Coils),1);
for i=1:length(Coils)
    Coil=Coils(i);
    Postion=Alpha(1:3);
Mxyz=CalMoment(Alpha(7:9),FirstField(Coil.I,Coil.R,Coil.f,Postion-Coil.Postion),Alpha(4),Alpha(5),Alpha(6));

MM=[Postion(:) Mxyz(:)];   
[Hx(i),Hy(i),Hz(i)]=HFieldModel(MM,Coil.Postion(1),Coil.Postion(2),Coil.Postion(3));
end
H=[Hx;Hy;Hz];

end

