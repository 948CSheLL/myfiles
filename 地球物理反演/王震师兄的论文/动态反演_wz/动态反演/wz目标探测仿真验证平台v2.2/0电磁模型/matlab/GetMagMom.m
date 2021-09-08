function [MagMoment] = GetMagMom(Amp,theta,phi)
%MAGNETIC ����ģ�ͼ���ž�
%  Amp,����
%  theta,��z��н�
%  phi,xoyƽ��ͶӰ��x��н�
MagMoment=zeros(3,1);       %% �ž���x,y,z����ϵ�����������е�ֵ

MagMoment(1)=Amp*sin(theta)*sin(phi);   %% x����
MagMoment(2)=Amp*sin(theta)*cos(phi);   %% y����
MagMoment(3)=Amp*cos(theta);            %% z����
end

