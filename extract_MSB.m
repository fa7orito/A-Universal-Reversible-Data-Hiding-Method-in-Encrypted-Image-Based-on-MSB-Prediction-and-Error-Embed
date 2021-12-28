function MSB_extract = extract_MSB(img_marked_encrypted)
%input: the marked & encrypted image img_marked_encrypted
%output: the extracted MSB of every pixel in img MSB_extract
[m,n] = size(img_marked_encrypted);
MSB_extract = double(img_marked_encrypted);
for i = 1:m
    for j = 1:n
        if i ~= 1 || j > 8
            MSB_extract(i,j) = floor(MSB_extract(i,j)/128);
        else
            MSB_extract(i,j) = 0;
        end
    end
end
MSB_extract = uint8(MSB_extract);
end

