function message_r = inverse_preprocess_message2(message)
%delete 1 zero every 6 ones 
[~,origin_length] = size(message);
message_r = uint8(zeros(1,0));
[message_flag] = find_six_ones_and_one_zero(message);
for i = 1:origin_length
    if message_flag(i) == 0
        message_r = [message_r message(i)];
    else
        message_r = message_r;
    end
end

end

