clc
clear
imgPath = 'C:\Users\Dell\Documents\MATLAB\BOWS2OrigEp3\';
imgDir = dir([imgPath,'*.pgm']);
count = 0;
flag = uint8(zeros(1,length(imgDir)));
for k = 1:length(imgDir)
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
    %计算误差有没有连续的8个1或者7个1
    blocks = reshape(error_location_restore_error_two.',8,m*n/8).';
    for i = 1:m*n/8 
        error = uint8(zeros(1,8));
        for j = 1:8
            error(j) = blocks(i,j);
        end
        if isequal(error,[1 1 1 1 1 1 1 1]) || isequal(error,[1 1 1 1 1 1 1 0]) 
            count = count+1;
            flag(k) = 1;
            fprintf("Error found! ");
            break;
        end
    end
    fprintf("count = %d \n",count);
end

save data2