function [gx,gy,gz] = HGradAlpha(Coil,Alpha)
%给定线圈参数，根据模型参数计算二次场在当前位置的梯度
%   输出: 
%       gx,gy,gz,1*9向量，依次为hx,hy,hz的梯度,
%   输入: 
%       Coil，线圈
%       Alpha，1*9向量，依次为x,y,z,θ，φ，ψ，βx,βy,βz
gx=zeros(size(Alpha));
gy=zeros(size(Alpha));
gz=zeros(size(Alpha));
Factor=eps^(1/3);
for i=1:length(Alpha)
    if(abs(Alpha(i))<eps)
        DifferenceInterval=Factor;
    else
        DifferenceInterval=abs(Alpha(i))*Factor;
    end
  
    Alpha(i)=Alpha(i)+DifferenceInterval;       % 第i个参数偏移DifferenceInterval
    [hx1,hy1,hz1]=HAlpha(Coil,Alpha);
    Alpha(i)=Alpha(i)-2*DifferenceInterval;     % 第i个参数偏移-DifferenceInterval
    [hx2,hy2,hz2]=HAlpha(Coil,Alpha);
    Alpha(i)=Alpha(i)+DifferenceInterval;       % 恢复第i个参数的值
    gx(i)=(abs(hx1)-abs(hx2))/(2*DifferenceInterval);
    gy(i)=(abs(hy1)-abs(hy2))/(2*DifferenceInterval);
    gz(i)=(abs(hz1)-abs(hz2))/(2*DifferenceInterval);
end
end

