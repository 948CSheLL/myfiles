function [i, xk] = QuasiNewtonBFGS(f, grad, x0, iterations, tol)
%QuasiNewtonBFGS 高斯牛顿法
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
xk = x0;
c2 = 0.9;
I = eye(length(xk));
%Hk = inv(hessian(xk));
%拟海森矩阵初值为单位矩阵
Hk = I;
tol2 = ones(1,length(xk))*tol;
old_fval = f(x0);
old_old_fval = old_fval + norm(grad(x0)) / 2;
for i=1:iterations
%     xlog = [xlog xk'];
%     ylog = [ylog f(xk)];
%     fval = f(xk);
    
    old_fval_back = old_fval; %wz-19.12.16
    old_old_fval_back = old_old_fval;
    gk = grad(xk);
    pk = - Hk * gk';

    [alpha, old_fval, old_old_fval] = StepLength3(f, grad, xk, pk', gk, old_fval, old_old_fval, 1e-4, 0.9, 1e100, 1e-100, 1e-14);
    if(isnan(alpha))
        [alpha, old_fval, old_old_fval] = StepLength2(f, grad, xk, pk', grad(xk), old_fval_back, old_old_fval_back, 1e-4, 0.9, 1e100, nan, nan, 20);
    end
    if(isnan(alpha))
%         fval = nan;
        break;
    end
    xk1 = xk + alpha*pk';
    gk1 = grad(xk1);
%     xdlog = [xdlog norm(xk1' - xlog(:,end))];
%     if mod(i,10)==0
%         fprintf("iter=%d, x=%f,%f, alpha=%f, f(x)=%f\n",i, xk(1), xk(2), alpha, ylog(end));
%     end
    %fprintf("iter=%d, x=%f,%f, f(x)=%f, direction=%f, alpha=%f,
    %Hk=%f,%f\n",i, xk(1), xk(2), ylog(end), gk*pk, alpha, Hk(1,1),
    %Hk(2,2));
    if abs(grad(xk1)) < tol2
        break;
    end

    %下面是计算下一次的拟海森矩阵。《numerical optimization》P140,式6.17
    sk = xk1 - xk;
    yk = gk1 - gk;

    rho_k = 1.0 / (yk * sk');
    Hk1 = (I-rho_k*(sk'*yk)) * Hk * (I-rho_k*yk'*sk) + rho_k*(sk'*sk);
%     Hk1 = Hk + (yk'*yk)/(yk*sk') - (Hk*sk'*sk*Hk)/(sk*Hk*sk');
    
    Hk = Hk1;
    xk = xk1;
end
% fprintf("\niter=%d, x=%f,%f, f(x)=%f\n",i, xk(1), xk(2), ylog(end));
end

