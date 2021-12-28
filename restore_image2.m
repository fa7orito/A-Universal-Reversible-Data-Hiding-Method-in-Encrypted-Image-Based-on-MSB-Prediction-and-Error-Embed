function [img_restore,block_property,block_property_true] = restore_image2(img_marked_encrypted,block_flag_restore_sec_fin,blocks_extract,block_size,modify_method_xy_or_map_extract,side_info_error_modify_location_extract,sec_block_restore,fin_block_restore,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract,side_info_block_sec_and_fin_error_two_origion_pixel_extract)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(img_marked_encrypted);
block_flag_restore_sec_fin_transform = reshape(block_flag_restore_sec_fin.',n/block_size,m).';
block_property = uint8(zeros(m,n));
[a,b] = size(block_flag_restore_sec_fin_transform);
%把误差块里的像素都标记成1，没有误差的都标记为0，存储为block_property
for i = 1:a
    for j = 1:b
        if block_flag_restore_sec_fin_transform(i,j) == 1
            for k = 1:block_size
                block_property(i,(j-1)*block_size+k) = 1;
            end
        end
    end
end
%把误差块里的标记为对应blocks_extract里的值，存储为block_property_true
block_property_true = reshape(blocks_extract.',m,n).';
for i = 1:m
    for j = 1:n
        if block_property(i,j) == 0
            block_property_true(i,j) = 0;
        end
    end
end
%把第二块和最后一块的块内原始误差标记还原,并把第二块和最后一块的块内原始误差标记为2的位置的像素MSB还原成加密后的MSB
blocks_img_marked_encrypted = reshape(img_marked_encrypted.',block_size,m*n/block_size).';
if side_info_block_sec_error_flag_extract == 0 && side_info_block_fin_error_flag_extract == 0
    
elseif side_info_block_sec_error_flag_extract == 1 && side_info_block_fin_error_flag_extract == 0
    for i = 9:16
        block_property_true(1,i) = sec_block_restore(i-8);
    end
    [~,l] = size(side_info_block_sec_and_fin_error_two_origion_pixel_extract);
    if l ~= 0
        count = 0;
        for i = 1:block_size
            if sec_block_restore(i) == 2 
                count = count + 1;
                blocks_img_marked_encrypted(2,i) = 128*side_info_block_sec_and_fin_error_two_origion_pixel_extract(count) + mod(blocks_img_marked_encrypted(2,i),128);
            end
        end
    end
elseif side_info_block_sec_error_flag_extract == 0 && side_info_block_fin_error_flag_extract == 1
    for i = 505:512
        block_property_true(512,i) = fin_block_restore(i-504);
    end
    [~,l] = size(side_info_block_sec_and_fin_error_two_origion_pixel_extract);
    if l ~= 0
        count = 0;
        for i = 1:block_size
            if fin_block_restore(i) == 2 
                count = count + 1;
                blocks_img_marked_encrypted(32768,i) = 128*side_info_block_sec_and_fin_error_two_origion_pixel_extract(count) + mod(blocks_img_marked_encrypted(32768,i),128);
            end
        end
    end
else
    for i = 9:16
        block_property_true(1,i) = sec_block_restore(i-8);
    end
    for i = 505:512
        block_property_true(512,i) = fin_block_restore(i-504);
    end
    [~,l] = size(side_info_block_sec_and_fin_error_two_origion_pixel_extract);
    if l ~= 0
        count = 0;
        for i = 1:block_size
            if sec_block_restore(i) == 2 
                count = count + 1;
                blocks_img_marked_encrypted(2,i) = 128*side_info_block_sec_and_fin_error_two_origion_pixel_extract(count) + mod(blocks_img_marked_encrypted(2,i),128);
            end
        end
        if count ~= l
            for i = 1:block_size
                if fin_block_restore(i) == 2
                    count = count + 1;
                    blocks_img_marked_encrypted(32768,i) = 128*side_info_block_sec_and_fin_error_two_origion_pixel_extract(count) + mod(blocks_img_marked_encrypted(32768,i),128);
                end
            end
        end
    end
end
img_marked_encrypted = reshape(blocks_img_marked_encrypted.',m,n).';
%根据modify_method_xy_or_map_extract,side_info_error_modify_location复原修改过的预测误差位置
if modify_method_xy_or_map_extract == 0
    [~,length] = size(side_info_error_modify_location_extract);
    side_info_error_modify_location_extract = reshape(side_info_error_modify_location_extract.',18,length/18).';
    for i = 1:length/18
        x = zeros(1,9);
        y = zeros(1,9);
        for j = 1:9
            x(j) = side_info_error_modify_location_extract(i,j);
        end
        for j = 10:18
            y(j-9) = side_info_error_modify_location_extract(i,j);
        end
        x_true = 0;
        y_true = 0;
        for j = 1:9
            x_true = x_true + x(9-j+1)*(2^(j-1));
        end
        for j = 1:9
            y_true = y_true + y(9-j+1)*(2^(j-1));
        end
        block_property_true(x_true+1,y_true+1) = 1;
        img_marked_encrypted(x_true+1,y_true+1) = 128 + mod(img_marked_encrypted(x_true+1,y_true+1),128);
    end
else
    [~,length] = size(side_info_error_modify_location_extract);
    side_info_error_modify_location_extract = reshape(side_info_error_modify_location_extract.',8,length/8).';
    y_recover=uint8(zeros(length/8,1));
    for i = 1:length/8
        temp = uint8(zeros(1,8));
        for j = 1:8
            temp(j) = side_info_error_modify_location_extract(i,j);
        end
        temp_true = 0;
        for j = 1:8
            temp_true = temp_true + temp(8-j+1)*(2^(j-1));
        end
        y_recover(i,1) = temp_true;
    end
    y_recover = double(y_recover);
    xC_recover=Arith07(y_recover);
    LocationMap_Decode=xC_recover{1,1};
    LocationMapRecover=uint8(reshape(LocationMap_Decode,m,n));
    for i = 1:m
        for j = 1:n
            if LocationMapRecover(i,j) == 1
                block_property_true(i,j) = 1;
                img_marked_encrypted(i,j) = 128 + mod(img_marked_encrypted(i,j),128);
            end
        end
    end
end
%计算解密每个像素8位的图像
x = 0.1; u=4;
decrypted_img = lock_logistic_gray(img_marked_encrypted,x,u);
%开始恢复图像
img_restore = double(decrypted_img);
for i = 1:m
    for j = 1:n
        MSB0 = uint8(mod(img_restore(i,j),128));
        MSB1 = uint8(mod(img_restore(i,j),128)+128);
        if i == 1 && j >= 1 && j <= 8
            %第一块不改变MSB
        elseif i == 1 && j > 8
            predictor = uint8(img_restore(i,j-1));
            delta0 = abs(double(predictor)-double(MSB0));
            delta1 = abs(double(predictor)-double(MSB1));
            if block_property(i,j) == 0
                if delta0 < delta1
                    img_restore(i,j) = MSB0;
                elseif delta1 < delta0
                    img_restore(i,j) = MSB1;
                else
                    fprintf("(%d,%d)delta0 = %d delta1 = %d Error: 无预测误差块出现delta0=delta1！\n",i,j,delta0,delta1);
                end
            elseif block_property(i,j) == 1 && block_property_true(i,j) == 0
                if delta0 < delta1
                    img_restore(i,j) = MSB0;
                elseif delta1 < delta0
                    img_restore(i,j) = MSB1;
                else
                    %delta0 = delta1 不改变MSB
                end
            elseif block_property(i,j) == 1 && block_property_true(i,j) == 1
                if delta0 < delta1
                    img_restore(i,j) = MSB1;
                elseif delta1 < delta0
                    img_restore(i,j) = MSB0;
                else
                    %delta0 = delta1 不改变MSB
                end
            end
        elseif i ~= 1 && j == 1
            predictor = uint8(img_restore(i-1,j));
            delta0 = abs(double(predictor)-double(MSB0));
            delta1 = abs(double(predictor)-double(MSB1));
            if block_property(i,j) == 0
                if delta0 < delta1
                    img_restore(i,j) = MSB0;
                elseif delta1 < delta0
                    img_restore(i,j) = MSB1;
                else
                    fprintf("(%d,%d)delta0 = %d delta1 = %d Error: 无预测误差块出现delta0=delta1！\n",i,j,delta0,delta1);
                end
            elseif block_property(i,j) == 1 && block_property_true(i,j) == 0
                if delta0 < delta1
                    img_restore(i,j) = MSB0;
                elseif delta1 < delta0
                    img_restore(i,j) = MSB1;
                else
                    %delta0 = delta1 不改变MSB
                end
            elseif block_property(i,j) == 1 && block_property_true(i,j) == 1
                if delta0 < delta1
                    img_restore(i,j) = MSB1;
                elseif delta1 < delta0
                    img_restore(i,j) = MSB0;
                else
                    %delta0 = delta1 不改变MSB
                end
            end
        elseif i ~= 1 && j ~= 1
            predictor = uint8((img_restore(i,j-1)+img_restore(i-1,j))/2);
            delta0 = abs(double(predictor)-double(MSB0));
            delta1 = abs(double(predictor)-double(MSB1));
            if block_property(i,j) == 0
                if delta0 < delta1
                    img_restore(i,j) = MSB0;
                elseif delta1 < delta0
                    img_restore(i,j) = MSB1;
                else
                    fprintf("(%d,%d)delta0 = %d delta1 = %d Error: 无预测误差块出现delta0=delta1！\n",i,j,delta0,delta1);
                end
            elseif block_property(i,j) == 1 && block_property_true(i,j) == 0
                if delta0 < delta1
                    img_restore(i,j) = MSB0;
                elseif delta1 < delta0
                    img_restore(i,j) = MSB1;
                else
                    %delta0 = delta1 不改变MSB
                end
            elseif block_property(i,j) == 1 && block_property_true(i,j) == 1
                if delta0 < delta1
                    img_restore(i,j) = MSB1;
                elseif delta1 < delta0
                    img_restore(i,j) = MSB0;
                else
                    %delta0 = delta1 不改变MSB
                end
            end
        end
    end
end
img_restore = uint8(img_restore);
end

