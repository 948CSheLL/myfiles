function [Beta,Angles] = GetBetaAndAngle(v_M)
%   给定磁极化率张量元素，计算主轴磁极化率以及角度（算法参考刘知洋毕设论文2.3）
%   姿态角定义见BELL T, COLLINS L. Handheld UXO Sensor Improvements to Facilitate UXO / Clutter Discrimination Volume 1[J]. Work, 2007,  1(November).附录
%   输出: 
%       Beta，主轴磁极化率
%       Angles，角度
%   输入: 
%       v_M，M11,M22,M33,M12,M13,M23
%       
%% 根据v_M求特征值并求解主轴极化率以及姿态角
M=[v_M(1) v_M(4) v_M(5);...
   v_M(4) v_M(2) v_M(6);...
   v_M(5) v_M(6) v_M(3)];
[V,D]=eig(M);
[Beta,indices ]=sort([ D(1,1) D(2,2) D(3,3)]); % 从小到大排序，即主轴极化率从小到大，并获取在原始数组中的索引
V=real(V); % 特征向量只取实部
if V(1,indices(3))>0        % 保证俯仰角为正
    V(:,indices(3))=-V(:,indices(3));
end
if V(1,indices(1))<0        % 保证航向角为正
    V(:,indices(1))=-V(:,indices(1));
end

% 求解角度与欧拉旋转张量中对应的角度是对应的，求解思路参考刘知洋毕设论文2.3
Angles(1)=asin(-(V(1,indices(3))));                
Angles(2)=asin((V(2,indices(3)))/cos(Angles(1)));    
Angles(3)=acos((V(1,indices(1)))/cos(Angles(1)));   
Angles=Angles*180/pi;


end

