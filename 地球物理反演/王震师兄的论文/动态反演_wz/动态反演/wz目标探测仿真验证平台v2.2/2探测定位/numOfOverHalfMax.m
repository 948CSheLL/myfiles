function [num] = numOfOverHalfMax(arr)
%NUMOFOVERHALFMAX ͳ��һ�������У��������ֵһ���Ԫ�صĸ���
%   ���
%   	num,������ֵ��Ԫ�ظ���
%   ����
%       arr,��������
arr=sort(arr,'ascend');

HalfMax=arr(length(arr))/2;
left=1;
right=length(arr);
while left<right
    mid=floor((left+right)/2);
    if arr(mid)>HalfMax
        right=mid;
    elseif arr(mid)==HalfMax
        right=mid;
    elseif arr(mid)<HalfMax
        left=mid;
        if left+1==right
            break;
        end
    end
end
num=length(arr)-left;
end

