function [Hxyz] = FirstField_wz_matrix(I,R,position,theta,phi)
%UNTITLED5 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
Pm_ = [0, 0, I*R^2];%20Ϊ����
r_ = position;
rt = RotationTensor(theta,phi,0);
% disp(rt');
r_ = rt' * r_';
r_ = r_';
r = sqrt(sum(position.^2));
Hxyz = 1/4 * ((3*(Pm_*r_')*r_)/r^5 - Pm_/r^3);
if position(3) == 0       %lw �޸� �ĳ�ע��
    Hxyz = [0 0 nan];
end
Hxyz = rt * Hxyz';
Hxyz = Hxyz';
%Hxyz = Hxyz';
end

