clc
clear
load data1
%读取图像
img_marked_encrypted = imread('Marked encrypted image.png');
[m,n] = size(img_marked_encrypted);
imshow(img_marked_encrypted)
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
    figure
    imshow(img_restore)
else
    [img_restore,block_property,block_property_true] = restore_image2(img_marked_encrypted,block_flag_restore_sec_fin,blocks_extract,8,modify_method_xy_or_map_extract,side_info_error_modify_location_extract,sec_block_restore,fin_block_restore,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract,side_info_block_sec_and_fin_error_two_origion_pixel_extract);
    figure
    imshow(img_restore)
end
imwrite(img_restore,'restore.png')
%判断是否还原了
isequal_message = isequal(message_extract,message);
isequal_img = isequal(img_restore,img);

