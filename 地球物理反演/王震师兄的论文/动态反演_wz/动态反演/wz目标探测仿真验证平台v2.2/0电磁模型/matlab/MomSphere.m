function [mxyz,M] = MomSphere(Hp,u,e,f,R)
%球体磁矩生成
%param in: 主场场强H_prim(hx,hy,hz); 球体磁导率u; 球体电导率e; 主场电流频率f; 球体半径:R
%param out  M磁极化率张量
%电阻率取值表，和电导率是倒数的关系(Ω m)
% 1)银1.65 ×10-8
% (2)铜1.75 ×10-8->5.71*10^7
% (3)金2.40×10-8
% (4)铝2.83 ×10-8
% (5钨5.48 ×10-8
% (6)铁9.78 ×10-8->1.022*10^7
% (7)铂2.22 ×10-7
% (8)锰铜4.4 ×10-7
% (9)汞9.6 ×10-7
% (10)康铜5.0 ×10-7
% (11)镍铬合金1.0 ×10-6
% (12)铁铬铝合金1.4 ×10-6
% (13) 铝镍铁合金1.6 ×10-6
%param out  磁矩m(mx,my,mz)
A=(4*pi*(R^3))/3;
w=2*pi*f;
u0=4*pi*10^(-7);
tao=(R^2)*e*u0/u;
z1=sqrt(1j*w*tao)-2;
z2=sqrt(1j*w*tao)+1;
z=z1/z2;
A=100*A*z;         % 这里相当于主轴极化率放大了100倍，实际中这样放大后求解效果比较好，故结果要除以100
M=diag([A A A]);
mxyz(1)=A*Hp(1);
mxyz(2)=A*Hp(2);
mxyz(3)=A*Hp(3);

end
