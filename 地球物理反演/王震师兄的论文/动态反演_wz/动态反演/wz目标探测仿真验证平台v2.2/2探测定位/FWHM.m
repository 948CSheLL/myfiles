function [output] = FWHM(data,area)
%FWHM 二维半峰波宽,
%   输出:
%       output,半峰波宽的值
%   输入：
%       data,输入数据，二维矩阵
%       area,二维矩阵中每一个网格的面积
noverhalfmax=numOfOverHalfMax(data(:));
output=noverhalfmax*area;

end

