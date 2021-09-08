% function [grad] = GetResidualGrad3(xk,f,epsilon)
% %UNTITLED 此处显示有关此函数的摘要
% %   此处显示详细说明
%     grad = [];
%     ei = zeros(length(xk),1);
%     fxk = f(xk);
%     for k = 1:length(xk)
%         ei(k) = 1.0;
%         d = epsilon * ei;
%         grad(:,k) = (f(xk+d')-fxk) / d(k);
%         ei(k) = 0.0;
%     end
% end

function [grad] = GetResidualGrad_lw(detector,xk,m_pk,bs)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    grad = zeros(3*size(m_pk,1),9);
    for k = 1:size(m_pk,1)
%         BsGrad = GetBsGrad(detector,m_pk(k,:),xk,1.5e-8,detector.oris(k,:));
        BsGrad = GetBsGrad_lw(detector,m_pk(k,:),xk,detector.oris(k,:));
%         BsGrad = GetBsGrad(detector,m_pk(k,:),xk,[0 0]);
        if bs(3*k-2)>=0
            grad(3*k-2,:) = BsGrad(:,1)';
        else
            grad(3*k-2,:) = -BsGrad(:,1)';
        end
        if bs(3*k-1)>=0
            grad(3*k-1,:) = BsGrad(:,2)';
        else
            grad(3*k-1,:) = -BsGrad(:,2)';
        end
        if bs(3*k)>=0
            grad(3*k,:) = BsGrad(:,3)';
        else
            grad(3*k,:) = -BsGrad(:,3)';
        end
    end
end


