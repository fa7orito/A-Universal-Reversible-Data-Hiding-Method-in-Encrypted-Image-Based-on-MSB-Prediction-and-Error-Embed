clc
clear
imgPath = 'C:\Users\Dell\Documents\MATLAB\BOWS2OrigEp3\';
imgDir = dir([imgPath,'*.pgm']);
count = 0;
flag = uint8(zeros(1,length(imgDir)));
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
    Measurement(k).error_numbers = sum(sum(error_location~=0));
    Measurement(k).error_numbers_percent = sum(sum(error_location~=0))/262144;
    %�޸�Ԥ������е�11111111��11111110��������ĳ�01111111��01111110
    [error_location,error_modify_location_map,modify_flag] = error_location_modify(error_location,error_location_restore_error_two);
    if modify_flag == 1
        %����error_modify_location_map�ж���û�ж�Ԥ�����λ�ý����޸ģ�������޸�����
        %�ɸ���Ϣ��¼�޸�λ��
        [side_info_error_modify_location,side_info_error_modify_location_length,modify_method_xy_or_map,length_xy,length_map] = calculate_side_info_error_modify_location(error_modify_location_map);
        Measurement(k).modify_flag = 1;
        Measurement(k).length_xy = length_xy;
        Measurement(k).length_map = length_map;
    else
        Measurement(k).modify_flag = 0;
        Measurement(k).length_xy = 0;
        Measurement(k).length_map = 0;
    end
    %���Ԥ�������Ԥ�����ͼ�е�λ�ã������ܿ�Ƕ����Ϣ����
    if modify_flag == 1
        [error_location_marked,side_info_block_sec_error_flag,side_info_block_fin_error_flag,block_sec,block_fin,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,bits_available,blocks,blocks_marked,block_flag] = calculate_error_location_map_marked2(encrypted_img,error_location,8,side_info_error_modify_location);
    else
        [error_location_marked,side_info_block_sec_error_flag,side_info_block_fin_error_flag,block_sec,block_fin,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,bits_available,blocks,blocks_marked,block_flag] = calculate_error_location_map_marked(encrypted_img,error_location,8);
    end
    %��������������Ϣ
    if modify_flag == 1
        if side_info_block_sec_error_flag == 0 && side_info_block_fin_error_flag == 0
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,modify_flag,modify_method_xy_or_map,side_info_error_modify_location_length,side_info_error_modify_location,message];
            message = preprocess_message2(message);
            Measurement(k).total_bits = length(message);
            Measurement(k).sideinfo_bits = length(message)-bits_available;
            Measurement(k).sideinfo_bits_percent = (length(message)-bits_available)/length(message);
            Measurement(k).pure_bits = bits_available;
            Measurement(k).pure_bits_percent = bits_available/length(message);
        elseif side_info_block_sec_error_flag == 1 && side_info_block_fin_error_flag == 0
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_sec,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,modify_method_xy_or_map,side_info_error_modify_location_length,side_info_error_modify_location,message];
            message = preprocess_message2(message);
            Measurement(k).total_bits = length(message);
            Measurement(k).sideinfo_bits = length(message)-bits_available;
            Measurement(k).sideinfo_bits_percent = (length(message)-bits_available)/length(message);
            Measurement(k).pure_bits = bits_available;
            Measurement(k).pure_bits_percent = bits_available/length(message);
        elseif side_info_block_sec_error_flag == 0 && side_info_block_fin_error_flag == 1
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,modify_method_xy_or_map,side_info_error_modify_location_length,side_info_error_modify_location,message];
            message = preprocess_message2(message);
            Measurement(k).total_bits = length(message);
            Measurement(k).sideinfo_bits = length(message)-bits_available;
            Measurement(k).sideinfo_bits_percent = (length(message)-bits_available)/length(message);
            Measurement(k).pure_bits = bits_available;
            Measurement(k).pure_bits_percent = bits_available/length(message);
        else
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,modify_method_xy_or_map,side_info_error_modify_location_length,side_info_error_modify_location,message];
            message = preprocess_message2(message);
            Measurement(k).total_bits = length(message);
            Measurement(k).sideinfo_bits = length(message)-bits_available;
            Measurement(k).sideinfo_bits_percent = (length(message)-bits_available)/length(message);
            Measurement(k).pure_bits = bits_available;
            Measurement(k).pure_bits_percent = bits_available/length(message);
        end
    else
        if side_info_block_sec_error_flag == 0 && side_info_block_fin_error_flag == 0
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,modify_flag,message];
            message = preprocess_message2(message);
            Measurement(k).total_bits = length(message);
            Measurement(k).sideinfo_bits = length(message)-bits_available;
            Measurement(k).sideinfo_bits_percent = (length(message)-bits_available)/length(message);
            Measurement(k).pure_bits = bits_available;
            Measurement(k).pure_bits_percent = bits_available/length(message);
        elseif side_info_block_sec_error_flag == 1 && side_info_block_fin_error_flag == 0
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_sec,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,message];
            message = preprocess_message2(message);
            Measurement(k).total_bits = length(message);
            Measurement(k).sideinfo_bits = length(message)-bits_available;
            Measurement(k).sideinfo_bits_percent = (length(message)-bits_available)/length(message);
            Measurement(k).pure_bits = bits_available;
            Measurement(k).pure_bits_percent = bits_available/length(message);
        elseif side_info_block_sec_error_flag == 0 && side_info_block_fin_error_flag == 1
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,message];
            message = preprocess_message2(message);
            Measurement(k).total_bits = length(message);
            Measurement(k).sideinfo_bits = length(message)-bits_available;
            Measurement(k).sideinfo_bits_percent = (length(message)-bits_available)/length(message);
            Measurement(k).pure_bits = bits_available;
            Measurement(k).pure_bits_percent = bits_available/length(message);
        else
            message = uint8(randi([0,1],1,bits_available));
            message = [side_info_block_sec_error_flag,side_info_block_fin_error_flag,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,modify_flag,message];
            message = preprocess_message2(message);
            Measurement(k).total_bits = length(message);
            Measurement(k).sideinfo_bits = length(message)-bits_available;
            Measurement(k).sideinfo_bits_percent = (length(message)-bits_available)/length(message);
            Measurement(k).pure_bits = bits_available;
            Measurement(k).pure_bits_percent = bits_available/length(message);
        end
    end
    %����ϢǶ�뵽Ԥ�����ͼ��
    error_location_marked_embedded = calculate_error_location_map_marked_embedded(error_location_marked,block_flag,message,8);
    %�ѱ�Ǻ�Ƕ����Ϣ���Ԥ�����ͼǶ�����ͼ��MSB
    encrypted_img_embedded = calculate_encrypted_img_embed_message(encrypted_img,error_location_marked_embedded);
    imwrite(encrypted_img_embedded,['C:\Users\Dell\Documents\MATLAB\encrypted&markedImages\',imgDir(k).name(1:end-4),'.png']);
     %%
    %��ȡ
    %��ȡͼ��
    img_marked_encrypted = encrypted_img_embedded;
    [m,n] = size(img_marked_encrypted);
    %��ȡMSB
    MSB_extract = extract_MSB(img_marked_encrypted);
    %�ҳ���ǿ�
    [blocks_extract,block_flag_extract] = extract_find_flag(MSB_extract,8);
    %���ݱ�ǿ�����Ԥ���������Ԥ������
    block_flag_extract = extract_blocks_flag(block_flag_extract);
    %��ȡmessage
    [bits_available_extract,message_extract,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract,side_info_block_sec_extract,side_info_block_fin_extract,side_info_block_sec_and_fin_error_two_origion_pixel_extract,modify_flag_extract,modify_method_xy_or_map_extract,side_info_error_modify_location_length_extract,side_info_error_modify_location_extract] = extract_message(block_flag_extract,blocks_extract,8);
    %����side_info�ָ��ڶ��������ı����Ϣ
    [block_flag_restore_sec_fin,sec_block_restore,fin_block_restore] = restore_sec_fin_block_in_block_flag_extract(block_flag_extract,side_info_block_sec_extract,side_info_block_fin_extract,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract);
    %��ԭͼ��
    if modify_flag_extract == 0
        [img_restore,block_property,block_property_true] = restore_image(img_marked_encrypted,block_flag_restore_sec_fin,blocks_extract,8,sec_block_restore,fin_block_restore,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract,side_info_block_sec_and_fin_error_two_origion_pixel_extract);
    else
        [img_restore,block_property,block_property_true] = restore_image2(img_marked_encrypted,block_flag_restore_sec_fin,blocks_extract,8,modify_method_xy_or_map_extract,side_info_error_modify_location_extract,sec_block_restore,fin_block_restore,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract,side_info_block_sec_and_fin_error_two_origion_pixel_extract);
    end
    %�ж��Ƿ�ԭ��
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
    if isequal_message ~= 1 || isequal_img ~= 1
        count = count + 1;
        flag(k) = 1;
    end
end

save data4