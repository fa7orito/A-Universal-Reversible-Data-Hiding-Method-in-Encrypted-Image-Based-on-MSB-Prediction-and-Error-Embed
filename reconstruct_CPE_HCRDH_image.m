clc
clear
%读取图像
img = imread('Peppers.bmp');
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

ER = [0.16 0.47 0.99];
PSNRs = zeros(1,length(ER));
SSIMs = zeros(1,length(ER));
for k = 1 : length(ER)
    for i = 1 : m
        for j = 1 : n
            if error_location(i,j) ~= 0 && (i-1) * 512 + j < round(ER(k) * 262144)
                if img(i,j) < 128
                    img_reconstructed(i,j) = img_reconstructed(i,j) - 63;
                else
                    img_reconstructed(i,j) = img_reconstructed(i,j) + 63;
                end
            end
        end
    end
    % figure
    % imshow(img_reconstructed)
    
    PSNRs(k) = metrix_psnr(img_reconstructed,img);
    SSIMs(k) = metrix_ssim(img_reconstructed,img);
end