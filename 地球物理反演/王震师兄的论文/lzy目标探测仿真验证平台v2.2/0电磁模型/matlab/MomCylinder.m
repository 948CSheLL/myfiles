function [mxyz,M] = MomCylinder(H,u,e,f,p,theta,phi,R)
%圆柱形物体磁矩生成
%   输出：  磁矩m(mx,my,mz)
%   输出：  M磁极化率张量矩阵，3x3
%   输入:  主场场强H(hx,hy,hz); 圆柱磁导率u; 圆柱电导率e; 主场电流频率f; 圆柱长宽比:p; 俯仰角:theta; 滚转角:phi; 圆柱半径:R
psi=0;
H=H(:);
A=(4*pi*(R^3))/3;
w=2*pi*f;
u0=4*pi*10^(-7);
%tao=(R^2)*e*u;
tao=(R^2)*e*u0/(u);
z1=sqrt(1j*w*tao)-2;
z2=sqrt(1j*w*tao)+1;
z0=z1/z2;
z01=sqrt(1j*w*31*tao)-2;
z02=sqrt(1j*w*31*tao)+1;
z00=z01/z02;
%z(1)=p/2*((1.35-1)+z0);
%z(2)=p/2*((1.35-1)+z0);
%z(3)=0.5*((0.3-1)+z00);

z(1)=0.5*((1.05-1)+z0);
z(2)=0.5*((1.05-1)+z0);
z(3)=p/2*((0.9-1)+z00);
beta=diag(z);

Rt=RotationTensor(theta,phi,psi);
% lie=Rt*z(:).*H;
M=100*A*Rt*beta*Rt';        % 这里相当于主轴极化率放大了100倍，实际中这样放大后求解效果比较好，故结果要除以100
lie=M*H;
% lie=Rt*(z(:).*(Rt'*H));
% lie=Rt*beta*Rt\H;
% lie=Rt*beta*H;


mxyz(1)=lie(1);
mxyz(2)=lie(2);
mxyz(3)=lie(3);

end
