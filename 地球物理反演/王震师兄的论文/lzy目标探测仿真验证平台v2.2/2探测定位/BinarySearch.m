function [index] = BinarySearch(arr,aim)
%NUMOFOVERHALFMAX ���ֲ���
%   ���
%   	index,����Ԫ��Ӧ�ò����λ��
%   ����
%       arr,�������飬Ӧ����������
%       aim,�����ҵ���
index=-1;
left=1;
right=length(arr);
if aim<=arr(1)
    index=0;
    return ;
end
if aim>arr(length(arr))
    index=length(arr);
    return ;
end
while left<right
    mid=floor((left+right)/2);
    if arr(mid)>aim
        right=mid;
    elseif arr(mid)==aim
        right=mid;
    elseif arr(mid)<aim
        left=mid;
        if left+1==right
            break;
        end
    end
end
index=left;
end

