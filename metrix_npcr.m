function [result] = metrix_npcr(img1,img2)
%metrix_npcr º∆À„NPCR
[m,n] =size(img1);

img1 = double(img1);
img2 = double(img2);

sum = 0;
for i = 1:m
    for j = 1:n
        if img1(i,j) ~= img2(i,j)
            sum = sum + 1;
        end
    end
end
result = sum/m/n*100;

end

