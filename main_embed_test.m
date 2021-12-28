clc
clear
%读取图像
% img = imread('Crowd.png');
% img = imread('videotest/motion10.512.tiff');
img = imread('../BOWS2OrigEp3/30.pgm');
% img = imread('../OrigBows/HorseOrigIm3Ep3.pgm');
% img = imread('../BOSSbase_1.01/2782.pgm');
[m,n] = size(img);
imshow(img)
imwrite(img,'Original image.png');
%计算加密每个像素8位的图像
x = 0.1; u = 4;
encrypted_img = lock_logistic_gray(img,x,u);
figure 
imshow(encrypted_img)
imwrite(encrypted_img,'Encrypted image.png');
%计算反转MSB的inv
inverse = calculate_inverse(img);
%计算预测像素值
predictor = calculate_predictor(img);
%计算预测误差位置图
[error_location,error_location_restore_error_two] = calculate_error_location_binary_map(img, inverse, predictor, encrypted_img);
figure
imshow(imbinarize(error_location))
imwrite(imbinarize(error_location),'Error location binary map.png');
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
    figure
    imshow(imbinarize(error_location_marked))
    imwrite(imbinarize(error_location_marked),'Marked error location binary map.png');
else
    [error_location_marked,side_info_block_sec_error_flag,side_info_block_fin_error_flag,block_sec,block_fin,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,bits_available,blocks,blocks_marked,block_flag] = calculate_error_location_map_marked(encrypted_img,error_location,8);
    figure
    imshow(imbinarize(error_location_marked))
    imwrite(imbinarize(error_location_marked),'Marked error location binary map.png');
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
figure
imshow(encrypted_img_embedded)
imwrite(encrypted_img_embedded,'Marked encrypted image.png')

ER = bits_available / 262144;
PSNR_ecrypted = metrix_psnr(img,encrypted_img);
PSNR_markedecrypted = metrix_psnr(img,encrypted_img_embedded);
SSIM_ecrypted = metrix_ssim(img,encrypted_img);
SSIM_markedecrypted = metrix_ssim(img,encrypted_img_embedded);
entropy_encrypted = entropy(encrypted_img);
entropy_markedencrypted = entropy(encrypted_img_embedded);
NPCR_encrypted = metrix_npcr(img,encrypted_img);
NPCR_markedencrypted = metrix_npcr(img,encrypted_img_embedded);
UACI_encrypted = metrix_uaci(img,encrypted_img);
UACI_markedencrypted = metrix_uaci(img,encrypted_img_embedded);

save data1

