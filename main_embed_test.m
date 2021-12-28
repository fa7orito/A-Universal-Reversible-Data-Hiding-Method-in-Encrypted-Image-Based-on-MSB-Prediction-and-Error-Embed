clc
clear
%��ȡͼ��
% img = imread('Crowd.png');
% img = imread('videotest/motion10.512.tiff');
img = imread('../BOWS2OrigEp3/30.pgm');
% img = imread('../OrigBows/HorseOrigIm3Ep3.pgm');
% img = imread('../BOSSbase_1.01/2782.pgm');
[m,n] = size(img);
imshow(img)
imwrite(img,'Original image.png');
%�������ÿ������8λ��ͼ��
x = 0.1; u = 4;
encrypted_img = lock_logistic_gray(img,x,u);
figure 
imshow(encrypted_img)
imwrite(encrypted_img,'Encrypted image.png');
%���㷴תMSB��inv
inverse = calculate_inverse(img);
%����Ԥ������ֵ
predictor = calculate_predictor(img);
%����Ԥ�����λ��ͼ
[error_location,error_location_restore_error_two] = calculate_error_location_binary_map(img, inverse, predictor, encrypted_img);
figure
imshow(imbinarize(error_location))
imwrite(imbinarize(error_location),'Error location binary map.png');
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
    figure
    imshow(imbinarize(error_location_marked))
    imwrite(imbinarize(error_location_marked),'Marked error location binary map.png');
else
    [error_location_marked,side_info_block_sec_error_flag,side_info_block_fin_error_flag,block_sec,block_fin,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,bits_available,blocks,blocks_marked,block_flag] = calculate_error_location_map_marked(encrypted_img,error_location,8);
    figure
    imshow(imbinarize(error_location_marked))
    imwrite(imbinarize(error_location_marked),'Marked error location binary map.png');
end
%��������������Ϣ
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
%����ϢǶ�뵽Ԥ�����ͼ��
error_location_marked_embedded = calculate_error_location_map_marked_embedded(error_location_marked,block_flag,message,8);
%�ѱ�Ǻ�Ƕ����Ϣ���Ԥ�����ͼǶ�����ͼ��MSB
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

