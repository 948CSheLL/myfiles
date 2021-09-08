function [grad] = JacobianRosen(x)
%JacobianRosen ������������Ԫ�ص�һλ����x������Rosenbrock��x����ݶ�grad
%   �˴���ʾ��ϸ˵��

grad = [200*(x(2)-x(1).^2)*(-2*x(1)) + 2*(x(1)-1), 200*(x(2)-x(1).^2)];

end

