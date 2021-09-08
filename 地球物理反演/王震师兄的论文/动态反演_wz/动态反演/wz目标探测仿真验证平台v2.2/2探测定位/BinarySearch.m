function [index] = BinarySearch(arr,aim)
%NUMOFOVERHALFMAX 二分查找
%   输出
%   	index,返回元素应该插入的位置
%   输入
%       arr,输入数组，应该升序排列
%       aim,待查找的数
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

