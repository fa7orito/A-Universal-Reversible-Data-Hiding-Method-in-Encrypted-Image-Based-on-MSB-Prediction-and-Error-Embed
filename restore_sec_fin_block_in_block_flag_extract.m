function [block_flag_restore_sec_fin,sec_block_restore,fin_block_restore] = restore_sec_fin_block_in_block_flag_extract(block_flag_extract,side_info_block_sec_extract,side_info_block_fin_extract,side_info_block_sec_error_flag_extract,side_info_block_fin_error_flag_extract)
%RESTORE_SEC_FIN_BLOCK_IN_BLOCK_FLAG_EXTRACT 此处显示有关此函数的摘要
%   此处显示详细说明
if side_info_block_sec_error_flag_extract == 0 && side_info_block_fin_error_flag_extract == 0
    sec_block_restore = uint8(zeros(1,0));
    fin_block_restore = uint8(zeros(1,0));
    block_flag_restore_sec_fin = block_flag_extract;
elseif side_info_block_sec_error_flag_extract == 1 && side_info_block_fin_error_flag_extract == 0
    sec_block_restore = uint8(zeros(1,8));
    fin_block_restore = uint8(zeros(1,0));
    for i = 1:8
        temp = [side_info_block_sec_extract(i*2-1),side_info_block_sec_extract(i*2)];
        if isequal(temp,[0 0])
            sec_block_restore(i) = 0;
        elseif isequal(temp,[0 1])
            sec_block_restore(i) = 1;
        elseif isequal(temp,[1 0])
            sec_block_restore(i) = 2;
        end
    end
    %根据sec_block_restore,fin_block_restore复原block_flag_extract
    block_flag_restore_sec_fin = block_flag_extract;
    block_flag_restore_sec_fin(2) = 1;
elseif side_info_block_sec_error_flag_extract == 0 && side_info_block_fin_error_flag_extract == 1
    sec_block_restore = uint8(zeros(1,0));
    fin_block_restore = uint8(zeros(1,8));
    for i = 1:8
        temp = [side_info_block_fin_extract(i*2-1),side_info_block_fin_extract(i*2)];
        if isequal(temp,[0 0])
            fin_block_restore(i) = 0;
        elseif isequal(temp,[0 1])
            fin_block_restore(i) = 1;
        elseif isequal(temp,[1 0])
            fin_block_restore(i) = 2;
        end
    end
    %根据sec_block_restore,fin_block_restore复原block_flag_extract
    block_flag_restore_sec_fin = block_flag_extract;
    block_flag_restore_sec_fin(32768) = 1;
else
    sec_block_restore = uint8(zeros(1,8));
    fin_block_restore = uint8(zeros(1,8));
    for i = 1:8
        temp = [side_info_block_sec_extract(i*2-1),side_info_block_sec_extract(i*2)];
        if isequal(temp,[0 0])
            sec_block_restore(i) = 0;
        elseif isequal(temp,[0 1])
            sec_block_restore(i) = 1;
        elseif isequal(temp,[1 0])
            sec_block_restore(i) = 2;
        end
    end
    for i = 1:8
        temp = [side_info_block_fin_extract(i*2-1),side_info_block_fin_extract(i*2)];
        if isequal(temp,[0 0])
            fin_block_restore(i) = 0;
        elseif isequal(temp,[0 1])
            fin_block_restore(i) = 1;
        elseif isequal(temp,[1 0])
            fin_block_restore(i) = 2;
        end
    end
    %根据sec_block_restore,fin_block_restore复原block_flag_extract
    block_flag_restore_sec_fin = block_flag_extract;
    block_flag_restore_sec_fin(2) = 1;
    block_flag_restore_sec_fin(32768) = 1;
end

end

