function predictor = calculate_predictor(I)
%input: the image I 
%output: the predictor of I
[m,n] = size(I);
predictor = double(I);
I = double(I);
for i=1:m
    for j=1:n
        if i==1 && j==1
            predictor(i,j) = 0;
        elseif i==1 && j~=1
            predictor(i,j) = I(i,j-1);
        elseif i~=1 && j==1
            predictor(i,j) = I(i-1,j);
        else
            predictor(i,j) = (I(i,j-1)+I(i-1,j))/2;
        end
    end
end
predictor = uint8(predictor);
end