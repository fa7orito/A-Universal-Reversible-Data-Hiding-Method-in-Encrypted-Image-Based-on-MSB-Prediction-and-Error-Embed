clc
clear
load measurement_BOSS_database
max_length_side_info = Measurement(1).sideinfo_bits;
for i = 1:length(Measurement)
    max_length_side_info = max(max_length_side_info,Measurement(i).sideinfo_bits);
end
for i = 1:length(Measurement)
    if max_length_side_info == Measurement(i).sideinfo_bits
        fprintf('%s %d ',Measurement(i).filename,max_length_side_info);
    end
end
sum = 0;
for i = 1:length(Measurement)
    sum = sum + Measurement(i).sideinfo_bits;
end
average = sum/length(Measurement);
fprintf('average %d \n',average);
