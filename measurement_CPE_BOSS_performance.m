clc
clear
imgPath = 'C:\Users\Dell\Documents\MATLAB\BOSSbase_1.01\';
imgDir = dir([imgPath,'*.pgm']);
for k = 1:length(imgDir)
    Measurement(k).filename = imgDir(k).name;
    %%
    %Ƕ��
    fprintf("File: %s ",imgDir(k).name);
    %��ȡͼ��
    img = imread([imgPath imgDir(k).name]);
    [m,n] = size(img);
    %�������ÿ������8λ��ͼ��
    x = 0.1; u = 4;
    encrypted_img = lock_logistic_gray(img,x,u);
    %���㷴תMSB��inv
    inverse = calculate_inverse(img);
    %����Ԥ������ֵ
    predictor = calculate_predictor(img);
    %����Ԥ�����λ��ͼ
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