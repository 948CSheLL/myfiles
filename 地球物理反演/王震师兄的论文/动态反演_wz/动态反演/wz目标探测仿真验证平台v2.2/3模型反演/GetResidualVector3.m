function [v_Residual,Bs] = GetResidualVector3(detector,Alpha,m_pk,m_data)
%   �в��
%   ���: 
%       v_Residual���в�����,mx1����
%   ����: 
%       detector������������
%       Alpha��1*9����������Ϊx,y,z,M11,M22,M33,M12,M13,M23
%       m_pk,m��������λ��
%       m_data,m��۲�����
v_Residual=zeros(3*size(m_pk,1),1);      % �в�������������ͬ������������һ�¡�
Bs = zeros(3*size(m_pk,1),1);
for i=1:size(m_pk,1)
    B=LinearizationSecondField(detector,m_pk(i,:),Alpha,detector.oris(i,:));
%     B=LinearizationSecondField(detector,m_pk(i,:),Alpha,[0 0]);
%     v_Residual(i)=norm(m_data(i,1:3),2)-norm(B(1:3)',2);
%% ����z��۲�ֵ�������в��
%       v_Residual(i)=m_data(i,3)-B(3);
    Bs(3*i-2) = B(1);
    Bs(3*i-1) = B(2);
    Bs(3*i) = B(3);
%% ͬʱ��x,y,z��۲�ֵ�������в��
    v_Residual(3*i-2)=abs(B(1))-abs(m_data(i,1));
    v_Residual(3*i-1)=abs(B(2))-abs(m_data(i,2));
    v_Residual(3*i)=abs(B(3))-abs(m_data(i,3));
%     v_Residual(3*i-2)=B(1)-m_data(i,1);
%     v_Residual(3*i-1)=B(2)-m_data(i,2);
%     v_Residual(3*i)=B(3)-m_data(i,3);
end
%   fprintf('alpha = %d %d %d %d %d %d %d %d %d\n',Alpha(1),Alpha(2),Alpha(3),Alpha(4),Alpha(5),Alpha(6),Alpha(7),Alpha(8),Alpha(9));
%   disp(v_Residual(1:9));
end

