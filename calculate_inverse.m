function inverse = calculate_inverse(I)
%input: the image I 
%output: the MSB inverse of I
[m,n] = size(I);
inverse = double(I);
I = double(I);
for i=1:m
    for j=1:n
        inverse(i,j) = mod(I(i,j)+128,256);
    end
end
inverse = uint8(inverse);
end

