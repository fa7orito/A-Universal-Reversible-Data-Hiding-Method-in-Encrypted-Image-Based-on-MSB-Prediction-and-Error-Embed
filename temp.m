clc
clear
load measurement_EPE_BOSS_database
% PSNR_encrypted = zeros(1,length(Measurement));
% SSIM_encrypted = zeros(1,length(Measurement));
% PSNR_markedecrypted = zeros(1,length(Measurement));
% SSIM_markedecrypted = zeros(1,length(Measurement));
%
% for i = 1:length(Measurement)
%     PSNR_encrypted(i) = Measurement(i).PSNR_ecrypted;
%     SSIM_encrypted(i) = Measurement(i).SSIM_ecrypted;
%     PSNR_markedecrypted(i) = Measurement(i).PSNR_markedecrypted;
%     SSIM_markedecrypted(i) = Measurement(i).SSIM_markedecrypted;
% end

% load measurement_BOSS_error
%
% for i = 1:length(Measurement)
%     if Measurement(i).length_xy_or_map > 1023
%          fprintf("%s \n",Measurement(i).filename);
%     end
% end


sum = 0;
% for i = 1:length(Measurement)
%     if Measurement(i).PSNR_img_reconstructed ~= Inf
%         sum = sum + Measurement(i).PSNR_img_reconstructed;
%     else
%         sum = sum + 100;
%     end
% end
% avg = sum / length(Measurement);

% for i = 1:length(Measurement)
%     sum = sum + Measurement(i).SSIM_img_reconstructed;
% end
% avg = sum / length(Measurement);

for i = 1:length(Measurement)
    sum = sum + Measurement(i).Payload;
end
avg = (sum / length(Measurement)) / 262144;