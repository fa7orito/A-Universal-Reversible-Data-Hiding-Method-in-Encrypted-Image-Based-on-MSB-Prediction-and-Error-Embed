function encrypted_img_embedded = calculate_encrypted_img_embed_message(encrypted_img,error_location_marked_embedded)
%input: the encrypted image encrypted_img, the the embeded error_location_marked error_location_marked_embeded
%output: the encrypted image be embedded message encrypted_img_embedded
[m,n] = size(encrypted_img);
encrypted_img_embedded = encrypted_img;
for i = 1:m
    for j = 1:n
        if i ~= 1 || j > 8
            if error_location_marked_embedded(i,j) == 1 
                encrypted_img_embedded(i,j) = 128+mod(encrypted_img(i,j),128);
            elseif error_location_marked_embedded(i,j) == 0
                encrypted_img_embedded(i,j) = mod(encrypted_img(i,j),128);
            end
        end
    end
end
end

