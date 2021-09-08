%边缘检测
clear;
close all;
yuantu=imread('circles__.jpg');
yuantu2gray=rgb2gray(yuantu);
bwtu=edge_dec(yuantu2gray);
figure(1);
imshow(bwtu);
%霍夫变换圆检测简单程序
[height width]=size(bwtu);
p=zeros(100,4);%开辟了100个参数对的空间，第四位为该参数在图中已找到的个数
p_num=0;%实际找到的圆参数的对数
quit_flg=0;%判断是否有候选圆的标志
num_limit=30;%参数重复出现的次数限制，大于则为候选圆参数
p_limit=30; %判断两参数相似的界限，小于则两参数归于一类
real_min=30; %最小圆周上边缘点的个数
real_num=0;%计算实际检测到的圆数
r_limit=300;%圆半径的限制
real=zeros(20,3);
real_limit=20;%不同圆距离和半径的限制大小




bwtu(1,1)=0;%第一个点置零以便后面的随机数有效
%初始化数据
k=1;
figure(3);
imshow(bwtu);
hold on;
while k<1000%循环次数
    quit_num=0;x1=1;
    y1=1;
    x2=1;
    y2=1;
    x3=1;
    y3=1;
    
    while(bwtu(x1,y1)==0)%如果原图被清除干净则陷入循环出不来,非理想图不会出现这种情况
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
            %如果所得的参数和原有的参数比较相似
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
        
        %如果新产生了一个圆
        %这样产生了一个问题就是无效的圆特别多，导致搜索空间很大,下面做一些简单的限制
        if new_flg==1&&p_temp(3)<r_limit&&p_temp(1)>p_temp(3)&&p_temp(1)<height-p_temp(3)&&p_temp(2)>p_temp(3)&&p_temp(2)<width-p_temp(3)
         
            p_num=p_num+1;
            p(p_num,1)=p_temp(1);
            p(p_num,2)=p_temp(2);
            p(p_num,3)=p_temp(3);
            p(p_num,4)=1;
        end
    end
    %如果找到候选点，计算该圆周上的边缘点数
    %如果是错误的圆可能溢出
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
            %如果数据稍有偏差，可能就统计不到
            if bwtu(x,y)==255||bwtu(x-1,y)==255||bwtu(x+1,y)==255||bwtu(x,y-1)==255||bwtu(x,y+1)==255
                quit_num=quit_num+1;%每次需要初始化
            end
        end
        if quit_num>200%点数和半径相比
            real_num=real_num+1;
            real(real_num,1)=p(quit_flg,1);
            real(real_num,2)=p(quit_flg,2);
            real(real_num,3)=p(quit_flg,3);
            
            
            %把该圆所在区域置零
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
           
           %是否要把标记参数的矩阵置零？
            k=1;
            p_num=0;
            p=zeros(100,4);
            quit_flg=0;
        else
            k=k+1;
            p(quit_flg,4)=0;%将该点的计数值置零
           
        end
            
        
    else 
        k=k+1;
    end
end
        