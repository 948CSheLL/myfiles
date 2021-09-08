
load('theta=0,phi=90.mat');
res1=Scene.result.Bxyz;
load('theta=90,phi=0.mat');
res2=Scene.result.Bxyz;
dif=zeros(size(res1));
for i=1:size(res1,1)
    for j=1:size(res1,2)
        res3(i,j)=abs(res1(i,j)-res2(j,i));
    end
end

res1(21,23)
res1(23,21)
% image(mapminmax(res1,0,255));
% axis('square');

