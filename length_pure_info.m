clc
clear
load measurement_BOSS_database
min_length_pure_info = Measurement(1).pure_bits;
for i = 1:length(Measurement)
    min_length_pure_info = max(min_length_pure_info,Measurement(i).pure_bits);
end
count = 0;
for i = 1:length(Measurement)
    if min_length_pure_info == Measurement(i).pure_bits
        count = count + 1;
        fprintf('%s %d ',Measurement(i).filename,min_length_pure_info);
    end
end
sum = 0;
for i = 1:length(Measurement)
    sum = sum + Measurement(i).pure_bits;
end
average = sum/length(Measurement);
fprintf('average %d \n',average);

min_length_pure_info = Measurement(1).pure_bits;
for i = 1:length(Measurement)
    min_length_pure_info = min(min_length_pure_info,Measurement(i).pure_bits);
end
for i = 1:length(Measurement)
    if min_length_pure_info == Measurement(i).pure_bits
        fprintf('%s %d ',Measurement(i).filename,min_length_pure_info);
    end
end
sum = 0;
for i = 1:length(Measurement)
    sum = sum + Measurement(i).pure_bits;
end
average = sum/length(Measurement);
fprintf('average %d \n',average);