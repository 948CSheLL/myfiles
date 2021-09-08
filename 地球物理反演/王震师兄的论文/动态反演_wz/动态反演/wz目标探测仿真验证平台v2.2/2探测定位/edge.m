function [Imedge] = edge(Im,sober)
%GRADIENTIM Get the edge of Im 
%   Im, input image
%   Imedge, the edge of Im
%   sober, scale factor
% Sobel operator
R=size(Im,1);
C=size(Im,2);
expandIm=zeros(R+2,C+2);
Imedge=zeros(size(Im));
expandIm(2:R+1,2:C+1)=Im;
expandIm([1 R+2],2:C+1)=Im([1 R],:);
expandIm(2:R+1,[1 C+2])=Im(:,[1 C]);
expandIm(1,1)=(expandIm(1,2)+expandIm(2,1))/2;
expandIm(1,C+2)=(expandIm(1,C+1)+expandIm(2,C+2))/2;
expandIm(R+2,C+2)=(expandIm(R+1,C+2)+expandIm(R+2,C+1))/2;
expandIm(R+2,1)=(expandIm(R+2,2)+expandIm(R+1,1))/2;
Sx=[-1 0 1;-2 0 2; -1 0 1];
Sy=[ 1 2 1; 0 0 0; -1 -2 -1];
% sober=0.0005;

for i=1:R
    for j=1:C
%         Imedge(i,j)=sober*abs(sum(sum(expandIm(i:i+2,j:j+2).*Sx)))+sober*abs(sum(sum(expandIm(i:i+2,j:j+2).*Sy)));
        Imedge(i,j)=sober*sqrt(abs(sum(sum(expandIm(i:i+2,j:j+2).*Sx)))^2+abs(sum(sum(expandIm(i:i+2,j:j+2).*Sy)))^2);
    end
end

end

