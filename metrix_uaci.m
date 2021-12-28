function [result] = metrix_uaci(img1,img2)
%metrix_uaci º∆À„uaci
[m,n] =size(img1);


result = sum(sum(abs(double(img1)-double(img2))))/255/m/n*100 ;

end

