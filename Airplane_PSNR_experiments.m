clear;
clc;


num=[0.2 0.4 0.6 0.8 1];

propx=[0 0.2 0.4 0.6 0.8 0.9848];
propy=[80 80 80 80 80 80]; 

% orignial 
% caox=[0.15 0.35 0.55 0.85];
% caoy=[56 51 47.5 42];

% new
caox=[0.05	0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
caoy=[62.8527 59.7102 56.1214 53.5476 51.2250 49.9455 48.4424 46.3294 44.5734 42.9719 40.7975];

% original
% yix=[0.005 0.02 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.5];
% yiy=[67.91 63.58 59.27 55.87 53.78 52.43 51.15 49.29 47.61 46.38 43.72];

cpex=[0.16 0.47 0.99];
cpey=[62 61 58];

epex=[0 0.2 0.4 0.6 0.8 0.9992];
epey=[49.5074 49.5074 49.5074 49.5074 49.5074 49.5074]; 

% original
% qinx=[0.25 0.5 0.6 0.7 0.75];
% qiny=[51 48 45 43 42];

chenx=[0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
cheny=[61.1062	58.1475	56.3587	55.1105	54.1501	53.3788	52.6808	52.1070	51.6070	51.1444];

xiongx=[0.005	0.02	0.05	0.1	0.15	0.2	0.25	0.3	0.35	0.4	0.5];
xiongy=[71.6269267113750	67.3718738409317	63.7895733847500	54.4405355022081	51.6768675865653	49.9703214118622	49.8021082670843	48.5333324105447	46.5089825328934	44.3422392732464	42.4387806768101];

kex=[0.0761642456054688 0.1936492919921875 0.2712783813476563 0.32501220703125 0.3843154907226563 0.4156608581542969 0.4998626708984375];
key=[62.3590 54.8316 51.2680 48.9055 46.1582 40.4472 35.3958];

% original
% plot(propx,propy,'b ^ -',caox,caoy,'g o -',yix,yiy,'r x -',cpex,cpey,'c + -',epex,epey,'m * -',qinx,qiny,'y s -',chenx,cheny,'k d -',xiongx,xiongy,'m > -','linewidth',1,'MarkerSize',13)

% new
plot(propx,propy,'b ^ -',caox,caoy,'g o -',cpex,cpey,'r x -',epex,epey,'c + -',chenx,cheny,'m * -',xiongx,xiongy,'y s -',kex,key,'k d -','linewidth',1,'MarkerSize',13)

xlabel('Embedding rate (bpp)')
ylabel('PSNR (dB)')
axis([0 1 10 80]);
set(gca,'xtick',0:0.2:1);
set(gca,'ytick',10:10:80);
set(gca,'yticklabel',{10,20,30,40,50,60,70,'¡Þ'});
set(gca,'FontSize',20,'FontName', 'Palatino Linotype');
% 'FontWeight','Bold'
grid on

% original
% l1=legend('MPEE-URDH','Cao 2015 [24]','Yi 2018 [27]','CPE-HCRDH 2018 [28]','EPE-HCRDH 2018 [28]','Qin 2018 [30]','Chen 2019 [31]','Xiong 2019 [33]');
% new
l1=legend('MPEE-URDH','Cao [24]','CPE-HCRDH [28]','EPE-HCRDH [28]','Chen [31]','Xiong [33]','Ke [36]');
set(l1,'FontName', 'Palatino Linotype','FontSize',10)


