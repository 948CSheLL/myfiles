function [value,index] = PeakDetection(matrix)
%PEAKFIND �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
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

