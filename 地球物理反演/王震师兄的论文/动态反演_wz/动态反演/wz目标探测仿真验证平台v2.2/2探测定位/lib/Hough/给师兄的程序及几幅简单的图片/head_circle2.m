%��Ե���
clear;
close all;
yuantu=imread('circles__.jpg');
yuantu2gray=rgb2gray(yuantu);
bwtu=edge_dec(yuantu2gray);
figure(1);
imshow(bwtu);
%����任Բ���򵥳���
[height width]=size(bwtu);
p=zeros(100,4);%������100�������ԵĿռ䣬����λΪ�ò�����ͼ�����ҵ��ĸ���
p_num=0;%ʵ���ҵ���Բ�����Ķ���
quit_flg=0;%�ж��Ƿ��к�ѡԲ�ı�־
num_limit=30;%�����ظ����ֵĴ������ƣ�������Ϊ��ѡԲ����
p_limit=30; %�ж����������ƵĽ��ޣ�С��������������һ��
real_min=30; %��СԲ���ϱ�Ե��ĸ���
real_num=0;%����ʵ�ʼ�⵽��Բ��
r_limit=300;%Բ�뾶������
real=zeros(20,3);
real_limit=20;%��ͬԲ����Ͱ뾶�����ƴ�С




bwtu(1,1)=0;%��һ���������Ա������������Ч
%��ʼ������
k=1;
figure(3);
imshow(bwtu);
hold on;
while k<1000%ѭ������
    quit_num=0;x1=1;
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
                    if p(i,4)>p(i,3)
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
        for t=0:2*pi/500:2*pi
            x=floor(p(quit_flg,1)+p(quit_flg,3)*cos(t));
            y=floor(p(quit_flg,2)+p(quit_flg,3)*sin(t));
            if x<2
                x=2;
            end
            if x>height-1
                x=height-1;
            end
            if y<2
                y=2;
            end
            if y>width-1
                y=width-1;
            end
            %�����������ƫ����ܾ�ͳ�Ʋ���
            if bwtu(x,y)==255||bwtu(x-1,y)==255||bwtu(x+1,y)==255||bwtu(x,y-1)==255||bwtu(x,y+1)==255
                quit_num=quit_num+1;%ÿ����Ҫ��ʼ��
            end
        end
        if quit_num>200%�����Ͱ뾶���
            real_num=real_num+1;
            real(real_num,1)=p(quit_flg,1);
            real(real_num,2)=p(quit_flg,2);
            real(real_num,3)=p(quit_flg,3);
            
            
            %�Ѹ�Բ������������
            for t=0:2*pi/1000:2*pi
                x=floor(p(quit_flg,1)+p(quit_flg,3)*cos(t));
                y=floor(p(quit_flg,2)+p(quit_flg,3)*sin(t));
                 if x<2
                    x=2;
                 end
                if x>height-1
                    x=height-1;
                end
                if y<2
                    y=2;
                end
                if y>width-1
                    y=width-1;
                end
                bwtu(uint16(x)-1:uint16(x)+1,uint16(y)-1:uint16(y)+1)=0;
               
                plot(uint16(y),uint16(x),'ro');
            end
           
           %�Ƿ�Ҫ�ѱ�ǲ����ľ������㣿
            k=1;
            p_num=0;
            p=zeros(100,4);
            quit_flg=0;
        else
            k=k+1;
            p(quit_flg,4)=0;%���õ�ļ���ֵ����
           
        end
            
        
    else 
        k=k+1;
    end
end
        