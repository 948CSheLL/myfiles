
import py.scipy.optimize.minimize

res = minimize(@Rosenbrock,[0 0],py.dict(pyargs('method','cg')),py.dict(pyargs('options',py.dict(pyargs('disp',true)))));


function [y] = Rosenbrock(x)
%Rosenbrock ������������Ԫ�ص�һλ����x������Rosenbrock��x��ĺ���ֵy
%   �˴���ʾ��ϸ˵��

y = 100 .* (x(2) - x(1).^2).^2 + (1 - x(1)).^2;

end



% py.abs(f(1))
% 
% function fval = f(val)
%     fval = -val;
%     disp('yes');
% end
