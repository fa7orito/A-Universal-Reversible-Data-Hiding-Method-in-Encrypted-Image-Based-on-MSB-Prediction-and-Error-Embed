clear;
clc;


num=[0.2 0.4 0.6 0.8 1];

propx=[0 0.2 0.4 0.6 0.8 0.8572];
propy=[80 80 80 80 80 80]; 

% original
% caox=[0.01 0.08 0.25 0.48 0.65 0.95];
% caoy=[62.5 56 49 44 41 33];
% new
caox=[0.05	0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
caoy=[62.4867	57.6506	50.9632	49.3500	46.8540	44.1122	41.9824	39.9072	37.7479	35.4134	33.3929];

cpex=[0.16 0.47 0.99];
cpey=[54 49 46];

epex=[0 0.2 0.4 0.6 0.8 0.8915];
epey=[44.5180 44.5180 44.5180 44.5180 44.5180 44.5180]; 

% original
% qinx=[0.1 0.25 0.4 0.45 0.49];
% qiny=[46.7 46 41.5 41 38];

% new
chenx=[0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
cheny=[61.1322	58.0851	56.3910	55.1367	54.1350	53.3568	52.6817	52.1137	51.5891	51.1302];

% new
xiongx=[0.005	0.02	0.05	0.1	0.15	0.2	0.25	0.3	0.35	0.4	0.5];
xiongy=[70.0040563485697	66.8495425774939	54.3216945035831	49.7381935491878	46.3495502480096	43.7992541234287	41.9252277856696	39.7682189995805	38.0470874417080	36.7094278170654	33.9053624489152];

kex=[0.0642509460449219 0.0800628662109375 0.167205810546875 0.20416259765625 0.2971153259277344 0.4380569458007813 0.5];
key=[63.1004 60.6655 52.5652 50.3489 45.6201 42.8519 33.4095];

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