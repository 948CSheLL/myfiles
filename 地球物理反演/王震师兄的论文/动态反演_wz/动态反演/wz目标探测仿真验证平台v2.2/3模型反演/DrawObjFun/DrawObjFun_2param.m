load m_data25
load m_pk

detector = struct();
detector.I = 20;
detector.R = 0.4;
detector.F = 1000;

f1 = @(x1,x2)abs(ObjectFun(detector,[x1,x2,-3,1,1,1,1,1,1],m_pk,data1));
%f2 = @(x1,x2)abs(LinearizationSecondField(detector,[0 0 0],[x1,x2,-3,1,1,1,1,1,1]));
f2 = @(x2,x3)abs(ObjectFun(detector,[0,x2,x3,1,1,1,1,1,1],m_pk,data1));
f3 = @(x3,x4)abs(ObjectFun(detector,[0,0,x3,x4,1,1,1,1,1],m_pk,data1));
f4 = @(x4,x5)abs(ObjectFun(detector,[0,0,-3,1,1,1,1,x4,x5],m_pk,data1));


s = 0.1;
x1 = [-2 : s : 2+s];
x2 = [-2 : s : 2+s];
x3 = [-6.5 : s : -2.5+s];
x4 = [0 : s : 4+s];
x5 = [0 : s : 4+s];
y = zeros(length(x1));
k=1;
l=1;    
for i = x4
    l=1;
    for j = x5
       %temp = f2(i,j);
       %y(k,l) = temp(3);
       y(k,l) = f4(i,j);
       l=l+1;
    end
    k=k+1;
end
[x4, x5] = meshgrid(x4, x5);
figure;
surf(x4, x5, y,  'EdgeColor', 'none', 'LineStyle', 'none');
xlabel('M5');ylabel('M6');zlabel('目标函数值');