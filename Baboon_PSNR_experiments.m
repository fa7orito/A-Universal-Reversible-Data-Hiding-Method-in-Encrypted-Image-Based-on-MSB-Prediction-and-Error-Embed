clear;
clc;


num=[0.2 0.4 0.6 0.8 1];

propx=[0 0.2 0.4 0.6 0.8 0.8357];
propy=[80 80 80 80 80 80]; 

% new
caox=[0.05	0.1	0.2	0.3	0.4	0.5	0.6	];
caoy=[50.9074	47.2782	41.0740	36.9002	34.0231	30.5356	28.0895	];

% original
% yix=[0.005 0.02 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ];
% yiy=[59.87 55.02 50.55 45.23 41.62 38.75 36.10 34.31 32.64 31.00 ];

cpex=[0.16 0.47 0.99];
cpey=[52 41 32.0087];

epex=[0 0.2 0.4 0.6 0.8 0.8891];
epey=[40.2729 40.2729 40.2729 40.2729 40.2729 40.2729]; 

% original
% chenx=[0.005 0.02 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 ];
% cheny=[57.19 52.99 49.38 44.10 40.86 38.35 35.90 34.14 32.50 31.01];

% new 
chenx=[0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
cheny=[61.1468	58.1525	56.3971	55.1452	54.1270	53.3677	52.6779	52.1181	51.5908	51.1507];

% original
% xiongx=[0 0.02 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4];
% xiongy=[71 54.5 50 46 41 38 36.5 34 32.5 31.5];

% new
xiongx=[0.005	0.02	0.05	0.1	0.15	0.2	0.25	0.3	0.35	0.4	0.5];
xiongy=[71.5863553819164	54.2520965115520	49.6272419444827	44.6695332380543	40.8227213303229	38.2753303117465	36.1674183039997	34.1786294379199	32.6829735210253	31.0685881796410	29.8418585121032];

kex=[0.0160598754882813 0.04754638671875 0.0789718627929688 0.1089210510253906 0.1622085571289063 0.2643051147460938 0.499908447265625];
key=[69.0304 60.7332 55.9498 52.5559 47.9412 41.3894 29.2830];

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