clc
clear
load Chen_BOWS2_test
sumpsnr = 0;
array = PSNRs06bpp;
for i = 1:length(array)
    if array(i) ~= Inf
        sumpsnr = sumpsnr + array(i);
    end
end
avg = sumpsnr / sum(sum(array~=Inf));
disp(avg)