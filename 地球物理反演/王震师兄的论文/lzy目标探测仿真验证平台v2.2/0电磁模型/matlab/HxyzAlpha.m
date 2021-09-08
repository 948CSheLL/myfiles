function [H] = HxyzAlpha(Alpha,Coils)
%������Ȧ����������ģ�Ͳ���������γ�
%   ���: 
%       H,�۲���������������Ϊx��������y��������z������
%   ����: 
%       Coils����Ȧ�����ڵ�λ��
%       Alpha��1*9����������Ϊx,y,z,�ȣ��գ��ף���x,��y,��z
Hx=zeros(length(Coils),1);
Hy=zeros(length(Coils),1);
Hz=zeros(length(Coils),1);
for i=1:length(Coils)
    Coil=Coils(i);
    Postion=Alpha(1:3);
Mxyz=CalMoment(Alpha(7:9),FirstField(Coil.I,Coil.R,Coil.f,Postion-Coil.Postion),Alpha(4),Alpha(5),Alpha(6));

MM=[Postion(:) Mxyz(:)];   
[Hx(i),Hy(i),Hz(i)]=HFieldModel(MM,Coil.Postion(1),Coil.Postion(2),Coil.Postion(3));
end
H=[Hx;Hy;Hz];

end

