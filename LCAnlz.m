function LCAnlz

sn=input('Subject Number? '); sn=sn+1000;
vs=input('Visit Number? ')

%220922uncorrect code
% load LCAflsL; L=LCAfls{sn-1000,2};
% load LCAflsR; R=LCAfls{sn-1000,2};

%corrected code looking at visit number besides 2
load LCAflsL; L=LCAfls{sn-1000,vs};
load LCAflsR; R=LCAfls{sn-1000,vs};

%x=[468 533 616]; %blue green red
x=[616 533 468]; %red green blue

load(L); mrkL='<';
L0=LCAp.Full.p5(:,1); %chromatic difference of refraction, a14 Before
L1=LCAp.Full.p2(:,1); %mean display focus red green blue
L2=LCAp.Full.p3(:,1); %std  display focus red green blue

load(R);  mrkR='>'
R0=LCAp.Full.p5(:,2); %chromatic difference of refraction, a14 Before
R1=LCAp.Full.p2(:,2); %mean display focus red green blue
R2=LCAp.Full.p3(:,2); %std  display focus red green blue

x=[616 533 468]; %red green blue
eg0=errorbar(x, L1, L2, [mrkL 'c']); %, 'Color', [0 1 0]./cf);
hold on
eg0=errorbar(x, R1, R2, [mrkR 'm']); %, 'Color', [0 1 0]./cf);
xlabel('Wavelength (nm)'); ylabel('Display Focus'); %title('AJR220118 LCA')
 

figure
X = categorical({'Red-Blue','Green-Blue','Red-Green'});
X = reordercats(X,{'Red-Blue','Green-Blue','Red-Green'});

%eg0=bar(X, [L0'; R0']); %, 'Color', [0 1 0]./cf);
eg0=bar(cat(2,L0,R0)); %temporary fix by Austin
xlabel('Primers'); ylabel('Chromatic Difference of Refraction (D)'); %title('AJR220118 LCA')

