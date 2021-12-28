function block_flag_extract = extract_blocks_flag(block_flag)
%input: flag marked blocks block_flag
%output: error block and message block marked blocks block_flag_extract
block_flag_extract = block_flag;
[~,length] = size(block_flag);
flag_two = zeros(1,sum(sum(block_flag==2)));
k = 1;
for i = 1:length
   if block_flag(i) == 2
       flag_two(k) = i;
       k = k+1;
   end
end
flag_two = reshape(flag_two.',2,sum(sum(block_flag==2))/2).';
for i = 1:sum(sum(block_flag==2))/2
    for j = flag_two(i,1):flag_two(i,2)-1
        temp = [block_flag_extract(j),block_flag_extract(j+1)];
        if isequal(temp,[2 0]) || isequal(temp,[4 0]) || isequal(temp,[1 0])
            block_flag_extract(j+1) = 1;
        end
    end
end
end

