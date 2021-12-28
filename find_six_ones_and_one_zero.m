function [message_flag] = find_six_ones_and_one_zero(message)
%Ѱ��message���Ƿ���������6��1��һ��0�����������0��λ��
[~,length] = size(message);
message_flag = uint8(zeros(1,length));
for i = 1:length-7+1
    temp = uint8(zeros(1,7));
    for j = 1:7
        temp(j) = message(i+j-1);
    end
    if isequal(temp,[1 1 1 1 1 1 0])
        message_flag(i+6) = 1;
    end
end
for i = 1:length-6+1
    if message_flag(i) == 1
        for j = 1:6
            message_flag(i+j) = 0;
        end
    end
end

end

