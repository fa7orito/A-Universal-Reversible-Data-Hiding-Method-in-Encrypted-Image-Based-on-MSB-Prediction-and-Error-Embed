clc
clear
imgPath = 'C:\Users\Dell\Documents\MATLAB\BOWS2OrigEp3\';
imgDir = dir([imgPath,'*.pgm']);
count = 0;
flag = uint8(zeros(1,length(imgDir)));
average_bits_available = 0;
for k = 1:length(imgDir)
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
    end
    %标记预测误差在预测误差图中的位置，计算总可嵌入信息容量
    if modify_flag == 1
        [error_location_marked,side_info_block_sec_error_flag,side_info_block_fin_error_flag,block_sec,block_fin,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,bits_available,blocks,blocks_marked,block_flag] = calculate_error_location_map_marked2(encrypted_img,error_location,8,side_info_error_modify_location);
    else
        [error_location_marked,side_info_block_sec_error_flag,side_info_block_fin_error_flag,block_sec,block_fin,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,bits_available,blocks,blocks_marked,block_flag] = calculate_error_location_map_marked(encrypted_img,error_location,8);
    end
    %根据容量生成信息
    if modify_flag == 1
        if side_info_block_sec_error_flag == 0 && side_info_block_fin_error_flag == 0
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,modify_flag,modify_method_xy_or_map,side_info_error_modify_location_length,side_info_error_modify_location,message];
            message = preprocess_message2(message);
        elseif side_info_block_sec_error_flag == 1 && side_info_block_fin_error_flag == 0
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_sec,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,modify_method_xy_or_map,side_info_error_modify_location_length,side_info_error_modify_location,message];
            message = preprocess_message2(message);
        elseif side_info_block_sec_error_flag == 0 && side_info_block_fin_error_flag == 1
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,modify_method_xy_or_map,side_info_error_modify_location_length,side_info_error_modify_location,message];
            message = preprocess_message2(message);
        else
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,modify_method_xy_or_map,side_info_error_modify_location_length,side_info_error_modify_location,message];
            message = preprocess_message2(message);
        end
    else
        if side_info_block_sec_error_flag == 0 && side_info_block_fin_error_flag == 0
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,modify_flag,message];
            message = preprocess_message2(message);
        elseif side_info_block_sec_error_flag == 1 && side_info_block_fin_error_flag == 0
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_sec,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,message];
            message = preprocess_message2(message);
        elseif side_info_block_sec_error_flag == 0 && side_info_block_fin_error_flag == 1
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,message];
            message = preprocess_message2(message);
        else
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,message];
            message = preprocess_message2(message);
        end
    end
    %把信息嵌入到预测误差图中
    error_location_marked_embedded = calculate_error_location_map_marked_embedded(error_location_marked,block_flag,message,8);
    %把标记和嵌入信息后的预测误差图嵌入加密图的MSB
    encrypted_img_embedded = calculate_encrypted_img_embed_message(encrypted_img,error_location_marked_embedded);
    %%
    %提取
    %读取图像
    img_marked_encrypted = encrypted_img_embedded;
    [m,n] = size(img_marked_encrypted);
    %提取MSB
    MSB_extract = extract_MSB(img_marked_encrypted);
    %找出标记块
    [blocks_extract,block_flag_extract] = extract_find_flag(MSB_extract,8);
    %根据标记块区分预测误差块和无预测误差块
    block_flag_extract = extract_blocks_flag(block_flag_extract);
    %提取message
    [bits_available_extract,message_extract,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract,side_info_block_sec_extract,side_info_block_fin_extract,side_info_block_sec_and_fin_error_two_origion_pixel_extract,modify_flag_extract,modify_method_xy_or_map_extract,side_info_error_modify_location_length_extract,side_info_error_modify_location_extract] = extract_message(block_flag_extract,blocks_extract,8);
    %根据side_info恢复第二块和最后块的标记信息
    [block_flag_restore_sec_fin,sec_block_restore,fin_block_restore] = restore_sec_fin_block_in_block_flag_extract(block_flag_extract,side_info_block_sec_extract,side_info_block_fin_extract,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract);
    %复原图像
    if modify_flag_extract == 0
        [img_restore,block_property,block_property_true] = restore_image(img_marked_encrypted,block_flag_restore_sec_fin,blocks_extract,8,sec_block_restore,fin_block_restore,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract,side_info_block_sec_and_fin_error_two_origion_pixel_extract);
    else
        [img_restore,block_property,block_property_true] = restore_image2(img_marked_encrypted,block_flag_restore_sec_fin,blocks_extract,8,modify_method_xy_or_map_extract,side_info_error_modify_location_extract,sec_block_restore,fin_block_restore,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract,side_info_block_sec_and_fin_error_two_origion_pixel_extract);
    end
    %判断是否还原了
    isequal_message = isequal(message_extract,message);
    isequal_img = isequal(img_restore,img);
    if isequal_message == 1
        fprintf("Message restored success ");
    else
        fprintf("Message restored failed  ");
    end
    if isequal_img == 1
        fprintf("Image restored success \n");
    else
        fprintf("Image restored failed  \n");
    end
    average_bits_available = average_bits_available + bits_available;
    if isequal_message ~= 1 || isequal_img~=1
        count = count + 1;
        flag(k) = 1;
    end
end

average_bits_available = average_bits_available/length(imgDir);

save data3