%��ͷ�����·�������hough�任����ֵ�жϺͱ�Ե���
%function linelast()
clear;
close all;
yuantu=imread('vvvvv.jpg');



yuantu2gray=rgb2gray(yuantu);
[height width]=size(yuantu2gray);
%��ֵ�˲�
strl=ones(3,3)/9;
zhongzhi=imfilter(yuantu2gray,strl);

%��ֵ��
black=find(zhongzhi>50);%��ΰ��������ֵҲ�Ǹ�����
white=find(zhongzhi<=50);
erzhitu=zeros(size(yuantu2gray));
erzhitu(black)=0;
erzhitu(white)=255;
erzhitu=imfill(erzhitu,'holes');



%ȥ�������С��������ֵ�ݶ�600


%ȥ��С�ķ��������
strl=ones(20,20);
leijitu=imfilter(erzhitu,strl);%�������
liuxia=find(leijitu>100*255);
erzhitu2=zeros(size(erzhitu));
erzhitu2(liuxia)=255;

erzhitu3=erzhitu.*erzhitu2/255;%�󽻼�
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
