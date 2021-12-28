function [message_flag] = find_six_ones(message)
%Ѱ��message���Ƿ���������6��1�������ص�6��1��λ��
[~,length] = size(message);
message_flag = uint8(zeros(1,length));
for i = 1:length-6+1
    temp = uint8(zeros(1,6));
    for j = 1:6
        temp(j) = message(i+j-1);
    end
    if isequal(temp,[1 1 1 1 1 1])
        message_flag(i+5) = 1;
    end
end
for i = 1:length-5+1
    if message_flag(i) == 1
        for j = 1:5
            message_flag(i+j) = 0;
        end
    end
end

end

