% function [grad] = GetBsGrad(detector, m_pk, xk, epsilon,detector_oris)
% %UNTITLED �˴���ʾ�йش˺�����ժҪ
% %   �˴���ʾ��ϸ˵��
%     grad = zeros(length(xk),3);
%     ei = zeros(length(xk),1);
%     for k = 1:length(xk)
%         ei(k) = 1.0;
%         d = epsilon * ei;
%         grad(k,:) = (abs(LinearizationSecondField(detector,m_pk,xk+d',detector_oris))-abs(LinearizationSecondField(detector,m_pk,xk,detector_oris)))' / d(k);
% %         a = LinearizationSecondField(detector,m_pk,xk+d');
% %         b = LinearizationSecondField(detector,m_pk,xk);
% %         grad(k,:) = (a-b)' / d(k);
%         ei(k) = 0.0;
%     end
% end

function [grad] = GetBsGrad(detector,m_pk,xk,detector_oris)

%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    %{
    Bs = 100*Gs*M*Hp
    Bs����������Ķ��γ�ǿ�ȣ�3*1������Gs��ֻ��x,y,z���������йصĺ�����3*3����M��ֻ��m11,m12.m13,m22,m23,m33���������йصĺ�����3*3����Hpֻ��x,y,z�йأ�3*1������
    Gs,M,Hp�����涼�ж���,д�ɾ�����˵���ʽ����������ӡ�
    |Bsx|       |3*(-x)*(-x)*r5-r3,     3*(-x)*(-y)*r5,    3*(-x)*(-z)*r5;  |   |m11, m12, m13;|   |20*0.16*3*x*z*r5;    |                                          
    |Bsy| = 100*|3*(-x)*(-y)*r5,        3*(-y)*(-y)*r5-r3, 3*(-y)*(-z)*r5;  | * |m12, m22, m23;| * |20*0.16*3*y*z*r5;    |                                        
    |Bsz|       |3*(-x)*(-z)*r5,        3*(-y)*(-z)*r5,    3*(-z)*(-z)*r5-r3|   |m13, m23, m33 |   |20*0.16*(3*z*z*r5-r3)|     

    ����Ҫ��Bs����������ĺ�����x,y,z,m11,m12.m13,m22,m23,m33��ƫ����
%}
    grad = zeros(length(xk),3);
    %����һ��9������x,y,z,m11,m12.m13,m22,m23,m33
    x = xk(1); y = xk(2); z = xk(3);
    m11 = xk(4); m22 = xk(5); m33 = xk(6); m12 = xk(7); m13 = xk(8); m23 = xk(9);
    %M��x,y,z�޹�
    M = [m11, m12, m13; 
         m12, m22, m23; 
         m13, m23, m33];
     
    r_dt = [x - m_pk(1); y - m_pk(2); z - m_pk(3)];
    rt = RotationTensor(detector_oris(1),detector_oris(2),0);
    r1_dt = rt' * r_dt;
    x_dt = r_dt(1); y_dt = r_dt(2); z_dt = r_dt(3);
    u_dt = r1_dt(1); v_dt = r1_dt(2); w_dt = r1_dt(3);
    x_td = m_pk(1) - x; y_td = m_pk(2) - y; z_td = m_pk(3) - z;
    %���涨��Gs���Ǻ�x,y,z�йص�
    r = sqrt(x_td^2 + y_td^2 + z_td^2);
    r5 = 1 / r^5;%disp('yes');disp(r5);disp('yes');
    r3 = 1 / r^3;
    Gs = [3*x_td*x_td*r5-r3,     3*x_td*y_td*r5,    3*x_td*z_td*r5; 
          3*x_td*y_td*r5,        3*y_td*y_td*r5-r3, 3*y_td*z_td*r5; 
          3*x_td*z_td*r5,        3*y_td*z_td*r5,    3*z_td*z_td*r5-r3]; 

    %���涨��Hp��ֻ��x,y,z�й�
    Hp = (1/4)*[detector.I*detector.R^2*3*u_dt*w_dt*r5; 
                detector.I*detector.R^2*3*v_dt*w_dt*r5; 
                detector.I*detector.R^2*(3*w_dt*w_dt*r5-r3)];
    Hp = rt * Hp;

    %�����m11,m22,m33,m12,m23,m33�󵼣���Ϊֻ��M����m11,m22,m33,m12,m23,m33,���Զ������󵼵�ʱ��Gs��Hp��������������ֱ�ӳ˾ͺ���
    M1_grad = [1 0 0; 0 0 0; 0 0 0];
    M2_grad = [0 0 0; 0 1 0; 0 0 0];
    M3_grad = [0 0 0; 0 0 0; 0 0 1];
    M4_grad = [0 1 0; 1 0 0; 0 0 0];
    M5_grad = [0 0 1; 0 0 0; 1 0 0];
    M6_grad = [0 0 0; 0 0 1; 0 1 0];
    
    %����Bs��m11,m22,m33,m12,m23,m33��ƫ��
    grad(4,:) = 100 * rt' * Gs * M1_grad * Hp;
    grad(5,:) = 100 * rt' * Gs * M2_grad * Hp;
    grad(6,:) = 100 * rt' * Gs * M3_grad * Hp;
    grad(7,:) = 100 * rt' * Gs * M4_grad * Hp;
    grad(8,:) = 100 * rt' * Gs * M5_grad * Hp;
    grad(9,:) = 100 * rt' * Gs * M6_grad * Hp;
    
    %�������ص㣬��x,y,z��ƫ��������r��x��ƫ��������r5��x��ƫ��������r3��x��ƫ��������Gs��x��ƫ��
    x_grad_r = -(x_td) * (x_td^2 + y_td^2 + z_td^2)^(-1/2); %disp(x_grad_r);
    x_grad_r5 = (-5 * r^4 * x_grad_r) / r^10;%disp(x_grad_r5);
    x_grad_r3 = (-3 * r^2 * x_grad_r) / r^6;%disp(x_grad_r3);
    x_grad_Gs = [3*(2*(-x_td)*r5+x_grad_r5*x_td^2)-x_grad_r3, 3*(y_td)*(-r5+x_grad_r5*(x_td)), 3*(z_td)*(-r5+x_grad_r5*(x_td));
                 3*(y_td)*(-r5+x_grad_r5*(x_td)),            3*y_td^2*x_grad_r5-x_grad_r3,    3*(y_td)*(z_td)*x_grad_r5;
                 3*(z_td)*(-r5+x_grad_r5*(x_td)),            3*(y_td)*(z_td)*x_grad_r5,       3*z_td^2*x_grad_r5-x_grad_r3];

    %ͬ�����Ƕ�y��
    y_grad_r = -(y_td) * (x_td^2 + y_td^2 + z_td^2)^(-1/2);
    y_grad_r5 = (-5 * r^4 * y_grad_r) / r^10;
    y_grad_r3 = (-3 * r^2 * y_grad_r) / r^6;
    y_grad_Gs = [3*x_td^2*y_grad_r5-y_grad_r3,    3*(x_td)*(-r5+y_grad_r5*(y_td)),            3*(x_td)*(z_td)*y_grad_r5;
                 3*(x_td)*(-r5+y_grad_r5*(y_td)), 3*(2*(-y_td)*r5+y_grad_r5*y_td^2)-y_grad_r3, 3*(z_td)*(-r5+y_grad_r5*(y_td));
                 3*(x_td)*(z_td)*y_grad_r5,       3*(z_td)*(-r5+y_grad_r5*(y_td)),            3*z_td^2*y_grad_r5-y_grad_r3];

    %��z��
    z_grad_r = -(z_td) * (x_td^2 + y_td^2 + z_td^2)^(-1/2);
    z_grad_r5 = (-5 * r^4 * z_grad_r) / r^10;
    z_grad_r3 = (-3 * r^2 * z_grad_r) / r^6;
    z_grad_Gs = [3*x_td^2*z_grad_r5-z_grad_r3,    3*(x_td)*(y_td)*z_grad_r5,       3*(x_td)*(-r5+z_grad_r5*(z_td));
                 3*(x_td)*(y_td)*z_grad_r5,       3*y_td^2*z_grad_r5-z_grad_r3,    3*(y_td)*(-r5+z_grad_r5*(z_td));
                 3*(x_td)*(-r5+z_grad_r5*(z_td)), 3*(y_td)*(-r5+z_grad_r5*(z_td)), 3*(2*(-z_td)*r5+z_grad_r5*z_td^2)-z_grad_r3];

    theta = detector_oris(1); phi = detector_oris(2);
    x_grad_u = cos(theta);
    x_grad_v = 0;
    x_grad_w = -sin(theta);
    x_dt_grad_r = (u_dt*x_grad_u + v_dt*x_grad_v + w_dt*x_grad_w) * (u_dt^2 + v_dt^2 + w_dt^2)^(-1/2); %disp(x_grad_r);
    x_dt_grad_r5 = (-5 * r^4 * x_dt_grad_r) / r^10;%disp(x_grad_r5);
    x_dt_grad_r3 = (-3 * r^2 * x_dt_grad_r) / r^6;%disp(x_grad_r3);
    
    y_grad_u = sin(theta)*sin(phi);
    y_grad_v = cos(phi);
    y_grad_w = cos(theta)*sin(phi);
    y_dt_grad_r = (u_dt*y_grad_u + v_dt*y_grad_v + w_dt*y_grad_w) * (u_dt^2 + v_dt^2 + w_dt^2)^(-1/2);
    y_dt_grad_r5 = (-5 * r^4 * y_dt_grad_r) / r^10;
    y_dt_grad_r3 = (-3 * r^2 * y_dt_grad_r) / r^6;
    
    z_grad_u = sin(theta)*cos(phi);
    z_grad_v = -sin(phi);
    z_grad_w = cos(theta)*cos(phi);
    z_dt_grad_r = (u_dt*z_grad_u + v_dt*z_grad_v + w_dt*z_grad_w) * (u_dt^2 + v_dt^2 + w_dt^2)^(-1/2);
    z_dt_grad_r5 = (-5 * r^4 * z_dt_grad_r) / r^10;
    z_dt_grad_r3 = (-3 * r^2 * z_dt_grad_r) / r^6;
    
    %����Hp��x,y,z��ƫ��
    x_grad_Hp = rt *(1/4)*detector.I*detector.R^2* [3*x_grad_u*w_dt*r5 + 3*u_dt*x_grad_w*r5 + 3*u_dt*w_dt*x_dt_grad_r5; 
                                                    3*x_grad_v*w_dt*r5 + 3*v_dt*x_grad_w*r5 + 3*v_dt*w_dt*x_dt_grad_r5; 
                                                    3*x_grad_w*w_dt*r5 + 3*w_dt*x_grad_w*r5 + 3*w_dt*w_dt*x_dt_grad_r5 - x_dt_grad_r3];
    y_grad_Hp = rt *(1/4)*detector.I*detector.R^2* [3*y_grad_u*w_dt*r5 + 3*u_dt*y_grad_w*r5 + 3*u_dt*w_dt*y_dt_grad_r5; 
                                                    3*y_grad_v*w_dt*r5 + 3*v_dt*y_grad_w*r5 + 3*v_dt*w_dt*y_dt_grad_r5; 
                                                    3*y_grad_w*w_dt*r5 + 3*w_dt*y_grad_w*r5 + 3*w_dt*w_dt*y_dt_grad_r5 - y_dt_grad_r3];
    z_grad_Hp = rt *(1/4)*detector.I*detector.R^2* [3*z_grad_u*w_dt*r5 + 3*u_dt*z_grad_w*r5 + 3*u_dt*w_dt*z_dt_grad_r5; 
                                                    3*z_grad_v*w_dt*r5 + 3*v_dt*z_grad_w*r5 + 3*v_dt*w_dt*z_dt_grad_r5; 
                                                    3*z_grad_w*w_dt*r5 + 3*w_dt*z_grad_w*r5 + 3*w_dt*w_dt*z_dt_grad_r5 - z_dt_grad_r3];
    
    %��ΪGs��Hp����x,y,z�йأ�����Ҫ�õ��˷��󵼷���
    grad(1,:) = 100 * rt' * (x_grad_Gs*M*Hp + Gs*M*x_grad_Hp);
    grad(2,:) = 100 * rt' * (y_grad_Gs*M*Hp + Gs*M*y_grad_Hp);
    grad(3,:) = 100 * rt' * (z_grad_Gs*M*Hp + Gs*M*z_grad_Hp);
    
end