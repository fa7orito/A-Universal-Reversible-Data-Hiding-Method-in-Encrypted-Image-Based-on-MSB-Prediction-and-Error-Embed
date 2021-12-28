function error_location_marked_embedded = calculate_error_location_map_marked_embedded(error_location_marked,block_flag,message,block_size)
%input: the marked error location map error_location_marked, the message to
%be embeded message,the size of block block_size
%output: the embeded error_location_marked error_location_marked_embeded
[m,n] = size(error_location_marked);
[~,l] = size(message);
blocks = reshape(error_location_marked.',block_size,m*n/block_size).';
message_blocks = reshape(message.',block_size,l/block_size).';
blocks_embedded = blocks;
message_blocks_row = 0;
for i = 2:m*n/block_size
    if block_flag(i) == 0
        message_blocks_row = message_blocks_row+1;
        for j = 1:block_size
            blocks_embedded(i,j) = message_blocks(message_blocks_row,j);
        end
    end
end
error_location_marked_embedded = reshape(blocks_embedded.',m,n).';
end

