function [output] = PickAnomaly(image,threshold)
%PICKANOMALY �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
output=zeros(size(image));
for i=1:size(image,1)
    for j=1:size(image,2)
        if image(i,j)>threshold
            output(i,j)=1;
        end
    end
end
end

