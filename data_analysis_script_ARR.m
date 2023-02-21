%% TCA RIGHT EYE
%Update TCA filename
% load('G:\My Drive\exp_bvams\code_repo\data\AR data\April 30 2021\Without ACL\S10003_TCA_RightACL0_2104301055.mat')
load('G:\My Drive\exp_bvams\code_repo\data\AR data\April 30 2021\With ACL\S10003_TCA_RightACL1_2104301234.mat')
fprintf('Total TCA Offsets measured subjectively for Right eye\n');
fprintf('Total Red-Green TCA offset: YOffset= %2.4f +/- %2.4f  XOffset = %2.4f +/- %2.4f\n',z1(Green,3),z2(Green,3),z1(Green,4),z2(Green,4));
fprintf('Total Red-Blue TCA offset:  YOffset= %2.4f +/- %2.4f XOffset= %2.4f +/- %2.4f\n', z1(Blue,3),z2(Blue,3),z1(Blue,4),z2(Blue,4));
fprintf('\n');
fprintf('System TCA for the Right side\n');

%Update LCA filename for SYstem TCA data
RightTromPwr=8.4871;
ACL=1;
 z0=[ 0	           0	        0	       0
                -0.46667	2.10833 	-0.33332	2.07501
                -0.39999	3.60834	    -0.25834	3.16666 ];
            
         
           
           tc0=Rtca_ACL(RightTromPwr); %get Right side system tca values WITH ACL based on trombone position
           z0(2,3:4)=tc0(1,:);  %set 
           z0(3,3:4)=tc0(2,:)  %set 


fprintf('System Red-Green TCA offset: YOffset= %2.4f   XOffset = %2.4f \n',z0(Green,3),z0(Green,4));
fprintf('System Red-Blue TCA offset: YOffset= %2.4f  XOffset= %2.4f \n', z0(Blue,3),z0(Blue,4));

fprintf('\n');
fprintf('Right EYE TCA OFFSET\n');
fprintf('Right Eye Red-Green TCA offset: YOffset= %2.4f +/- %2.4f   XOffset = %2.4f +/- %2.4f \n',z1(Green,3)-z0(Green,3),z2(Green,3), z1(Green,4)-z0(Green,4),z2(Green,4));
fprintf('Right Eye Red-Blue TCA offset: YOffset= %2.4f +/- %2.4f  XOffset= %2.4f +/- %2.4f \n', z1(Blue,3)-z0(Blue,3),z2(Blue,3),z1(Blue,4)-z0(Blue,4),z2(Blue,4));
fprintf('\n\n\n\n');