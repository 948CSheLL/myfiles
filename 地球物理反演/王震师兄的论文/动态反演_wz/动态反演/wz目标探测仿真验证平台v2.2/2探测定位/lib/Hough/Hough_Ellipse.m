%% https://blog.csdn.net/u012507022/article/details/50979005?locationNum=5&fps=1
clc
clear all
I = imread('circle2.jpg');
[m,n,L] = size(I);       %mͼ��ĸ߶ȣ�nͼ��Ŀ�ȣ�Lͨ����
if L>1        
    I = rgb2gray(I);
end
BW1 = edge(I,'sobel');    %�Զ�ѡ����ֵ��Sobel���ӽ��б�Ե��⣨��ֵ����
 
figure(1)
subplot(121)
imshow(BW1); title('��Ե���');
se = strel('square',2);
BW=imdilate(BW1,se);%ͼ��A1���ṹԪ��B����
 
hough_circle=zeros(m,n,3);
[Limage, num] = bwlabel(BW,8);   %num ��ͨ�������
for N=1:num
    
    %[rows,cols] = find(BW);  % �ҳ���ֵͼ�е����з���Ԫ�أ�������ЩԪ�ص���������ֵ���ص�[rows,cols]  ���ҳ���Ե
      [rows,cols] = find(Limage==N);  % �ҳ���ֵͼ�е����з���Ԫ�أ�������ЩԪ�ص���������ֵ���ص�[rows,cols]  ���ҳ���Ե
      pointL=length(rows);      %����Ԫ�ظ���,��Բ���ܳ�
 
        max_distan=zeros(m,n);
        distant=zeros(1,pointL);
        for i=1:m  
            for j=1:n
                for k=1:pointL
                    distant(k)=sqrt((i-rows(k))^2+(j-cols(k))^2); %�������е� ����Բ�߽�ĵ�ľ���
                end
            max_distan(i,j)=max(distant);  %��i��j���㵽��Բ�߽��������
            end
        end
        min_distan=min(min(max_distan));   %ͼ�������еĵ㵽��Բ�߽������� ����Сֵ�������Сֵ��Ӧ������λ�� ������Բ�����ġ�
 
 
        [center_yy,center_xx] = find(min_distan==max_distan);  %��������Բ���ĵ�λ�ã�
        center_y=(min(center_yy)+max(center_yy))/2;            %���ڼ�������Բ���Ŀ�����һ�ص㣬����ѡ�����ĵ�
        center_x=(min(center_xx)+max(center_xx))/2;            %center_x��center_yΪ��Բ������
        a=min_distan;                                          %aΪ��Բ�ĳ���
    %%  �������Hough�任  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        hough_space = zeros(round(a+1),180);     %Hough�ռ�
        for k=1:pointL
            for w=1:180      %theta
                G=w*pi/180; %�Ƕ�ת��Ϊ����
                XX=((cols(k)-center_x)*cos(G)+(rows(k)-center_y)*sin(G))^2/(a^2);
                YY=(-(cols(k)-center_x)*sin(G)+(rows(k)-center_y)*cos(G))^2;
                B=round(sqrt(abs(YY/(1-XX)))+1);
                if(B>0&&B<=a)   %  ����ʱ��B��ֵ���ܴܺ���������쳣����
                     hough_space(B,w)=hough_space(B,w)+1;
                end
            end
        end
 
     %%  ����������ֵ�ľۼ���
        max_para = max(max(max(hough_space)));  % �ҳ��ۻ����ֵ
 
        [bb,ww] = find(hough_space>=max_para);  %�ҳ��ۻ����ֵ��hough_spaceλ�����꣨����ֵ����b�� theta��
        if(max_para<=pointL*0.33*0.22)     % ����ۻ����ֵ ����һ������ֵ  ���жϲ�������Բ
           disp('No ellipse'); 
           return ;
        end
        b=max(bb);                   %  bΪ��Բ�Ķ���
        W=min(ww);                          % %theta
        theta=W*pi/180;
 
 
      %% �����Բ
       
      for k=1:pointL
                XXX=((cols(k)-center_x)*cos(theta)+(rows(k)-center_y)*sin(theta))^2/(a^2);
                YYY=(-(cols(k)-center_x)*sin(theta)+(rows(k)-center_y)*cos(theta))^2/(b^2);
                if((XXX+YYY)<=1)   %ʵ����Բ
                 %if((XXX+YYY)<=1.1&&(XXX+YYY)>=0.99)  % ��Բ����
                    hough_circle(rows(k),cols(k),1) = 255;
                    
                end
      end
     
end
   subplot(122)
   imshow(hough_circle);title('�����');title('�����');
