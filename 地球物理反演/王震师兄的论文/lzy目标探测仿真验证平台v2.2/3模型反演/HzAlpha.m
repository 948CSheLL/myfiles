function [Hz] = HzAlpha(Alpha,Coils)
%给定线圈参数，根据模型参数计算二次场
%   输出: 
%       Hz,依次为二次场在z轴上的分量
%   输入: 
%       Coils，线圈所存在的位置
%       Alpha，1*9向量，依次为x,y,z,θ，φ，ψ，βx,βy,βz
Hz=zeros(length(Coils),1);
for i=1:length(Coils)
    Coil=Coils(i);
    Postion=Alpha(1:3);
Mxyz=CalMoment(Alpha(7:9),FirstField(Coil.I,Coil.R,Coil.f,Postion-Coil.Postion),Alpha(4),Alpha(5),Alpha(6));

MM=[Postion(:) Mxyz(:)];   
[Hx,Hy,Hz(i)]=HFieldModel(MM,Coil.Postion(1),Coil.Postion(2),Coil.Postion(3));
end
Hz=(Hz);

end

