clear;
clc;


num=[0.2 0.4 0.6 0.8 1];

propx=[0 0.2 0.4 0.6 0.8 0.9937];
propy=[80 80 80 80 80 80]; 

% original
% caox=[0.01 0.1 0.25 0.48 0.65 0.75];
% caoy=[62.6 52 47 42.5 38 36 ];
% new
caox=[0.05	0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8];
caoy=[58.3824	54.3289	49.8000	47.9150	45.2296	42.7565	41.0009	39.3728	37.3755];

% original
% yix=[0.005 0.02 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.5];
% yiy=[64.89 58.78 55.93 52.71 50.31 48.45 46.27 44.89 43.63 42.30 39.86];

cpex=[0.18 0.5 1];
cpey=[58 51 48];

epex=[0 0.2 0.4 0.6 0.8 0.9998];
epey=[55.4008 55.4008 55.4008 55.4008 55.4008 55.4008]; 

% original
% qinx=[0.01 0.2 0.4 0.45 0.49 ];
% qiny=[48 46 44.5 42 41.5 ];

% original
% chenx=[0.005 0.02 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.5];
% cheny=[62.18 57.87 54.32 51.49 49.75 48.13 45.81 44.32 43.12 41.74 39.65 ];
% new
chenx=[0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
cheny=[61.1345	58.1119	56.3902	55.1063	54.1622	53.3452	52.6929	52.1015	51.6083	51.1387];

% original
% xiongx=[0 0.015 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.5];
% xiongy=[72.5 66 55 52 51 48 46 44 43 41 38];
% new
xiongx=[0.005	0.02	0.05	0.1	0.15	0.2	0.25	0.3	0.35	0.4	0.5];
xiongy=[71.4454907691304	67.3372353990635	63.7731424101849	54.8878521745989	54.4026653560592	51.7733287969899	51.5369306128348	50.0585884646473	48.9448661481498	46.9993959345566	44.6221193681685];

kex=[0.0436172485351563 0.122467041015625 0.191619873046875 0.2491111755371094 0.3303718566894531 0.4203605651855469 0.5];
key=[64.7369 56.6637 52.2932 49.3394 45.6073 42.1171 33.6360];

% original
% plot(propx,propy,'b ^ -',caox,caoy,'g o -',yix,yiy,'r x -',cpex,cpey,'c + -',epex,epey,'m * -',qinx,qiny,'y s -',chenx,cheny,'k d -',xiongx,xiongy,'m > -','linewidth',1,'MarkerSize',13)
% new
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
% l1=legend('MPEE-URDH','Cao [24]','Yi [27]','CPE-HCRDH [28]','EPE-HCRDH [28]','Qin [30]','Chen [31]','Xiong [33]');
% new
l1=legend('MPEE-URDH','Cao [24]','CPE-HCRDH [28]','EPE-HCRDH [28]','Chen [31]','Xiong [33]','Ke [36]');
set(l1,'Fontname', 'Palatino Linotype','FontSize',10)