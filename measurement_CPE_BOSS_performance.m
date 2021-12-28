clc
clear
imgPath = 'C:\Users\Dell\Documents\MATLAB\BOSSbase_1.01\';
imgDir = dir([imgPath,'*.pgm']);
for k = 1:length(imgDir)
    Measurement(k).filename = imgDir(k).name;
    %%
    %嵌入
    fprintf("File: %s ",imgDir(k).name);
    %读取图像
    img = imread([imgPath imgDir(k).name]);
    [m,n] = size(img);
    %计算加密每个像素8位的图像
    x = 0.1; u = 4;
    encrypted_img = lock_logistic_gray(img,x,u);
    %计算反转MSB的inv
    inverse = calculate_inverse(img);
    %计算预测像素值
    predictor = calculate_predictor(img);
    %计算预测误差位置图
    [error_location,error_location_restore_error_two] = calculate_error_location_binary_map(img, inverse, predictor, encrypted_img);
    img_reconstructed = img;
    for i = 1 : m
        for j = 1 : n
            if error_location(i,j) ~= 0
                if img(i,j) < 128
                    img_reconstructed(i,j) = img_reconstructed(i,j) - 63;
                else
                    img_reconstructed(i,j) = img_reconstructed(i,j) + 63;
                end
            end
        end
    end
    
    Measurement(k).PSNR_img_reconstructed = metrix_psnr(img_reconstructed,img);
    Measurement(k).SSIM_img_reconstructed = metrix_ssim(img_reconstructed,img);
    fprintf("PSNR = %f, SSIM = %f\n",Measurement(k).PSNR_img_reconstructed,Measurement(k).SSIM_img_reconstructed);
end

save measurement_CPE_BOSS_database