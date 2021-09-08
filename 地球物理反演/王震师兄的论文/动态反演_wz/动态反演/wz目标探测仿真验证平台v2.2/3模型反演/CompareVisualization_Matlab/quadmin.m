function [xmin] = quadmin(a, fa, fpa, b, fb)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明

D = fa;
C = fpa;
db = b -a * 1.0;
B = (fb - D - C *db) / (db * db);
xmin = a - C / (2.0 * B);

end

