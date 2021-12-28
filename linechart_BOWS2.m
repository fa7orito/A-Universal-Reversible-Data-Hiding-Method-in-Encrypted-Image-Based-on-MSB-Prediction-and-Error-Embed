clear;
clc;

load measurement_BOWS2_database
k = 10000;
image_sequence = zeros(1,k);
sideinfo_bits_BOWS2 = zeros(1,k);
secretinfo_bits_BOWS2 = zeros(1,k);

for i  = 1 :k
    image_sequence(i) = i;
    sideinfo_bits_BOWS2(i) = Measurement(i).sideinfo_bits/262144;
    secretinfo_bits_BOWS2(i) = Measurement(i).pure_bits/262144;
end
%副信息
figure
plot(image_sequence,sideinfo_bits_BOWS2,'r *','MarkerSize',13)
xlabel('Image sequence')
ylabel('Size of side information(bpp)')
axis([0 10000 0 0.0045]);
set(gca,'xtick',0:2000:10000);
set(gca,'ytick',0:0.0005:0.0045);
set(gca,'FontSize',35,'FontName', 'Palatino Linotype');

%纯秘密信息
figure
plot(image_sequence,secretinfo_bits_BOWS2,'b +','MarkerSize',13)
xlabel('Image sequence')
ylabel('Size of secret message(bpp)')
axis([0 10000 0 1]);
set(gca,'xtick',0:2000:10000);
set(gca,'ytick',0:0.2:1);
set(gca,'FontSize',35,'FontName', 'Palatino Linotype');


