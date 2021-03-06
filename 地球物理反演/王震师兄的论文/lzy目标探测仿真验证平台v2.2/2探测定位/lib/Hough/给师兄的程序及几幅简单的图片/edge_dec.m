function dectationtu=edge_dec(yuantu2gray)

[height width]=size(yuantu2gray);
strl1=[2 -1 -1;-1 2 -1;-1 -1 2];
strl2=[-1 -1 -1;2 2 2;-1 -1 -1];
strl3=[-1 -1 2;-1 2 -1;2 -1 -1];
strl4=[-1 2 -1;-1 2 -1;-1 2 -1];
dectationtu=zeros(height,width);
dectation_tu1=imfilter(yuantu2gray,strl1);
dectation_tu2=imfilter(yuantu2gray,strl2);
dectation_tu3=imfilter(yuantu2gray,strl3);
dectation_tu4=imfilter(yuantu2gray,strl4);
bw1=im2bw(dectation_tu1,0.8);
bw2=im2bw(dectation_tu2,0.8);
bw3=im2bw(dectation_tu3,0.8);
bw4=im2bw(dectation_tu4,0.8);

for i=1:height
    for j=1:width
        if (bw1(i,j)==1)||(bw2(i,j)==1)||(bw3(i,j)==1)||(bw4(i,j)==1)
            dectationtu(i,j)=255;
        end
    end
end
