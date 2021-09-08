function [alpha] = StepLength(f, grad, xk, alpha, pk, c2)
%StepLength 一维搜索步长
%   通过二次插值寻找关于alpha的一元非线性函数中满足wolfe条件和强wolfe条件的alpha值
%   输入 
%         f：Rosenbrock函数句柄（指针）
%         grad：计算梯度的函数句柄（指针）
%         xk：当前迭代中的x值
%         alpha：alpha迭代初值
%         pk：当前迭代中的pk值
%         c2：常数c2，一般最速下降法、牛顿法和拟牛顿法c2=0.9，共轭梯度法c2=0.1
%   输出 
%         alpha：步长


%前面带@的语句为构造临时函数，也叫作无名函数。比如@(alpha) f(xk+alpha*pk)，alpha为无名函数的
%的参数，这个无名函数中调用了f函数，返回值为f函数的返回值。
alpha = interpolation(f, grad, @(alpha) f(xk+alpha*pk), @(alpha) grad(xk+alpha*pk)*pk', alpha, c2, @(f,grad,alpha,c2) strong_wolfe(f,grad,xk,alpha,pk,c2));

end

%二次插值法寻找步长alpha
function [alpha] = interpolation(f, grad, f_alpha, g_alpha, alpha, c2, strong_wolfe_alpha)

iters = 100;
%l,h为搜索的范围，之后回不断缩小这个范围
l = 0.0;
h = 1.0;
for i=1:iters
    %判断当前alpha是否满足wolfe条件和强wolfe条件，满足则返回。
    if (strong_wolfe_alpha(f, grad, alpha, c2))
        return;
    end
    half = (l+h)/2;
    %二次函数拟合的解赋值给alpha
    alpha = -g_alpha(l) * h^2 / (2*(f_alpha(h)-f_alpha(l)-g_alpha(l)*h));
    %disp(alpha);
    if (alpha<l || alpha>h)
        %fprintf('alpha error alpha=%f,galpha=%f\n',alpha,g_alpha(alpha));
        %如果结果超出搜索范围，取区间中值
        alpha = half;
        %alpha = 1; % 还得改 
        %return;
    end
    %计算alpha处的导数，导数大于零取左区间，否则取右区间
    if (g_alpha(alpha) > 0)
        h = alpha;
    else
        l = alpha;
    end
end
%disp('i error');
%如果在迭代次数后没有找到满足条件的alpha，赋值为1
alpha = 1;
end

function [wolfe_bool] = wolfe(f, grad, xk, alpha, pk)

c1 = 1e-4;
wolfe_bool = f(xk+alpha*pk) <= f(xk) + c1 * alpha * (grad(xk) * pk');

end

function [str_wolfe_bool] = strong_wolfe(f, grad, xk, alpha, pk, c2)

str_wolfe_bool = wolfe(f, grad, xk, alpha, pk) && abs(grad(xk+alpha*pk) * pk') <= c2*abs(grad(xk)*pk');

end

