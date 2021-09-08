
import py.scipy.optimize.minimize

res = minimize(@Rosenbrock,[0 0],py.dict(pyargs('method','cg')),py.dict(pyargs('options',py.dict(pyargs('disp',true)))));


function [y] = Rosenbrock(x)
%Rosenbrock 给定包含两个元素的一位向量x，返回Rosenbrock在x点的函数值y
%   此处显示详细说明

y = 100 .* (x(2) - x(1).^2).^2 + (1 - x(1)).^2;

end



% py.abs(f(1))
% 
% function fval = f(val)
%     fval = -val;
%     disp('yes');
% end
