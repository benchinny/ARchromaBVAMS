
%PPR_LCA 220304



cls
x=[468 533 616]; 
%NHI
load('S10007_LCA_LeftACL0_2105261047.mat', 'a11', 'a12')
errorbar(x-3, fliplr(a11(:,1)')-a11(2,1), fliplr(a12(:,1)'), '<b')
hold on

%MSB
load('S10004_LCA_LeftACL0_2104061444.mat', 'a11', 'a12')
errorbar(x-2, fliplr(a11(:,1)')-a11(2,1), fliplr(a12(:,1)'), '<g')
hold on

%AJR
load('S10003Left_LCA_ACL0_2112071212.mat', 'a11', 'a12')
errorbar(x-1, fliplr(a11(:,1)')-a11(2,1), fliplr(a12(:,1)'), '<r')
hold on

%HaniFarid
load('S1001V5Left_LCA_ACL0_2202151638.mat')
errorbar(x, fliplr(LCAp.Full.p2(:,1)')-LCAp.Full.p2(2,1), fliplr(LCAp.Full.p3(:,1)'), '<m')
hold on

%BenBackus
load('S1001V5Left_LCA_ACL0_2202161628.mat')
errorbar(x+1, fliplr(LCAp.Full.p2(:,1)')-LCAp.Full.p2(2,1), fliplr(LCAp.Full.p3(:,1)'), '<c')
hold on

%FabioFeroldi
load('S1001V5Left_LCA_ACL0_2202251545.mat')
errorbar(x+2, fliplr(LCAp.Full.p2(:,1)')-LCAp.Full.p2(2,1), fliplr(LCAp.Full.p3(:,1)'), '<', 'Color', [237 125 49]./255)
hold on

%MaxGreen
load('S1001V5Left_LCA_ACL0_2203021544.mat')
errorbar(x+3, fliplr(LCAp.Full.p2(:,1)')-LCAp.Full.p2(2,1), fliplr(LCAp.Full.p3(:,1)'), '<', 'Color', [112 173 71]./255)
hold on

x0=[460:620];
% y0=1.5+0.005./((x0./1000).^2);
y0=1.6091-6.7094E5./((x0).^2)+5.5533E10./((x0).^4)-5.6E15./((x0).^6);

plot(x0,y0-y0(74), 'k')

legend('NHI', 'MSB', 'AJR', 'HF', 'BB', 'FF', 'MG', 'Cauchy eqn')
xlabel('Wavelength (nm)')
ylabel('Chromatic Difference of Refraction (D)')
title('Left Eye LCA')


%Right eye
figure; 
%NHI
load('S10007Right_LCA_ACL0_2107081210.mat', 'a11', 'a12')
errorbar(x-3, fliplr(a11(:,2)')-a11(2,2), fliplr(a12(:,2)'), '>b')
hold on

%MSB
load('S10004_LCA_RightACL0_2105191352.mat', 'a11', 'a12')
errorbar(x-2, fliplr(a11(:,2)')-a11(2,2), fliplr(a12(:,2)'), '>g')
hold on

%AJR
load('S10003Right_LCA_ACL0_2112071148.mat', 'a11', 'a12')
errorbar(x-1, fliplr(a11(:,2)')-a11(2,2), fliplr(a12(:,2)'), '>r')

%HaniFarid
load('S1001V5Right_LCA_ACL0_2202151625.mat')
errorbar(x, fliplr(LCAp.Full.p2(:,2)')-LCAp.Full.p2(2,2), fliplr(LCAp.Full.p3(:,2)'), '>m')
hold on


%BenBackus
load('S1001V5Right_LCA_ACL0_2202161602.mat')
errorbar(x+1, fliplr(LCAp.Full.p2(:,2)')-LCAp.Full.p2(2,2), fliplr(LCAp.Full.p3(:,2)'), '>c')
hold on


%FabioFeroldi
load('S1001V5Right_LCA_ACL0_2202251541.mat')
errorbar(x+2, fliplr(LCAp.Full.p2(:,2)')-LCAp.Full.p2(2,2), fliplr(LCAp.Full.p3(:,2)'), '>', 'Color', [237 125 49]./255)
hold on

%MaxGreen
load('S1001V5Right_LCA_ACL0_2203021534.mat')
errorbar(x+3, fliplr(LCAp.Full.p2(:,2)')-LCAp.Full.p2(2,2), fliplr(LCAp.Full.p3(:,2)'), '>', 'Color', [112 173 71]./255)
hold on


