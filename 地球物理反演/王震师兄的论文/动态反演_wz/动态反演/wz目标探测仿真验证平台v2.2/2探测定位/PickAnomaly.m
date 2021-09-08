function [output] = PickAnomaly(image,threshold)
%PICKANOMALY 此处显示有关此函数的摘要
%   此处显示详细说明
output=zeros(size(image));
for i=1:size(image,1)
    for j=1:size(image,2)
        if image(i,j)>threshold
            output(i,j)=1;
        end
    end
end
end

