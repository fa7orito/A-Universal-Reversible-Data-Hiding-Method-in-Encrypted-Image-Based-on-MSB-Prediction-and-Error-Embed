clear;
clc;


num=[0.2 0.4 0.6 0.8 1];

propx=[0 0.2 0.4 0.6 0.8 0.9860];
propy=[80 80 80 80 80 80]; 

% original
% caox=[0.15 0.3 0.45 0.6 0.75 0.9];
% caoy=[58 54 52 49 46 42.5];
% new
caox=[0.06	0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
caoy=[76.26	65.81	58.83	55.19	53.17	51.56	49.96	48.50	46.18	43.97	42.47];


cpex=[0.16 0.47 0.99];
cpey=[70 62 59];

epex=[0 0.2 0.4 0.6 0.8 0.9994];
epey=[52.9342 52.9342 52.9342 52.9342 52.9342 52.9342]; 

% original
% qinx=[0.55 0.7 0.8 0.85 0.9];
% qiny=[38 37.9 37.6 37.4 36];

% new
chenx=[0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
cheny=[61.1167	58.1407	56.3427	55.1096	54.1584	53.3666	52.7012	52.0974	51.5927	51.1392];

% new
xiongx=[0.005	0.02	0.05	0.1	0.15	0.2	0.25	0.3	0.35	0.4	0.5];
xiongy=[71.5425237753542	67.2687764654788	63.8269256959249	54.3983141998240	51.6832070781222	50.0021441397684	49.8471320438201	48.5959433414741	45.2031763435894	43.9918673951891	41.1553480298075];

kex=[0.101104736328125 0.1785659790039063 0.2447662353515625 0.279388427734375 0.3317337036132813 0.4000930786132813 0.5];
key=[61.0445 55.9208 52.1256 50.1791 47.0505 42.4764 33.2144];

% original
% plot(propx,propy,'b ^ -',caox,caoy,'g o -',cpex,cpey,'c + -',epex,epey,'m * -',qinx,qiny,'y s -','linewidth',1,'MarkerSize',13)
% new
plot(propx,propy,'b ^ -',caox,caoy,'g o -',cpex,cpey,'r x -',epex,epey,'c + -',chenx,cheny,'m * -',xiongx,xiongy,'y s -',kex,key,'k d -','linewidth',1,'MarkerSize',13)

xlabel('Embedding rate (bpp)')
ylabel('PSNR (dB)')
axis([0 1 10 80]);
set(gca,'xtick',0:0.2:1);
set(gca,'ytick',10:10:80);
set(gca,'yticklabel',{10,20,30,40,50,60,70,'¡Þ'});
set(gca,'FontSize',20,'Fontname', 'Palatino Linotype');

grid on

% original
% l1=legend('MPEE-URDH','Cao [24]','CPE-HCRDH [28]','EPE-HCRDH [28]','Qin [30]');
% new
l1=legend('MPEE-URDH','Cao [24]','CPE-HCRDH [28]','EPE-HCRDH [28]','Chen [31]','Xiong [33]','Ke [36]');
set(l1,'Fontname', 'Palatino Linotype','FontSize',10)