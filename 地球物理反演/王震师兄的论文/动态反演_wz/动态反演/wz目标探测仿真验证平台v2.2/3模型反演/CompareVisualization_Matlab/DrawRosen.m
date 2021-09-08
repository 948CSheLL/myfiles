function DrawRosen(xlog, ylog, xdlog, n, name)
%UNTITLED5 此处显示有关此函数的摘要
%   此处显示详细说明

s = 0.02;
x1 = [-2 : s : 2+s];
x2 = [-1 : s : 3+s];
[x1, x2] = meshgrid(x1, x2);
y = 100 .* (x2 - x1.^2).^2 + (1 - x1).^2;
miny = min(y(:));
maxy = max(y(:));
C = miny + (maxy-miny).*log(1+y-miny)./log(1+maxy-miny);

figure;
surf(x1, x2, y, C, 'EdgeColor', 'none', 'LineStyle', 'none');
axis([-2, 2, -1, 3, 0, 2500]);
xlabel('x1');ylabel('x2');zlabel('y','Rotation',0);
title([name ' optimizing track 3D']);
%colormap jet;

hold on
plot3(xlog(1,:),xlog(2,:),ylog,'-ro','LineWidth',1.5,'MarkerSize',3,'MarkerFaceColor','r');
%legend(temp,{'track'},'Location','northwest');

figure;
%[~, h] = contourf(x1, x2, C, 50);
%set(h,'LineStyle','none')
%alpha(gca,0.8);
%hold on;
[~, h] = contour(x1, x2, y);
set(h,'ShowText','on','LineWidth',1.3,'LineColor','k','LevelList',[ 0.1 1 2.5 10 100 1000],'TextList',[1 10 100 1000])

hold on
plot(xlog(1,:),xlog(2,:),'-ro','LineWidth',1.5,'MarkerSize',3,'MarkerFaceColor','r');
title([name ' optimizing track in contour']);
xlabel('x1');ylabel('x2','Rotation',0);

figure;
plot(1:n, ylog,'k','LineWidth',2);
axis([-inf,inf, -inf,inf]);
title([name ' y value variations with the iterations']);
xlabel('iterations');ylabel('y','Rotation',0);

figure;
plot(1:n, xdlog,'k','LineWidth',2);
axis([-inf,inf, -inf,inf]);
title([name ' x diff value variations with the iterations']);
xlabel('iterations');ylabel('x diff');
end

