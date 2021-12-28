clc
clear
imgPath = 'C:\Users\Dell\Documents\MATLAB\EPE-HCRDH\experiments_image\BOSS\';
imgPath2 = 'C:\Users\Dell\Documents\MATLAB\EPE-HCRDH\experiments_image\encrypted&markedImages_BOSS\';
imgDir = dir([imgPath,'*.pgm']);
imgDir2 = dir([imgPath2,'*.png']);
count = 0;
average_bits_available = 0;
for k = 1:length(imgDir)
    Measurement(k).filename = imgDir(k).name;
    %%
    fprintf("File: %s \n",imgDir(k).name);
    %读取图像
    img1 = imread([imgPath imgDir(k).name]);
    img2 = imread([imgPath2 imgDir2(k).name]);
    %计算安全性指标
    Measurement(k).psnr = metrix_psnr(img1,img2);
    Measurement(k).ssim = metrix_ssim(img1,img2);
    Measurement(k).entropy = entropy(img2);
    Measurement(k).npcr = metrix_npcr(img1,img2);
    Measurement(k).uaci = metrix_uaci(img1,img2);
end



save data7