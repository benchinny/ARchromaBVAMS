addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']);
addpath([pwd '\data\MB data\April 6 to Apr   2021 new data\Apr6']);
%enter LCA file for LEFT eye
% load('S10004_TCA_LeftACL0_2104061454.mat')
load('S10003_LCA_LeftACL0_2103261603.mat')
fprintf('Mean focus for R,G,B : [Meanpower_dispL Meanpower_dispR powerL powerR rot image_displayed (1row: red,2row:green,3row:blue)'); a11
fprintf('Std Dev for focus for R,G,B {SDleft_focusPwrs (R;G;B)}'); a12(:,1)
fprintf('System+Eye LCA {red-blue ; grn-blue; red-grn}'); a13(:,1)
fprintf('Eye LCA:  {red-blue ; grn-blue; red-grn}');a14 (:,1)
fprintf('Trombone powers {left }');a15(:,1)
fprintf('Mean Trombone powers');a16(1) 



%enter LCA file for RIGHT eye
% load('S10004_TCA_LeftACL0_2104061454.mat')
load('S10003_LCA_RightACL0_2103261450.mat')
fprintf('Mean focus for R,G,B : [Meanpower_dispL Meanpower_dispR powerL powerR rot image_displayed (1row: red,2row:green,3row:blue)'); a11
fprintf('Std Dev for focus for R,G,B {  SDright_focusPwrs(R;G;B)}'); a12(:,2)
fprintf('System+Eye LCA {red-blue ; grn-blue; red-grn}'); a13(:,2)
fprintf('Eye LCA:  {red-blue ; grn-blue; red-grn}');a14 (:,2)
fprintf('Trombone powers {right}');a15(:,2)
fprintf('Mean Trombone powers');a16(2) 




%ETM
 ETMfnm0='E_b2s5_p2_p14_o4_ms10_210320.mat'; load(ETMfnm0); %E optotype base 3 17secs to load
 %% first step to analyze
    c0=0.00384; %deg/pixels
    c1=1./(c0.*60);
    w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
    w4=20.*w3./c1; 20.*STK./c1

        %% end of first step
% %     strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]); %step 2: show staircase
% %     strc(y0, w4, [mna(20.*STK./c1) mxa(w4)]); %step 2: show staircase
% % 
      d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
      [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
     y0=[0 0]; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
     
     
     
     
     
     %% combine two stes of data
     clear w2 w22 y1 y11 y0 y00
     load S10004_ETMGrn_LeftACL0_2103301311.mat %S10004_ETMWhite_LeftACL0_2103301301.mat
     w22=w2;
     y11=y1;
     y00=y0;
     load S10004_ETMGrn_LeftACL0_2104061520.mat %S10004_ETMwht_LeftACL0_2104061544.mat
     w2=[w22; w2];
     y1=[y11; y1];
     y0=[y00; y0];
     %d1=5; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit 
     y0=zeros(1, length(y0)); [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background

     
     
     
     
     
     
     
