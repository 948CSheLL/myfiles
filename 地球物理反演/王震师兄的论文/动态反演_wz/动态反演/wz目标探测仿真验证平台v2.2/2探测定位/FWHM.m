function [output] = FWHM(data,area)
%FWHM ��ά��岨��,
%   ���:
%       output,��岨���ֵ
%   ���룺
%       data,�������ݣ���ά����
%       area,��ά������ÿһ����������
noverhalfmax=numOfOverHalfMax(data(:));
output=noverhalfmax*area;

end

