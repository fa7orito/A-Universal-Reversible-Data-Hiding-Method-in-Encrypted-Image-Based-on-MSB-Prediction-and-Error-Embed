function [blocks_extract,block_flag_extract] = extract_find_flag(MSB_extract,block_size)
%input: marked & encrypted image MSB_extract, size of block block_size
%output: extracted flag blocks in image block_flag_extract
[m,n] = size(MSB_extract);
blocks_extract = reshape(MSB_extract.',block_size,m*n/block_size).';
block_flag_extract = uint8(zeros(1,m*n/block_size));
for i = 1:m*n/block_size
    flag = uint8(zeros(1,block_size));
    for j = 1:block_size
        flag(j) = blocks_extract(i,j);
    end
    if isequal(flag,[1 1 1 1 1 1 1 1])
        block_flag_extract(i) = 2;
    elseif isequal(flag,[1 1 1 1 1 1 1 0])
        block_flag_extract(i) = 4;
    end
end
end

