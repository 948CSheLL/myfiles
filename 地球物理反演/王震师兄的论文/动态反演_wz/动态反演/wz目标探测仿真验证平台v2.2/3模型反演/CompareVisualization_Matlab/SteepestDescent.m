function [i, x] = SteepestDescent(f, grad, x0, iterations, tol)
%SteepestDescent �����½���
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
tol2 = ones(1,length(x0))*tol;
x = x0;
%һά�����е�wolfe�����е�c2��һ�������½�����ţ�ٷ�����ţ�ٷ�c2=0.9�������ݶȷ�c2=0.1
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
    %����ʹ��һά����Ѱ��
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
    %��¼�ݶ�
%     xdlog = [xdlog avagrad'];
    if avagrad < tol2
%         xlog = [xlog x'];
%         ylog = [ylog f(x)];
        break;
    end
end
% fprintf("\niter=%d, x=%f,%f, f(x)=%f\n",i, x(1), x(2), ylog(end));
end

