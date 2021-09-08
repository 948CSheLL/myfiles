% function [grad] = GetObjGrad3(Alpha,res)
% %UNTITLED3 此处显示有关此函数的摘要
% %   此处显示详细说明
%     if(size(Alpha,1)>1)
%         Alpha = Alpha';
%     end
%     rx = res(Alpha);
%     jx = GetResidualGrad(Alpha,res,1.5e-8);
%     grad = (jx'*rx)';
% end

function [grad,jx] = GetObjGrad3(detector,Alpha,m_pk,m_data)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
    if(size(Alpha,1)>1)
        Alpha = Alpha';
    end
%     randdata = randperm(size(m_pk,1));
%     randdata = randdata(1:80);
    [rx, bs] = GetResidualVector3(detector,Alpha,m_pk,m_data);
    jx = GetResidualGrad3(detector,Alpha,m_pk,bs);
%     f = @(x)GetResidualVector3(detector,x,m_pk,m_data);
%     jx = GetResidualGrad3(Alpha,f,1e-8);
%     [rx, bs] = GetResidualVector3_batch(detector,Alpha,m_pk,m_data,randdata);
%     jx = GetResidualGrad3_batch(detector,Alpha,m_pk,bs,randdata);
    grad = (jx'*rx)';
end


