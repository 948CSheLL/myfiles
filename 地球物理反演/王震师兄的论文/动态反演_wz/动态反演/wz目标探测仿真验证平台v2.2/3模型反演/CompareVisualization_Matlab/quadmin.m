function [xmin] = quadmin(a, fa, fpa, b, fb)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

D = fa;
C = fpa;
db = b -a * 1.0;
B = (fb - D - C *db) / (db * db);
xmin = a - C / (2.0 * B);

end

