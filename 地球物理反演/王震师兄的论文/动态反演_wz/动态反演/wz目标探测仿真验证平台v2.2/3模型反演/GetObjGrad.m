% function [grad] = GetObjGrad(detector,Alpha,m_pk,m_data)
% %GETOBJGRAD 此处显示有关此函数的摘要
% %   此处显示详细说明
% 
% grad = zeros(length(Alpha),1);
% B=zeros(size(m_pk,1),3);
% for i=1:size(m_pk,1)
% 	B(i,:)=LinearizationSecondField(detector,m_pk(i,:),Alpha);
%     grad_temp = ModelGrad(detector,m_pk(i,:),Alpha);
%     %disp(grad_temp);
%     grad = grad+((B(i,:)-m_data(i,:))*grad_temp')';
% end
% 
% grad = grad/size(m_pk,1);
% grad = grad';
% end

% function [grad] = approx_fprime(xk,detector,m_pk,epsilon)
%     
%     grad = zeros(length(xk),3);
%     ei = zeros(length(xk),1);
%     for k = 1:length(xk)
%         ei(k) = 1.0;
%         d = epsilon * ei;
%         grad(k,:) = (LinearizationSecondField(detector,m_pk,xk+d')-LinearizationSecondField(detector,m_pk,xk)) / d(k);
%         ei(k) = 0.0;
%     end
% end

function [grad] = GetObjGrad(xk,f,epsilon)

    grad = zeros(length(xk),1);
    ei = zeros(length(xk),1);
    for k = 1:length(xk)
        ei(k) = 1.0;
        d = epsilon * ei;
        grad(k,:) = (f(xk+d')-f(xk)) / d(k);
        ei(k) = 0.0;
    end
    grad = grad';
end