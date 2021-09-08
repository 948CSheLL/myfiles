function [i, x] = GradientDescent(f, grad, alpha, x0, iterations, tol)
%GradientDescent �ݶ��½���
%   ���� 
%         f��Rosenbrock���������ָ�룩
%         grad�������ݶȵĺ��������ָ�룩
%         alpha������
%         x0����ֵ
%         iterations������������
%         tol������������������ĳ���ݶ�ֵС��tolʱ����Ϊ�ҵ�����ֵ����������
%   ��� 
%         xlog:����������xֵ�ļ�¼
%         ylog������������yֵ�ļ�¼
%         xdlog������������ÿ���ݶ�ֵ�ļ�¼
%         i������������¼

%���ڼ�¼�ı���������Ϊһά����
%��ֵ��ֵ
tol2 = ones(1,length(x0))*tol;
x = x0;
%disp(x0);
%����ѭ����ѭ��iterations�Σ���;�������tol���������ѭ��
for i = 1:iterations
    %����ǰxֵ��¼��xlog��
%     fprintf("fval:");disp(fval);
    %���㷽�򣬸��ݶȷ���
    %fprintf("gard_x:");disp(grad(x));
    pk = -grad(x);
%     disp(pk);
%     disp(pk);
    %������һ�ε���xֵ��x=x+����*����
    apk = alpha * pk;
    x = x + apk;
    %fprintf("x:");disp(x);
%     if mod(i,10) == 0
%         fprintf("iter=%d, x=%f,%f, f(x)=%f\n",i, x(1), x(2), ylog(end));
%     end

    %disp(x);
    %disp(xlog(:,end)');
    %disp(xdlog(end));
    
    %�жϵ�ǰ�ݶ��Ƿ�С��tol
    %disp(sum(abs(grad(x)))/9);
    avagrad = abs(grad(x));
    %��¼�ݶ�
    if avagrad < tol2
        break;
    end
end

%������ɣ������������������xֵ������yֵ
end

