function [error_location,error_modify_location_map,modify_flag] = error_location_modify(error_location,error_location_restore_error_two)
%ERROR_LOCATION_MODIFY 此处显示有关此函数的摘要
%   此处显示详细说明
[m,n] = size(error_location);
error_modify_location_map = uint8(zeros(m,n));
error_modify_location_map = reshape(error_modify_location_map.',8,m*n/8).';
%计算预测误差在一个块中有没有连续的8个1或者7个1
error_location = reshape(error_location.',8,m*n/8).';
error_location_restore_error_two = reshape(error_location_restore_error_two.',8,m*n/8).';
for i = 1:m*n/8
    error = uint8(zeros(1,8));
    for j = 1:8
        error(j) = error_location_restore_error_two(i,j);
    end
    if isequal(error,[1 1 1 1 1 1 1 1]) || isequal(error,[1 1 1 1 1 1 1 0]) 
        %把预测误差块的第一位修改为0
        error_location(i,1) = 0;
        %把修改的位置标记在error_modify_location_map
        error_modify_location_map(i,1) = 1;
    end
end
error_location = reshape(error_location.',m,n).';
error_modify_location_map = reshape(error_modify_location_map.',m,n).';
if sum(sum(error_modify_location_map==1)) ~= 0
    modify_flag = 1;
else
    modify_flag = 0;
end

end

