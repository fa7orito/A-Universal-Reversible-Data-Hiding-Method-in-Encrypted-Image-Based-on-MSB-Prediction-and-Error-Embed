clc
clear
imgPath = 'C:\Users\Dell\Documents\MATLAB\BOWS2OrigEp3\';
imgDir = dir([imgPath,'*.pgm']);
count = 0;
flag = uint8(zeros(1,length(imgDir)));
for k = 1:length(imgDir)
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
    %�޸�Ԥ������е�11111111��11111110��������ĳ�01111111��01111110
    [error_location,error_modify_location_map,modify_flag] = error_location_modify(error_location,error_location_restore_error_two);
    if modify_flag == 1
        %����error_modify_location_map�ж���û�ж�Ԥ�����λ�ý����޸ģ�������޸�����
        %�ɸ���Ϣ��¼�޸�λ��
        [side_info_error_modify_location,side_info_error_modify_location_length,modify_method_xy_or_map,length_xy,length_map] = calculate_side_info_error_modify_location(error_modify_location_map);
    end
    %���Ԥ�������Ԥ�����ͼ�е�λ�ã������ܿ�Ƕ����Ϣ����
    if modify_flag == 1
        [error_location_marked,side_info_block_sec_error_flag,side_info_block_fin_error_flag,block_sec,block_fin,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,bits_available,blocks,blocks_marked,block_flag] = calculate_error_location_map_marked2(encrypted_img,error_location,8,side_info_error_modify_location);
    else
        [error_location_marked,side_info_block_sec_error_flag,side_info_block_fin_error_flag,block_sec,block_fin,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,bits_available,blocks,blocks_marked,block_flag] = calculate_error_location_map_marked(encrypted_img,error_location,8);
    end
    if sum(sum(block_flag==4)) ~= 0
        count = count + 1;
    end
    fprintf("count: %d \n",count);
end