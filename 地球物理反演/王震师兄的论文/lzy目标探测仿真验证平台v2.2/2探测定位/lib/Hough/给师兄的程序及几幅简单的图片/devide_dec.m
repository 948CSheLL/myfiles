%分块圆检测devide_dec
%边缘检测
clear;
close all;
yuantu=imread('vvvvv.jpg');



yuantu2gray=rgb2gray(yuantu);
[height width]=size(yuantu2gray);
%中值滤波
strl=ones(3,3)/9;
zhongzhi=imfilter(yuantu2gray,strl);

%二值化
black=find(zhongzhi>50);%如何把握这个阈值也是个问题
white=find(zhongzhi<=50);
erzhitu=zeros(size(yuantu2gray));
erzhitu(black)=0;
erzhitu(white)=255;
erzhitu=imfill(erzhitu,'holes');



%去除面积过小的区域，阈值暂定600


%去除小的分离的区域
strl=ones(20,20);
leijitu=imfilter(erzhitu,strl);%领域求和
liuxia=find(leijitu>100*255);
erzhitu2=zeros(size(erzhitu));
erzhitu2(liuxia)=255;

erzhitu3=erzhitu.*erzhitu2/255;%求交集
figure(1);
imshow(erzhitu3);
strl=ones(10,10);
edge_tu1=edge_dec(erzhitu3);
figure(2);
imshow(edge_tu1);
hold on;
head_size=50;
head=zeros(30,3);
k=1;
%核心部分，如何正确提取块又减少计算时间
for i=1:height-head_size
    for j=head_size/2+1:width-head_size/2
        if edge_tu1(i,j)==255
            temp_tu=imcrop(edge_tu1,[j-head_size/2,i,head_size,head_size]);
            head(k,:)=circle_dec(temp_tu);
            if head(k,3)~=0
                k=k+1; 
                plot(j,i+head_size/2,'ro');
            end
        end
    end
end
          
            