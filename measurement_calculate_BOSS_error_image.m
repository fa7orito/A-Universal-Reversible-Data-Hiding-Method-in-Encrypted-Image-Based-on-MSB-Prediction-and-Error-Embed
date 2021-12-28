clc
clear
imgPath = 'C:\Users\Dell\Documents\MATLAB\BOSSbase_1.01\';
imgDir = dir([imgPath,'*.pgm']);
count = 0;
flag = uint8(zeros(1,length(imgDir)));
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
    %修改预测误差中的11111111、11111110的情况，改成01111111、01111110
    [error_location,error_modify_location_map,modify_flag] = error_location_modify(error_location,error_location_restore_error_two);
    if modify_flag == 1
        %根据error_modify_location_map判断有没有对预测误差位置进行修改，如果有修改则生
        %成副信息记录修改位置
        [side_info_error_modify_location,side_info_error_modify_location_length,modify_method_xy_or_map,length_xy,length_map] = calculate_side_info_error_modify_location(error_modify_location_map);
        length2 = 0;
        Measurement(k).length_xy_or_map = min(length_xy,length_map);
        fprintf(" length_xy_or_map : %d  \n",length2);
    else
        Measurement(k).length_xy_or_map = 0;
        fprintf(" length_xy_or_map : 0  \n");
    end
end

save measurement_BOSS_error