function [error_location_marked,side_info_block_sec_error_flag,side_info_block_fin_error_flag,block_sec,block_fin,side_info_block_sec,side_info_block_fin,side_info_block_sec_and_fin_error_two_origion_pixel,bits_available,blocks,blocks_marked,block_flag] = calculate_error_location_map_marked2(encrypted_img,error_location,block_size,side_info_error_modify_location)
%input: error location map error_location, the size of block block_size
%output: the error location marked map error_location_marked, the total bits can be embedded bits_available
[m,n] = size(error_location);
blocks = reshape(error_location.',block_size,m*n/block_size).';
blocks_encrypted_img = reshape(encrypted_img.',block_size,m*n/block_size).';
side_info_block_sec = uint8(zeros(1,block_size*2));
side_info_block_fin = uint8(zeros(1,block_size*2));
%   无预测误差的块用0标记，含有预测误差的块用1标记，只用了一次的标记块用2标记，
%用了两次的标记块用4标记
%   标记存在预测误差的块，第1块只加密，第2块和最后块的预测误差标记作为副信息保
%存，把第2块和最后一块的标记置0
block_error = uint8(zeros(1,m*n/block_size));
for i = 1:m*n/block_size
    for j = 1:block_size
        if blocks(i,j)==1||blocks(i,j)==2
            block_error(i) = 1;
        end
    end
end
block_error(1) = 0;
%把第2块和最后一块的块内信息保存，并且如果原始标记是1的话变为0
for k = 1:block_size
    if blocks(2,k) == 0
        side_info_block_sec(k*2-1) = 0;
        side_info_block_sec(k*2) = 0;
    elseif blocks(2,k) == 1
        side_info_block_sec(k*2-1) = 0;
        side_info_block_sec(k*2) = 1;
    elseif blocks(2,k) == 2
        side_info_block_sec(k*2-1) = 1;
        side_info_block_sec(k*2) = 0;
    end
end
for k = 1:block_size
    if blocks(m*n/block_size,k) == 0
        side_info_block_fin(k*2-1) = 0;
        side_info_block_fin(k*2) = 0;
    elseif blocks(m*n/block_size,k) == 1
        side_info_block_fin(k*2-1) = 0;
        side_info_block_fin(k*2) = 1;
    elseif blocks(m*n/block_size,k) == 2
        side_info_block_fin(k*2-1) = 1;
        side_info_block_fin(k*2) = 0;
    end
end
%标记第一块和最后一块的错误信息
block_sec = uint8(zeros(1,block_size));
block_fin = uint8(zeros(1,block_size));
for i = 1:block_size
    block_sec(i) = blocks(2,i);
    block_fin(i) = blocks(m*n/block_size,i);
end
side_info_block_sec_error_flag = block_error(2);
side_info_block_fin_error_flag = block_error(m*n/block_size);
%需要保存的第二块和最后一块的错误标记为2位置的加密后的像素
side_info_block_sec_and_fin_error_two_origion_pixel = uint8(zeros(1,0));
for i = 1:block_size
    if block_sec(i) == 2
        side_info_block_sec_and_fin_error_two_origion_pixel = [side_info_block_sec_and_fin_error_two_origion_pixel uint8(floor(double(blocks_encrypted_img(2,i))/128))];
    end
end
for i = 1:block_size
    if block_fin(i) == 2
        side_info_block_sec_and_fin_error_two_origion_pixel = [side_info_block_sec_and_fin_error_two_origion_pixel uint8(floor(double(blocks_encrypted_img(m*n/block_size,i))/128))];
    end
end
%如果第二块和最后一块有错误，块内全部置0
block_error(2) = 0;
block_error(m*n/block_size) = 0;
%标记flag块
block_flag = block_error;
for i = 2:m*n/block_size-1
    flag = [block_error(i),block_error(i+1)];
    if isequal(flag,[0 1]) 
        block_flag(i) = block_flag(i)+2;
    elseif isequal(flag,[1 0]) 
        block_flag(i+1) = block_flag(i+1)+2;
    end
end
%按照block_flag来标记
blocks_marked = blocks;
for i = 2:m*n/block_size
    if block_flag(i) == 2
        for j = 1:block_size
            blocks_marked(i,j) = 1;
        end
    elseif block_flag(i) == 4 
        for j = 1:block_size-1
            blocks_marked(i,j) = 1;
        end
        blocks_marked(i,block_size) = 0;
    end
end
error_location_marked = reshape(blocks_marked.',m,n).';
%计算可嵌入信息总量，不算side_info
bits_available = 0;
for i = 2:m*n/block_size
   if  block_flag(i) == 0
       bits_available = bits_available+block_size;
   end
end
[~,length] = size(side_info_error_modify_location);
if side_info_block_sec_error_flag == 0 && side_info_block_fin_error_flag == 0
    bits_available = bits_available-2-12-length;
elseif side_info_block_sec_error_flag == 1 && side_info_block_fin_error_flag == 0
    bits_available = bits_available-2-16-sum(sum(block_sec==2))-12-length;
elseif side_info_block_sec_error_flag == 0 && side_info_block_fin_error_flag == 1
    bits_available = bits_available-2-16-sum(sum(block_fin==2))-12-length;
else
    bits_available = bits_available-2-32-sum(sum(block_sec==2))-sum(sum(block_fin==2))-12-length;
end

end

