%人头检测的新方法，用hough变换加阈值判断和边缘检测
%function linelast()
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
figure(20);
imshow(edge_tu1);
erzhitu3=imdilate(erzhitu3,strl);
figure(11);
imshow(erzhitu3);



edge_tu=edge_dec(yuantu2gray);
figure(2);
imshow(edge_tu);
edge_tu2=edge_tu;
edge_tu2(find(erzhitu3==0))=0;
figure(3);
imshow(edge_tu2);
strel=ones(3,3);
edge_tu3=imdilate(edge_tu2,strel);

circle_dec(imread('head1.jpg'));
