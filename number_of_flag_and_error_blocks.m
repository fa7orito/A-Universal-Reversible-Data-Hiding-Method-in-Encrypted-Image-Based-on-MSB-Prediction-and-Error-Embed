clc
clear
% load measurement_BOSS_database
load measurement_BOWS2_database
max_flag_error_blocks = 32768-1-Measurement(1).total_bits/8;
for i = 1:length(Measurement)
    max_flag_error_blocks = max(max_flag_error_blocks,32768-1-Measurement(i).total_bits/8);
end
for i = 1:length(Measurement)
    if max_flag_error_blocks == 32768-1-Measurement(i).total_bits/8
        fprintf('%s %d ',Measurement(i).filename,max_flag_error_blocks);
    end
end
sum = 0;
flag_error_blocks = zeros(0);
for i = 1:length(Measurement)
    sum = sum + (32768-1-Measurement(i).total_bits/8);
    flag_error_blocks = [flag_error_blocks, 32768-1-Measurement(i).total_bits/8];
end
average = sum/length(Measurement);
fprintf('average %d \n',average);
