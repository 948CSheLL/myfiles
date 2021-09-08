% function [hess] = GetObjHess(xk, f, epsilon)
% %UNTITLED 此处显示有关此函数的摘要
% %   此处显示详细说明
% 
%     hess = zeros(length(xk),length(xk));
%     ei1 = zeros(length(xk),1);
%     ei2 = zeros(length(xk),1);
%     for k1 = 1:length(xk)
%         ei1(k1) = 1.0;
%         d1 = epsilon * ei1;
%         for k2 = 1:length(xk)
%             ei2(k2) = 1.0;
%             d2 = epsilon * ei2;
%             hess(k1,k2) = (f(xk+d1'+d2')+f(xk-d1'-d2')-f(xk+d1'-d2')-f(xk-d1'+d2'))/(4*epsilon^2);
%             %hess_temp = (fprime(xk+d)-fprime(xk)) / d(k);
%             ei2(k2) = 0.0;
%         end
%         ei1(k1) = 0.0;
%     end
% end
function [hess] = GetObjHess(xk, f, epsilon)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

    hess = zeros(length(xk),length(xk));
    ei = zeros(length(xk),1);
    for k = 1:length(xk)
        ei(k) = 1.0;
        d = epsilon * ei;
        hess(k,:) = (f(xk+d')-f(xk)) / d(k);
        %hess_temp = (fprime(xk+d)-fprime(xk)) / d(k);
        ei(k) = 0.0;
    end
end


