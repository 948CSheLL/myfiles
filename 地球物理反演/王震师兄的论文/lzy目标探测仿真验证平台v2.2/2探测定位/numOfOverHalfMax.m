function [num] = numOfOverHalfMax(arr)
%NUMOFOVERHALFMAX 统计一个向量中，超过最大值一半的元素的个数
%   输出
%   	num,超过半值的元素个数
%   输入
%       arr,输入向量
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

