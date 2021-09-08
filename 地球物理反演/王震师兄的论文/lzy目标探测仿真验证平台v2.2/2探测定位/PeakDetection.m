function [value,index] = PeakDetection(matrix)
%PEAKFIND 此处显示有关此函数的摘要
%   此处显示详细说明
value=matrix(1);
index=[1 1];
for i=1:size(matrix,1)
    for j=1:size(matrix,2)
        if matrix(i,j)>value
            value=matrix(i,j);
            index=[i,j];
        end
    end
end

end

