clear;
clc;


num=[0.2 0.4 0.6 0.8 1];

propx=[0 0.2 0.4 0.6 0.8 0.9860];
propy=[1 1 1 1 1 1]; 

caox=[0.05	0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
caoy=[0.999988202492774	0.999886583995222	0.999445032586406	0.998841526129313	0.998153620570110	0.997037870883829	0.995798341550228	0.994221183119980	0.991365921497024	0.987245741016296	0.983464288704778];

cpex=[0.16 0.47 0.99];
cpey=[0.999999963366900	0.999686570835959	0.999126056052673];

epex=[0 0.2 0.4 0.6 0.8 0.9861];
epey=[0.999893726098870 0.999893726098870 0.999893726098870 0.999893726098870 0.999893726098870 0.999893726098870]; 

chenx=[0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
cheny=[0.999740391366701	0.999537550008724	0.999351487063984	0.999111784833093	0.998821399840386	0.998610005714618	0.998299803365499	0.997893299969550	0.997532112049862	0.997102742073072];

xiongx=[0.005	0.02	0.05	0.1	0.15	0.2	0.25	0.3	0.35	0.4	0.5];
xiongy=[0.999963191625713	0.999899104591938	0.999736965824978	0.998663478915205	0.997642262711284	0.996566926903992	0.996354965561027	0.995246112510881	0.990465303616578	0.986363495636543	0.975452510584529];

% new
plot(propx,propy,'b ^ -',caox,caoy,'g o -',cpex,cpey,'r x -',epex,epey,'c + -',chenx,cheny,'m * -',xiongx,xiongy,'y s -','linewidth',1,'MarkerSize',13)

xlabel('Embedding rate (bpp)')
ylabel('SSIM')
% axis([0 1 0.8 1.0]);
% set(gca,'xtick',0:0.2:1);
% set(gca,'ytick',0.8:0.05:1.0);
axis([0 1 0.9 1.0]);
set(gca,'xtick',0:0.2:1);
set(gca,'ytick',0.9:0.01:1.0);
set(gca,'FontSize',20,'FontName', 'Times New Roman');
grid on

l1=legend('MPEE-URDH','Cao [24]','CPE-HCRDH [28]','EPE-HCRDH [28]','Chen [31]','Xiong [33]');
set(l1,'FontName', 'Times New Roman','FontSize',15)

