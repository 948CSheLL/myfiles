function [alpha] = StepLength(f, grad, xk, alpha, pk, c2)
%StepLength һά��������
%   ͨ�����β�ֵѰ�ҹ���alpha��һԪ�����Ժ���������wolfe������ǿwolfe������alphaֵ
%   ���� 
%         f��Rosenbrock���������ָ�룩
%         grad�������ݶȵĺ��������ָ�룩
%         xk����ǰ�����е�xֵ
%         alpha��alpha������ֵ
%         pk����ǰ�����е�pkֵ
%         c2������c2��һ�������½�����ţ�ٷ�����ţ�ٷ�c2=0.9�������ݶȷ�c2=0.1
%   ��� 
%         alpha������


%ǰ���@�����Ϊ������ʱ������Ҳ������������������@(alpha) f(xk+alpha*pk)��alphaΪ����������
%�Ĳ�����������������е�����f����������ֵΪf�����ķ���ֵ��
alpha = interpolation(f, grad, @(alpha) f(xk+alpha*pk), @(alpha) grad(xk+alpha*pk)*pk', alpha, c2, @(f,grad,alpha,c2) strong_wolfe(f,grad,xk,alpha,pk,c2));

end

%���β�ֵ��Ѱ�Ҳ���alpha
function [alpha] = interpolation(f, grad, f_alpha, g_alpha, alpha, c2, strong_wolfe_alpha)

iters = 100;
%l,hΪ�����ķ�Χ��֮��ز�����С�����Χ
l = 0.0;
h = 1.0;
for i=1:iters
    %�жϵ�ǰalpha�Ƿ�����wolfe������ǿwolfe�����������򷵻ء�
    if (strong_wolfe_alpha(f, grad, alpha, c2))
        return;
    end
    half = (l+h)/2;
    %���κ�����ϵĽ⸳ֵ��alpha
    alpha = -g_alpha(l) * h^2 / (2*(f_alpha(h)-f_alpha(l)-g_alpha(l)*h));
    %disp(alpha);
    if (alpha<l || alpha>h)
        %fprintf('alpha error alpha=%f,galpha=%f\n',alpha,g_alpha(alpha));
        %����������������Χ��ȡ������ֵ
        alpha = half;
        %alpha = 1; % ���ø� 
        %return;
    end
    %����alpha���ĵ���������������ȡ�����䣬����ȡ������
    if (g_alpha(alpha) > 0)
        h = alpha;
    else
        l = alpha;
    end
end
%disp('i error');
%����ڵ���������û���ҵ�����������alpha����ֵΪ1
alpha = 1;
end

function [wolfe_bool] = wolfe(f, grad, xk, alpha, pk)

c1 = 1e-4;
wolfe_bool = f(xk+alpha*pk) <= f(xk) + c1 * alpha * (grad(xk) * pk');

end

function [str_wolfe_bool] = strong_wolfe(f, grad, xk, alpha, pk, c2)

str_wolfe_bool = wolfe(f, grad, xk, alpha, pk) && abs(grad(xk+alpha*pk) * pk') <= c2*abs(grad(xk)*pk');

end

