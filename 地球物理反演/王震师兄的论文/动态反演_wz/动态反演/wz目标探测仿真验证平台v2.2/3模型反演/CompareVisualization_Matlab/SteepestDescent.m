function [i, x] = SteepestDescent(f, grad, x0, iterations, tol)
%SteepestDescent 最速下降法
%   输入 
%         f：Rosenbrock函数句柄（指针）
%         grad：计算梯度的函数句柄（指针）
%         x0：初值
%         iterations：最大迭代次数
%         tol：迭代结束条件，当某点梯度值小于tol时，认为找到最优值，迭代结束
%   输出 
%         xlog:迭代过程中x值的记录
%         ylog：迭代过程中y值的记录
%         xdlog：迭代过程中每次梯度值的记录
%         i：迭代次数记录

% xlog = [];
% ylog = [];
% xdlog = [];
tol2 = ones(1,length(x0))*tol;
x = x0;
%一维搜索中的wolfe条件中的c2，一般最速下降法、牛顿法和拟牛顿法c2=0.9，共轭梯度法c2=0.1
c2 = 0.9;
old_fval = f(x0);
old_old_fval = old_fval + norm(grad(x0)) / 2;
for i = 1:iterations
%     xlog = [xlog x'];
%     ylog = [ylog f(x)];
%     f_val = f(x);
%     disp(f_val);
    pk = -grad(x);
%     disp(pk);
    %步长使用一维搜索寻找
    %alpha = StepLength(f, grad, x, 1.0, pk, c2);
    %[alpha, old_fval, old_old_fval] = StepLength2(f, grad, x, pk, grad(x), old_fval, old_old_fval, 1e-4, 0.1, 1e100, nan, nan, 20);
    [alpha, old_fval, old_old_fval] = StepLength3(f, grad, x, pk, grad(x), old_fval, old_old_fval, 1e-4, 0.9, 1e100, 1e-100, 1e-14);
%     disp(alpha);
    x = x + alpha * pk;
%     if mod(i,10) == 0
%         fprintf("iter=%d, x=%f,%f, f(x)=%f\n",i, x(1), x(2), ylog(end));
%     end
    %disp(x);
    %disp(xlog(:,end)');
    %disp(xdlog(end));
    avagrad = abs(grad(x));
    %记录梯度
%     xdlog = [xdlog avagrad'];
    if avagrad < tol2
%         xlog = [xlog x'];
%         ylog = [ylog f(x)];
        break;
    end
end
% fprintf("\niter=%d, x=%f,%f, f(x)=%f\n",i, x(1), x(2), ylog(end));
end

