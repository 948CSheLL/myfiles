function p_temp=my_solve(point_pairs)
p_temp=zeros(3,1);
x1=point_pairs(1,1);
x2=point_pairs(1,2);
x3=point_pairs(1,3);
y1=point_pairs(2,1);
y2=point_pairs(2,2);
y3=point_pairs(2,3);
k12=-(x1-x2)/(y1-y2);
d12=(y1+y2-k12*(x1+x2))/2;
k23=-(x2-x3)/(y2-y3);
d23=(y2+y3-k23*(x2+x3))/2;
p_temp(1)=-(d12-d23)/(k12-k23);
if p_temp(1)==0
    p_temp(1)=0;
end
p_temp(2)=k12*p_temp(1)+d12;
p_temp(3)=sqrt((x1-p_temp(1))^2+(y1-p_temp(2))^2);
