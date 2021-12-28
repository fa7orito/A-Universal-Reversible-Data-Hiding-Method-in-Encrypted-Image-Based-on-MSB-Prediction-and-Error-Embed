clc
clear
imgPath = 'C:\Users\Dell\Documents\MATLAB\BOSSbase_1.01\';
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
    %�޸�Ԥ������е�11111111��11111110��������ĳ�01111111��01111110
    [error_location,error_modify_location_map,modify_flag] = error_location_modify(error_location,error_location_restore_error_two);
    if modify_flag == 1
        %����error_modify_location_map�ж���û�ж�Ԥ�����λ�ý����޸ģ�������޸�����
        %�ɸ���Ϣ��¼�޸�λ��
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