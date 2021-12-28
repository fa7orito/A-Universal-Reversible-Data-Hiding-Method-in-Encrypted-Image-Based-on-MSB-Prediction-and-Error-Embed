clc
clear
load measurement_BOSS_database
max_error_numbers = Measurement(1).error_numbers;
for i = 1:length(Measurement)
    max_error_numbers = max(max_error_numbers,Measurement(i).error_numbers);
end
for i = 1:length(Measurement)
    if max_error_numbers == Measurement(i).error_numbers
        fprintf('%s %d ',Measurement(i).filename,max_error_numbers);
    end
end
sum = 0;
for i = 1:length(Measurement)
    sum = sum + Measurement(i).error_numbers;
end
average = sum/length(Measurement);
fprintf('average %d \n',average);
