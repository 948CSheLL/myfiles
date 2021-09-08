function [Hxyz] = FirstField_wz_matrix(I,R,position,theta,phi)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明
Pm_ = [0, 0, I*R^2];%20为匝数
r_ = position;
rt = RotationTensor(theta,phi,0);
% disp(rt');
r_ = rt' * r_';
r_ = r_';
r = sqrt(sum(position.^2));
Hxyz = 1/4 * ((3*(Pm_*r_')*r_)/r^5 - Pm_/r^3);
if position(3) == 0       %lw 修改 改成注释
    Hxyz = [0 0 nan];
end
Hxyz = rt * Hxyz';
Hxyz = Hxyz';
%Hxyz = Hxyz';
end

