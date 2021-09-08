function [i, xk] = LevenbergMarquardt(f, grad, x0, iterations, tol)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

xk = x0;
lamda = 0.01;
updataJ = 1;
tol2 = ones(1,length(xk))*tol;
for i = 1:iterations
    [g,J] = grad(xk);
    if updataJ == 1 
       H = J'*J;
       if i == 1
           e = f(xk);
       end
    end
    H_lm = H + (lamda * eye(length(xk),length(xk)));
    dp = -H_lm\g';
    xk1 = xk + dp';
    e_lm = f(xk1);
    
    if e_lm < e
       lamda = lamda/10;
       xk = xk1;
       e = e_lm;
%        disp(e);
       updataJ = 1;
    else
        updataJ = 0;
        lamda = lamda * 10;
    end
    if abs(g') < tol2
        break;
    end
end
% fprintf("\niter=%d\n",i);
end

