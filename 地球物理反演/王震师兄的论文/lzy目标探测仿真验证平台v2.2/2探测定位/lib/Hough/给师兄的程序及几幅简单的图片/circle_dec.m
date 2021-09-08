%圆检测程序
function head=circle_dec(bwtu)
[height width]=size(bwtu);
p=zeros(100,4);%开辟了100个参数对的空间，第四位为该参数在图中已找到的个数
p_num=0;%实际找到的圆参数的对数
quit_flg=0;%判断是否有候选圆的标志
p_limit=15; %判断两参数相似的界限，小于则两参数归于一类
real_num=0;%计算实际检测到的圆数
r_limit=300;%圆半径的限制
real=zeros(20,3);
real_limit=20;%不同圆距离和半径的限制大小
head=zeros(1,3);



bwtu(1,1)=0;%第一个点置零以便后面的随机数有效
%初始化数据
k=1;

while k<500%循环次数
    x1=1;
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
                    if p(i,4)>p(i,3)*2
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
      
            head(1)=p(quit_flg,1);
            head(2)=p(quit_flg,2);
            head(3)=p(quit_flg,3);
            k=1001;
        
    else 
        k=k+1;
    end
end