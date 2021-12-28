function [bits_available_extract,message_extract,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract,side_info_block_sec_extract,side_info_block_fin_extract,side_info_block_sec_and_fin_error_two_origion_pixel_extract,modify_flag_extract,modify_method_xy_or_map_extract,side_info_error_modify_location_length_extract,side_info_error_modify_location_extract] = extract_message(block_flag_extract,blocks_extract,block_size)
%input: error block and message block marked blocks block_flag_extract, the
%extracted MSB of every pixel in img blocks_extract, size of block block_size
%output: total bits of message bits_available_extract, extracted message 
%message_extract
[~,length] = size(block_flag_extract);
%计算message长度
total_bits = 0;
for i = 2:length
   if  block_flag_extract(i) == 0
       total_bits = total_bits+block_size;
   end
end
%提取message
message_extract = uint8(zeros(1,total_bits));
message_blocks = reshape(message_extract.',block_size,total_bits/block_size).';
message_blocks_row = 0;
for i = 2:length
    if block_flag_extract(i) == 0
        message_blocks_row = message_blocks_row+1;
        for j = 1:block_size
             message_blocks(message_blocks_row,j) = blocks_extract(i,j);
        end
    end
end
message_extract = reshape(message_blocks.',total_bits,1).';
%将message_extract中逢6个1之后的0删除
message_extract_eliminate_zero_every_sixe_ones = inverse_preprocess_message2(message_extract);
%区分message和side_info
side_info_block_sec_error_flag_extract = message_extract_eliminate_zero_every_sixe_ones(1);
side_info_block_fin_error_flag_extract = message_extract_eliminate_zero_every_sixe_ones(2);
if side_info_block_sec_error_flag_extract == 0 && side_info_block_fin_error_flag_extract == 0
    side_info_block_sec_extract = uint8(zeros(1,0));
    side_info_block_fin_extract = uint8(zeros(1,0));
    side_info_block_sec_and_fin_error_two_origion_pixel_extract = uint8(zeros(1,0));
    modify_flag_extract = message_extract_eliminate_zero_every_sixe_ones(2+1);
    if modify_flag_extract == 0
        %没有修改预测误差位置
        bits_available_extract = total_bits-2-1;
        modify_method_xy_or_map_extract = -1;
        side_info_error_modify_location_length_extract = -1;
        side_info_error_modify_location_extract = -1;
    else
        %修改了预测误差位置
        modify_method_xy_or_map_extract = message_extract_eliminate_zero_every_sixe_ones(2+2);
        side_info_error_modify_location_length_extract = uint8(zeros(1,10));
        length = 0;
        for i = 2+3:2+12
            side_info_error_modify_location_length_extract(i-2-2) = message_extract_eliminate_zero_every_sixe_ones(i);
        end
        for i = 1:10
            length = length + double(side_info_error_modify_location_length_extract(10-i+1))*(2^(i-1));
        end
        side_info_error_modify_location_extract = uint8(zeros(1,length));
        for i = 2+12+1:2+12+length
            side_info_error_modify_location_extract(i-2-12) = message_extract_eliminate_zero_every_sixe_ones(i);
        end
        bits_available_extract = total_bits-2-12-length;
    end
elseif side_info_block_sec_error_flag_extract == 1 && side_info_block_fin_error_flag_extract == 0
    side_info_block_sec_extract = uint8(zeros(1,block_size*2));
    side_info_block_fin_extract = uint8(zeros(1,0));
    for i = 1:block_size*2
        side_info_block_sec_extract(i) = message_extract_eliminate_zero_every_sixe_ones(2+i);
    end
    sec_block_restore = uint8(zeros(1,block_size));
    for i = 1:block_size
        temp = [side_info_block_sec_extract(i*2-1),side_info_block_sec_extract(i*2)];
        if isequal(temp,[0 0])
            sec_block_restore(i) = 0;
        elseif isequal(temp,[0 1])
            sec_block_restore(i) = 1;
        elseif isequal(temp,[1 0])
            sec_block_restore(i) = 2;
        end
    end
    side_info_block_sec_and_fin_error_two_origion_pixel_extract = uint8(zeros(1,0));
    for i = 2+16+1:2+16+sum(sum(sec_block_restore==2))
        side_info_block_sec_and_fin_error_two_origion_pixel_extract = [side_info_block_sec_and_fin_error_two_origion_pixel_extract message_extract_eliminate_zero_every_sixe_ones(i)];
    end
    modify_flag_extract = message_extract_eliminate_zero_every_sixe_ones(2+16+sum(sum(sec_block_restore==2))+1);
    if modify_flag_extract == 0
        %没有修改预测误差位置
        bits_available_extract = total_bits-2-16-sum(sum(sec_block_restore==2))-1;
        modify_method_xy_or_map_extract = -1;
        side_info_error_modify_location_length_extract = -1;
        side_info_error_modify_location_extract = -1;
    else
        %修改了预测误差位置
        modify_method_xy_or_map_extract = message_extract_eliminate_zero_every_sixe_ones(2+16+sum(sum(sec_block_restore==2))+2);
        side_info_error_modify_location_length_extract = uint8(zeros(1,10));
        length = 0;
        for i = 2+16+sum(sum(sec_block_restore==2))+3:2+16+sum(sum(sec_block_restore==2))+12
            side_info_error_modify_location_length_extract(i-2-16-sum(sum(sec_block_restore==2))-2) = message_extract_eliminate_zero_every_sixe_ones(i);
        end
        for i = 1:10
            length = length + double(side_info_error_modify_location_length_extract(10-i+1))*(2^(i-1));
        end
        side_info_error_modify_location_extract = uint8(zeros(1,length));
        for i = 2+16+sum(sum(sec_block_restore==2))+12+1:2+16+sum(sum(sec_block_restore==2))+12+length
            side_info_error_modify_location_extract(i-2-16-sum(sum(sec_block_restore==2))-12) = message_extract_eliminate_zero_every_sixe_ones(i);
        end
        bits_available_extract = total_bits-2-16-sum(sum(sec_block_restore==2))-12-length;
    end
elseif side_info_block_sec_error_flag_extract == 0 && side_info_block_fin_error_flag_extract == 1
    side_info_block_sec_extract = uint8(zeros(1,0));
    side_info_block_fin_extract = uint8(zeros(1,block_size*2));
    for i = 1:block_size*2
        side_info_block_fin_extract(i) = message_extract_eliminate_zero_every_sixe_ones(2+i);
    end
    fin_block_restore = uint8(zeros(1,block_size));
    for i = 1:block_size
        temp = [side_info_block_fin_extract(i*2-1),side_info_block_fin_extract(i*2)];
        if isequal(temp,[0 0])
            fin_block_restore(i) = 0;
        elseif isequal(temp,[0 1])
            fin_block_restore(i) = 1;
        elseif isequal(temp,[1 0])
            fin_block_restore(i) = 2;
        end
    end
    side_info_block_sec_and_fin_error_two_origion_pixel_extract = uint8(zeros(1,0));
    for i = 2+16+1:2+16+sum(sum(fin_block_restore==2))
        side_info_block_sec_and_fin_error_two_origion_pixel_extract = [side_info_block_sec_and_fin_error_two_origion_pixel_extract message_extract_eliminate_zero_every_sixe_ones(i)];
    end
    modify_flag_extract = message_extract_eliminate_zero_every_sixe_ones(2+16+sum(sum(fin_block_restore==2))+1);
    if modify_flag_extract == 0
        %没有修改预测误差位置
        bits_available_extract = total_bits-2-16-sum(sum(fin_block_restore==2))-1;
        modify_method_xy_or_map_extract = -1;
        side_info_error_modify_location_length_extract = -1;
        side_info_error_modify_location_extract = -1;
    else
        %修改了预测误差位置
        modify_method_xy_or_map_extract = message_extract_eliminate_zero_every_sixe_ones(2+16+sum(sum(fin_block_restore==2))+2);
        side_info_error_modify_location_length_extract = uint8(zeros(1,10));
        length = 0;
        for i = 2+16+sum(sum(fin_block_restore==2))+3:2+16+sum(sum(fin_block_restore==2))+12
            side_info_error_modify_location_length_extract(i-2-16-sum(sum(fin_block_restore==2))-2) = message_extract_eliminate_zero_every_sixe_ones(i);
        end
        for i = 1:10
            length = length + double(side_info_error_modify_location_length_extract(10-i+1))*(2^(i-1));
        end
        side_info_error_modify_location_extract = uint8(zeros(1,length));
        for i = 2+16+sum(sum(fin_block_restore==2))+12+1:2+16+sum(sum(fin_block_restore==2))+12+length
            side_info_error_modify_location_extract(i-2-16-sum(sum(fin_block_restore==2))-12) = message_extract_eliminate_zero_every_sixe_ones(i);
        end
        bits_available_extract = total_bits-2-16-sum(sum(fin_block_restore==2))-12-length;
    end
else
    side_info_block_sec_extract = uint8(zeros(1,block_size*2));
    side_info_block_fin_extract = uint8(zeros(1,block_size*2));
    for i = 1:block_size*2
        side_info_block_sec_extract(i) = message_extract_eliminate_zero_every_sixe_ones(2+i);
    end
    for i = 1:block_size*2
        side_info_block_fin_extract(i) = message_extract_eliminate_zero_every_sixe_ones(2+16+i);
    end
    sec_block_restore = uint8(zeros(1,block_size));
    for i = 1:block_size
        temp = [side_info_block_sec_extract(i*2-1),side_info_block_sec_extract(i*2)];
        if isequal(temp,[0 0])
            sec_block_restore(i) = 0;
        elseif isequal(temp,[0 1])
            sec_block_restore(i) = 1;
        elseif isequal(temp,[1 0])
            sec_block_restore(i) = 2;
        end
    end
    fin_block_restore = uint8(zeros(1,block_size));
    for i = 1:block_size
        temp = [side_info_block_fin_extract(i*2-1),side_info_block_fin_extract(i*2)];
        if isequal(temp,[0 0])
            fin_block_restore(i) = 0;
        elseif isequal(temp,[0 1])
            fin_block_restore(i) = 1;
        elseif isequal(temp,[1 0])
            fin_block_restore(i) = 2;
        end
    end
    side_info_block_sec_and_fin_error_two_origion_pixel_extract = uint8(zeros(1,0));
    for i = 2+32+1:2+32+sum(sum(sec_block_restore==2))+sum(sum(fin_block_restore==2))
        side_info_block_sec_and_fin_error_two_origion_pixel_extract = [side_info_block_sec_and_fin_error_two_origion_pixel_extract message_extract_eliminate_zero_every_sixe_ones(i)];
    end
    modify_flag_extract = message_extract_eliminate_zero_every_sixe_ones(2+32+sum(sum(sec_block_restore==2))+sum(sum(fin_block_restore==2))+1);
    if modify_flag_extract == 0
        %没有修改预测误差位置
        bits_available_extract = total_bits-2-32-sum(sum(sec_block_restore==2))-sum(sum(fin_block_restore==2))-1;
        modify_method_xy_or_map_extract = -1;
        side_info_error_modify_location_length_extract = -1;
        side_info_error_modify_location_extract = -1;
    else
        %修改了预测误差位置
        modify_method_xy_or_map_extract = message_extract_eliminate_zero_every_sixe_ones(2+32+sum(sum(sec_block_restore==2))+sum(sum(fin_block_restore==2))+2);
        side_info_error_modify_location_length_extract = uint8(zeros(1,10));
        length = 0;
        for i = 2+32+sum(sum(sec_block_restore==2))+sum(sum(fin_block_restore==2))+3:2+32+sum(sum(sec_block_restore==2))+sum(sum(fin_block_restore==2))+12
            side_info_error_modify_location_length_extract(i-2-32-sum(sum(sec_block_restore==2))-sum(sum(fin_block_restore==2))-2) = message_extract_eliminate_zero_every_sixe_ones(i);
        end
        for i = 1:10
            length = length + double(side_info_error_modify_location_length_extract(10-i+1))*(2^(i-1));
        end
        side_info_error_modify_location_extract = uint8(zeros(1,length));
        for i = 2+32+sum(sum(sec_block_restore==2))+sum(sum(fin_block_restore==2))+12+1:2+32+sum(sum(sec_block_restore==2))+sum(sum(fin_block_restore==2))+12+length
            side_info_error_modify_location_extract(i-2-32-sum(sum(sec_block_restore==2))-sum(sum(fin_block_restore==2))-12) = message_extract_eliminate_zero_every_sixe_ones(i);
        end
        bits_available_extract = total_bits-2-32-sum(sum(sec_block_restore==2))-sum(sum(fin_block_restore==2))-12-length;
    end
end


end

