function [Beta,Angles] = GetBetaAndAngle(v_M)
%   �����ż���������Ԫ�أ���������ż������Լ��Ƕȣ��㷨�ο���֪���������2.3��
%   ��̬�Ƕ����BELL T, COLLINS L. Handheld UXO Sensor Improvements to Facilitate UXO / Clutter Discrimination Volume 1[J]. Work, 2007,  1(November).��¼
%   ���: 
%       Beta������ż�����
%       Angles���Ƕ�
%   ����: 
%       v_M��M11,M22,M33,M12,M13,M23
%       
%% ����v_M������ֵ��������Ἣ�����Լ���̬��
M=[v_M(1) v_M(4) v_M(5);...
   v_M(4) v_M(2) v_M(6);...
   v_M(5) v_M(6) v_M(3)];
[V,D]=eig(M);
[Beta,indices ]=sort([ D(1,1) D(2,2) D(3,3)]); % ��С�������򣬼����Ἣ���ʴ�С���󣬲���ȡ��ԭʼ�����е�����
V=real(V); % ��������ֻȡʵ��
if V(1,indices(3))>0        % ��֤������Ϊ��
    V(:,indices(3))=-V(:,indices(3));
end
if V(1,indices(1))<0        % ��֤�����Ϊ��
    V(:,indices(1))=-V(:,indices(1));
end

% ���Ƕ���ŷ����ת�����ж�Ӧ�ĽǶ��Ƕ�Ӧ�ģ����˼·�ο���֪���������2.3
Angles(1)=asin(-(V(1,indices(3))));                
Angles(2)=asin((V(2,indices(3)))/cos(Angles(1)));    
Angles(3)=acos((V(1,indices(1)))/cos(Angles(1)));   
Angles=Angles*180/pi;


end

