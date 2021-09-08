function [i, x] = GradientDescent(f, grad, alpha, x0, iterations, tol)
%GradientDescent 梯度下降法
%   输入 
%         f：Rosenbrock函数句柄（指针）
%         grad：计算梯度的函数句柄（指针）
%         alpha：步长
%         x0：初值
%         iterations：最大迭代次数
%         tol：迭代结束条件，当某点梯度值小于tol时，认为找到最优值，迭代结束
%   输出 
%         xlog:迭代过程中x值的记录
%         ylog：迭代过程中y值的记录
%         xdlog：迭代过程中每次梯度值的记录
%         i：迭代次数记录

%用于记录的变量，定义为一维矩阵
%初值赋值
tol2 = ones(1,length(x0))*tol;
x = x0;
%disp(x0);
%迭代循环，循环iterations次，中途如果满足tol条件会结束循环
for i = 1:iterations
    %将当前x值记录到xlog中
%     fprintf("fval:");disp(fval);
    %计算方向，负梯度方向
    %fprintf("gard_x:");disp(grad(x));
    pk = -grad(x);
%     disp(pk);
%     disp(pk);
    %计算下一次迭的x值，x=x+步长*方向
    apk = alpha * pk;
    x = x + apk;
    %fprintf("x:");disp(x);
%     if mod(i,10) == 0
%         fprintf("iter=%d, x=%f,%f, f(x)=%f\n",i, x(1), x(2), ylog(end));
%     end

    %disp(x);
    %disp(xlog(:,end)');
    %disp(xdlog(end));
    
    %判断当前梯度是否小于tol
    %disp(sum(abs(grad(x)))/9);
    avagrad = abs(grad(x));
    %记录梯度
    if avagrad < tol2
        break;
    end
end

%迭代完成，输出迭代次数、最终x值、最终y值
end

