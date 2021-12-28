function [error_location_binary_map,error_location_binary_map_restore_error_two] = calculate_error_location_binary_map(I, inverse, predictor, encrypted_img)
%input: the image I, the MSB inverse of I, the predictor of I
%output: the predictor error location of I
error_location_binary_map = double(I);
error_location_binary_map_restore_error_two = double(I);
[m,n] = size(I);
I = double(I);
encrypted_img = double(encrypted_img);
inverse = double(inverse);
predictor = double(predictor);
for i = 1:m
    for j = 1:n
        if i==1 && j==1
            error_location_binary_map(i,j) = 0;
            error_location_binary_map_restore_error_two(i,j) = 0;
        else
            delta = abs(predictor(i,j)-I(i,j));
            delta_inv = abs(predictor(i,j)-inverse(i,j));
            if delta < delta_inv
                error_location_binary_map(i,j) = 0;
                error_location_binary_map_restore_error_two(i,j) = 0;
            elseif delta > delta_inv
                error_location_binary_map(i,j) = 1;
                error_location_binary_map_restore_error_two(i,j) = 1;
            else
                error_location_binary_map(i,j) = 2;
                error_location_binary_map_restore_error_two(i,j) = floor(encrypted_img(i,j)/128);
            end
        end
    end
end
error_location_binary_map = uint8(error_location_binary_map);
error_location_binary_map_restore_error_two = uint8(error_location_binary_map_restore_error_two);
end