x0=[460:620];
% y0=1.5+0.005./((x0./1000).^2);
y0=1.6091-6.7094E5./((x0).^2)+5.5533E10./((x0).^4)-5.6E15./((x0).^6);

plot(x0,y0-y0(74), 'k')

legend('NHI', 'MSB', 'AJR', 'HF', 'BB', 'FF', 'MG', 'Cauchy eqn')
xlabel('Wavelength (nm)')
ylabel('Chromatic Difference of Refraction (D)')
title('Right Eye LCA')






%binocular
cls
x=[468 533 616]; 
%NHI
load('S10007_LCA_LeftACL0_2105261047.mat', 'a11', 'a12')
errorbar(x, fliplr(a11(:,1)')-a11(2,1), fliplr(a12(:,1)'), '<b')
hold on
load('S10007Right_LCA_ACL0_2107081210.mat', 'a11', 'a12')
errorbar(x, fliplr(a11(:,2)')-a11(2,2), fliplr(a12(:,2)'), '>b')
hold on

%MSB
load('S10004_LCA_LeftACL0_2104061444.mat', 'a11', 'a12')
errorbar(x, fliplr(a11(:,1)')-a11(2,1), fliplr(a12(:,1)'), '<g')
hold on
load('S10004_LCA_RightACL0_2105191352.mat', 'a11', 'a12')
errorbar(x, fliplr(a11(:,2)')-a11(2,2), fliplr(a12(:,2)'), '>g')
hold on

%MSB
load('S10003Left_LCA_ACL0_2112071212.mat', 'a11', 'a12')
errorbar(x, fliplr(a11(:,1)')-a11(2,1), fliplr(a12(:,1)'), '<r')
hold on
load('S10003Right_LCA_ACL0_2112071148.mat', 'a11', 'a12')
errorbar(x, fliplr(a11(:,2)')-a11(2,2), fliplr(a12(:,2)'), '>r')

%HaniFarid
load('S1001V5Left_LCA_ACL0_2202151638.mat')
errorbar(x, fliplr(LCAp.Full.p2(:,1)')-LCAp.Full.p2(2,1), fliplr(LCAp.Full.p3(:,1)'), '<m')
hold on
load('S1001V5Right_LCA_ACL0_2202151625.mat')
errorbar(x, fliplr(LCAp.Full.p2(:,2)')-LCAp.Full.p2(2,2), fliplr(LCAp.Full.p3(:,2)'), '>m')
hold on


%BenBackus
load('S1001V5Left_LCA_ACL0_2202161628.mat')
errorbar(x, fliplr(LCAp.Full.p2(:,1)')-LCAp.Full.p2(2,1), fliplr(LCAp.Full.p3(:,1)'), '<c')
hold on
load('S1001V5Right_LCA_ACL0_2202161602.mat')
errorbar(x, fliplr(LCAp.Full.p2(:,2)')-LCAp.Full.p2(2,2), fliplr(LCAp.Full.p3(:,2)'), '>c')
hold on


%FabioFeroldi
load('S1001V5Left_LCA_ACL0_2202251545.mat')
errorbar(x, fliplr(LCAp.Full.p2(:,1)')-LCAp.Full.p2(2,1), fliplr(LCAp.Full.p3(:,1)'), '<', 'Color', [237 125 49]./255)
hold on
load('S1001V5Right_LCA_ACL0_2202251541.mat')
errorbar(x, fliplr(LCAp.Full.p2(:,2)')-LCAp.Full.p2(2,2), fliplr(LCAp.Full.p3(:,2)'), '>', 'Color', [237 125 49]./255)
hold on

%MaxGreen
load('S1001V5Left_LCA_ACL0_2203021544.mat')
errorbar(x, fliplr(LCAp.Full.p2(:,1)')-LCAp.Full.p2(2,1), fliplr(LCAp.Full.p3(:,1)'), '<', 'Color', [112 173 71]./255)
hold on
load('S1001V5Right_LCA_ACL0_2203021534.mat')
errorbar(x, fliplr(LCAp.Full.p2(:,2)')-LCAp.Full.p2(2,2), fliplr(LCAp.Full.p3(:,2)'), '>', 'Color', [112 173 71]./255)
hold on


x0=[460:620];
% y0=1.5+0.005./((x0./1000).^2);
y0=1.6091-6.7094E5./((x0).^2)+5.5533E10./((x0).^4)-5.6E15./((x0).^6);

plot(x0,y0)



legend('NHI Left')
msbL
ajrL

