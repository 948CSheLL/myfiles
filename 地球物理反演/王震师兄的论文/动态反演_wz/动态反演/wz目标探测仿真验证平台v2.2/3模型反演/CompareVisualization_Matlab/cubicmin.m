function [xmin] = cubicmin(a, fa, fpa, b, fb, c, fc)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

C = fpa;
db = b - a;
dc = c - a;
denom = (db * dc)^2 * (db - dc);
d1 = zeros(2, 2);
d1(1, 1) = dc^2;
d1(1, 2) = -db^2;
d1(2, 1) = -dc^3;
d1(2, 2) = db^3;
temp = d1 * [(fb - fa - C * db); (fc - fa -C * dc)];
A = temp(1) / denom;
B = temp(2) / denom;
radical = B * B - 3 * A * C;
xmin = a + (-B + sqrt(radical)) / (3 * A);

end

