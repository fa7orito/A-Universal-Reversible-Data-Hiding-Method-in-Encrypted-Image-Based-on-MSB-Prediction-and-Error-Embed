clc
clear
%读取图像
img = imread('Baboon.png');
[m,n] = size(img);
% imshow(img)
%计算加密每个像素8位的图像
x = 0.1; u = 4;
encrypted_img = lock_logistic_gray(img,x,u);
% figure 
% imshow(encrypted_img)
%计算反转MSB的inv
inverse = calculate_inverse(img);
%计算预测像素值
predictor = calculate_predictor(img);
%计算预测误差位置图
[error_location,error_location_restore_error_two] = calculate_error_location_binary_map(img, inverse, predictor, encrypted_img);
% figure
% imshow(imbinarize(error_location))

img_reconstructed = img;
total = sum(sum(error_location==2));

count = 0;
for i = 1 : m
    for j = 1 : n
        if error_location(i,j) == 2 && count < total/2
            img_reconstructed(i,j) = mod(img(i,j)+128,256);
            count = count + 1;
        end
    end
end
% figure
% imshow(img_reconstructed)

PSNR_marked_decrypted = metrix_psnr(img_reconstructed,img);
SSIM_marked_decrypted = metrix_ssim(img_reconstructed,img);


%计算可嵌入信息总量
block_size = 8;
blocks = reshape(error_location.',block_size,m*n/block_size).';
block_error = uint8(zeros(1,m*n/block_size));
for i = 1:m*n/block_size
    for j = 1:block_size
        if blocks(i,j)==1||blocks(i,j)==2
            block_error(i) = 1;
        end
    end
end
%如果第二块和最后一块有错误，块内全部置0
block_error(2) = 0;
block_error(m*n/block_size) = 0;
%标记flag块
block_flag = block_error;
for i = 2:m*n/block_size-1
    flag = [block_error(i),block_error(i+1)];
    if isequal(flag,[0 1]) 
        block_flag(i) = block_flag(i)+2;
    elseif isequal(flag,[1 0]) 
        block_flag(i+1) = block_flag(i+1)+2;
    end
end
%按照block_flag来标记
blocks_marked = blocks;
for i = 2:m*n/block_size
    if block_flag(i) == 2
        for j = 1:block_size
            blocks_marked(i,j) = 1;
        end
    elseif block_flag(i) == 4 
        for j = 1:block_size-1
            blocks_marked(i,j) = 1;
        end
        blocks_marked(i,block_size) = 0;
    end
end
bits_available = 8*sum(sum(block_flag==0));
ER = bits_available / 262144;
