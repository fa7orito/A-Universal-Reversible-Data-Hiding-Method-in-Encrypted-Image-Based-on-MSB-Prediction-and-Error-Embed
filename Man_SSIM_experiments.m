clear;
clc;


num=[0.2 0.4 0.6 0.8 1];

propx=[0 0.2 0.4 0.6 0.8 0.8572];
propy=[1 1 1 1 1 1]; 

caox=[0.05	0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9 1.0];
caoy=[0.999772188339990	0.999269669504001	0.996989975419555	0.995279205203942	0.992303364685181	0.986507878521742	0.979503500608014	0.970065474614867	0.955059557487299	0.931080330763109	0.900323479702698];

cpex=[0.16 0.47 0.99];
cpey=[0.999953611967752	0.999536639446643	0.997862650156381];

epex=[0 0.2 0.4 0.6 0.8 0.8572];
epey=[0.999249730538942 0.999249730538942 0.999249730538942 0.999249730538942 0.999249730538942 0.999249730538942]; 

chenx=[0.1	0.2	0.3	0.4	0.5	0.6	0.7	0.8	0.9	1.0];
cheny=[0.999824634854290	0.999608899389583	0.999358163964714	0.999140989605777	0.998930949317773	0.998620744505632	0.998376685290675	0.998210189185004	0.997952903035430	0.997682481713718];

xiongx=[0.005	0.02	0.05	0.1	0.15	0.2	0.25	0.3	0.35	0.4	0.5];
xiongy=[0.999972419109913	0.999915841624301	0.998921268179987	0.996895242173934	0.993236804129059	0.989097850238011	0.983432711518817	0.974154288745887	0.965798350075989	0.954174991730629	0.922535686974214];

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
set(l1,'FontName', 'Times New Roman','FontSize',13)


