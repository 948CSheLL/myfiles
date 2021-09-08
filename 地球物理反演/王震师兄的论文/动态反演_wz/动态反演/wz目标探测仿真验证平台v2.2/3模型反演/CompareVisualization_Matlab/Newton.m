function [xlog, ylog, xdlog, i, fval,x] = Newton(f, grad, hessian, x0, iterations, tol)
%Newton 牛顿法
%   输入 
%         f：Rosenbrock函数句柄（指针）
%         grad：计算梯度的函数句柄（指针）
%         hessian：海森矩阵
%         x0：初值
%         iterations：最大迭代次数
%         tol：迭代结束条件，当某点梯度值小于tol时，认为找到最优值，迭代结束
%   输出 
%         xlog:迭代过程中x值的记录
%         ylog：迭代过程中y值的记录
%         xdlog：迭代过程中每次梯度值的记录
%         i：迭代次数记录

xlog = [];
ylog = [];
xdlog = [];
tol2 = ones(1,length(x0))*tol;
x = x0;
old_fval = f(x0);
old_old_fval = old_fval + norm(grad(x0)) / 2;
for i = 1:iterations
    fval = f(x);
    xlog = [xlog x'];
    ylog = [ylog f(x)];
    hess = hessian(x);
    pk =  -inv(hess)*grad(x)';
    %alpha = StepLength(f, grad, x, 1.0, pk', c2);
    [alpha, old_fval, old_old_fval] = StepLength2(f, grad, x, pk', grad(x), old_fval, old_old_fval, 1e-4, 0.1, 1e100, nan, nan, 20);
    x = x + alpha*pk';
    xdlog = [xdlog norm(x' - xlog(:,end))];
    %a = hessian(x);
    %fprintf("iter=%d, x=%f,%f, f(x)=%f, direction=%f, Hk=%f,%f\n",i, x(1), x(2), ylog(end), grad(x)*pk, a(1,1), a(2,2));
    if xdlog(end) < tol
        break;
    end
end
fprintf("iter=%d, x=%f,%f, f(x)=%f\n",i, x(1), x(2), ylog(end));
end

