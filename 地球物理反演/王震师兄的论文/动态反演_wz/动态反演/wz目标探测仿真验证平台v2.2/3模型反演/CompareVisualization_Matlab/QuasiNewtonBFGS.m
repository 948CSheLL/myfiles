function [i, xk] = QuasiNewtonBFGS(f, grad, x0, iterations, tol)
%QuasiNewtonBFGS ��˹ţ�ٷ�
%   ���� 
%         f��Rosenbrock���������ָ�룩
%         grad�������ݶȵĺ��������ָ�룩
%         x0����ֵ
%         iterations������������
%         tol������������������ĳ���ݶ�ֵС��tolʱ����Ϊ�ҵ�����ֵ����������
%   ��� 
%         xlog:����������xֵ�ļ�¼
%         ylog������������yֵ�ļ�¼
%         xdlog������������ÿ���ݶ�ֵ�ļ�¼
%         i������������¼

% xlog = [];
% ylog = [];
% xdlog = [];
xk = x0;
c2 = 0.9;
I = eye(length(xk));
%Hk = inv(hessian(xk));
%�⺣ɭ�����ֵΪ��λ����
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

    %�����Ǽ�����һ�ε��⺣ɭ���󡣡�numerical optimization��P140,ʽ6.17
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

