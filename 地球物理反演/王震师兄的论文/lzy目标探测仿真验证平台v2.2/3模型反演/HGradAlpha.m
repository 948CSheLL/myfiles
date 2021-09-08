function [gx,gy,gz] = HGradAlpha(Coil,Alpha)
%������Ȧ����������ģ�Ͳ���������γ��ڵ�ǰλ�õ��ݶ�
%   ���: 
%       gx,gy,gz,1*9����������Ϊhx,hy,hz���ݶ�,
%   ����: 
%       Coil����Ȧ
%       Alpha��1*9����������Ϊx,y,z,�ȣ��գ��ף���x,��y,��z
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
  
    Alpha(i)=Alpha(i)+DifferenceInterval;       % ��i������ƫ��DifferenceInterval
    [hx1,hy1,hz1]=HAlpha(Coil,Alpha);
    Alpha(i)=Alpha(i)-2*DifferenceInterval;     % ��i������ƫ��-DifferenceInterval
    [hx2,hy2,hz2]=HAlpha(Coil,Alpha);
    Alpha(i)=Alpha(i)+DifferenceInterval;       % �ָ���i��������ֵ
    gx(i)=(abs(hx1)-abs(hx2))/(2*DifferenceInterval);
    gy(i)=(abs(hy1)-abs(hy2))/(2*DifferenceInterval);
    gz(i)=(abs(hz1)-abs(hz2))/(2*DifferenceInterval);
end
end

