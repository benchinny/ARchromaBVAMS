load('G:\My Drive\exp_bvams\code_repo\data\AR data\April 30 2021\With ACL\S10003_TCA_LeftACL1_2104301225.mat')
fprintf('Total TCA Offsets measured subjectively for LEFT eye\n');
fprintf('Total Red-Green TCA offset: YOffset= %2.4f +/- %2.4f  XOffset = %2.4f +/- %2.4f\n',z1(Green,1),z2(Green,1),z1(Green,2),z2(Green,2));
fprintf('Total Red-Blue TCA offset:  YOffset= %2.4f +/- %2.4f XOffset= %2.4f +/- %2.4f\n', z1(Blue,1),z2(Blue,1),z1(Blue,2),z2(Blue,2));
fprintf('\n');
fprintf('System TCA for the Right side\n');
%Update LEft EYE LCA filename for LCA data
% load('G:\My Drive\exp_bvams\code_repo\data\MB data\April 6 to Apr   2021 new data\Apr6\S10004_LCA_LeftACL0_2104061444.mat');
%for ACL=1 condition
LeftTromPwr=8.9973;
ACL=1;
            %Avg SYSTEM tca values  WITH ACL           
            z0=[ 0	           0	        0	       0
                -0.46667	2.10833 	-0.33332	2.07501
                -0.39999	3.60834	    -0.25834	3.16666 ];
            
           tc0=Ltca_ACL(LeftTromPwr); %get Left side system tca values WITH ACL based on trombone position
           z0(2,1:2)=tc0(1,:);  %set 
           z0(3,1:2)=tc0(2,:);  %set 
           
         

fprintf('System Red-Green TCA offset: YOffset= %2.4f   XOffset = %2.4f \n',z0(Green,1),z0(Green,2));
fprintf('System Red-Blue TCA offset: YOffset= %2.4f  XOffset= %2.4f \n', z0(Blue,1),z0(Blue,2));

fprintf('\n');
fprintf('LEFT EYE TCA OFFSET\n');
fprintf('Left Eye Red-Green TCA offset: YOffset= %2.4f +/- %2.4f   XOffset = %2.4f +/- %2.4f \n',z1(Green,1)-z0(Green,1),z2(Green,1), z1(Green,2)-z0(Green,2),z2(Green,2));
fprintf('Left Eye Red-Blue TCA offset: YOffset= %2.4f +/- %2.4f  XOffset= %2.4f +/- %2.4f \n', z1(Blue,1)-z0(Blue,1),z2(Blue,1),z1(Blue,2)-z0(Blue,2),z2(Blue,2));



