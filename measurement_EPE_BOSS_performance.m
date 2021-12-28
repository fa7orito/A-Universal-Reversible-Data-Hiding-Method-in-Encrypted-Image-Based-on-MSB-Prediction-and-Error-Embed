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
    
    Measurement(k).Payload = 262144 - sum(sum(error_location==1));
    Measurement(k).PSNR_img_reconstructed = metrix_psnr(img_reconstructed,img);
    Measurement(k).SSIM_img_reconstructed = metrix_ssim(img_reconstructed,img);
    fprintf("PSNR = %f, SSIM = %f, Payload = %d\n",Measurement(k).PSNR_img_reconstructed,Measurement(k).SSIM_img_reconstructed,Measurement(k).Payload);
end

save measurement_EPE_BOSS_database