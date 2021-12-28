function message_r = preprocess_message(message)
%insert 1 zero every n ones 
[~,length] = size(message);
message_r = zeros(1,length);
for i = 1:length 
    if mod(i,2) ~= 0
        message_r(i) = 1;
    else
        message_r(i) = 0;
    end
end
end

