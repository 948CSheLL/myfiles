%Բ������
function head=circle_dec(bwtu)
[height width]=size(bwtu);
p=zeros(100,4);%������100�������ԵĿռ䣬����λΪ�ò�����ͼ�����ҵ��ĸ���
p_num=0;%ʵ���ҵ���Բ�����Ķ���
quit_flg=0;%�ж��Ƿ��к�ѡԲ�ı�־
p_limit=15; %�ж����������ƵĽ��ޣ�С��������������һ��
real_num=0;%����ʵ�ʼ�⵽��Բ��
r_limit=300;%Բ�뾶������
real=zeros(20,3);
real_limit=20;%��ͬԲ����Ͱ뾶�����ƴ�С
head=zeros(1,3);



bwtu(1,1)=0;%��һ���������Ա������������Ч
%��ʼ������
k=1;

while k<500%ѭ������
    x1=1;
    y1=1;
    x2=1;
    y2=1;
    x3=1;
    y3=1;
    
    while(bwtu(x1,y1)==0)%���ԭͼ������ɾ�������ѭ��������,������ͼ��������������
        x1=uint16(1+rand(1)*(height-1));
        y1=uint16(1+rand(1)*(width-1));
    end
    while(bwtu(x2,y2)==0)
        x2=uint16(1+rand(1)*(height-1));
        y2=uint16(1+rand(1)*(width-1));
    end
    while(bwtu(x3,y3)==0)
        x3=uint16(1+rand(1)*(height-1));
        y3=uint16(1+rand(1)*(width-1));
    end
    point_pairs=[x1,x2,x3;y1,y2,y3];
   % plot([y1,y2,y3],[x1,x2,x3],'r-');
    point_pairs=double(point_pairs);
    p_temp=my_solve(point_pairs);
    p_temp=floor(p_temp);
    if p_temp(1)==0
        p_temp(1)=0;
    end
    if p_num==0
            p_num=p_num+1;
            p(p_num,1)=p_temp(1);
            p(p_num,2)=p_temp(2);
            p(p_num,3)=p_temp(3);
            p(p_num,4)=1;
    else
        new_flg=1;
        for i=1:real_num
               if abs(p_temp(1)-real(real_num,1))<real_limit&&abs(p_temp(2)-real(real_num,2))<real_limit&&abs(p_temp(3)-real(real_num,3))<real_limit
                   new_flg=0;
               end
        end
        if new_flg==1
            for i=1:p_num
            %������õĲ�����ԭ�еĲ����Ƚ�����
                p_temp=double(p_temp);
                if abs(p(i,1)-p_temp(1))+abs(p(i,2)-p_temp(2))+abs(p(i,3)-p_temp(3))<p_limit
                    p(i,4)=p(i,4)+1;
                    if p(i,4)>p(i,3)*2
                        quit_flg=i;
                    end
                    new_flg=0;
            
                end
            end
        end
        
        %����²�����һ��Բ
        %����������һ�����������Ч��Բ�ر�࣬���������ռ�ܴ�,������һЩ�򵥵�����
        if new_flg==1&&p_temp(3)<r_limit&&p_temp(1)>p_temp(3)&&p_temp(1)<height-p_temp(3)&&p_temp(2)>p_temp(3)&&p_temp(2)<width-p_temp(3)
         
            p_num=p_num+1;
            p(p_num,1)=p_temp(1);
            p(p_num,2)=p_temp(2);
            p(p_num,3)=p_temp(3);
            p(p_num,4)=1;
        end
    end
    %����ҵ���ѡ�㣬�����Բ���ϵı�Ե����
    %����Ǵ����Բ�������
    if quit_flg~=0
      
            head(1)=p(quit_flg,1);
            head(2)=p(quit_flg,2);
            head(3)=p(quit_flg,3);
            k=1001;
        
    else 
        k=k+1;
    end
end