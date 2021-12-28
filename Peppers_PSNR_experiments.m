clear;
clc;


num=[0.2 0.4 0.6 0.8 1];

propx=[0 0.2 0.4 0.6 0.8 0.9734];
propy=[80 80 80 80 80 80]; 

% original
% yix=[0.005 0.02 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ];
% yiy=[62.28 58.57 54.10 51.06 48.57 46.26 44.64 42.61 41.26 40.10 ];

% new
caox=[0.05	0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9];
caoy=[58.3162	53.2562	49.5718	46.2461	42.8294	40.5488	38.2117	35.5177	32.9421	30.3278];

cpex=[0.16 0.47 0.99];
cpey=[59 45 40.8865];

epex=[0 0.2 0.4 0.6 0.8 0.9985];
epey=[51.9571 51.9571 51.9571 51.9571 51.9571 51.9571]; 

% original
% chenx=[0.005 0.02 0.05 0.1 0.15 ];
% cheny=[61.56 57.29 53.7 50.82 49.04];
% new
chenx=[0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
cheny=[61.1905	58.1271	56.3753	55.1228	54.1583	53.3578	52.6936	52.1075	51.6065	51.1397];

% original
% xiongx=[0 0.02 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.5];
% xiongy=[72 67.5 55 52 50 47 45 43 42 40 38 ];
% new
xiongx=[0.005	0.02	0.05	0.1	0.15	0.2	0.25	0.3	0.35	0.4	0.5];
xiongy=[71.4811766298930	67.3455234642107	54.7606555156249	51.5705249941280	49.7516954408412	46.6293054519403	44.2031008964369	43.1793726811426	41.4042972790573	40.0768663376022	37.9957697758863];

kex=[0.0335350036621094 0.0993499755859375 0.1605644226074219 0.2156181335449219 0.3052406311035156 0.4217453002929688 0.4997024536132813];
key=[65.9745 57.5117 52.9404 49.7460 45.4989 40.5025 34.0715];

% original
% plot(propx,propy,'b ^ -',yix,yiy,'r x -',cpex,cpey,'c + -',epex,epey,'m * -',chenx,cheny,'k d -',xiongx,xiongy,'m > -','linewidth',1,'MarkerSize',13)
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
% l1=legend('MPEE-URDH','Yi [27]','CPE-HCRDH [28]','EPE-HCRDH [28]','Chen [31]','Xiong [33]');
% new
l1=legend('MPEE-URDH','Cao [24]','CPE-HCRDH [28]','EPE-HCRDH [28]','Chen [31]','Xiong [33]','Ke [36]');
set(l1,'Fontname', 'Palatino Linotype','FontSize',10)