%%
%LCA file AR
%RIGHT
load('G:\My Drive\exp_bvams\code_repo\data\AR data\April 30 2021\Without ACL\S10003_LCA_RightACL0_2104301024.mat')
%LEFT
% load('G:\My Drive\exp_bvams\code_repo\data\AR data\April 30 2021\Without ACL\S10003_LCA_LeftACL0_2104301034.mat')
%UPDATE Which EYE?
eye='R';
%%
if eye=='L'
    col=1;
elseif eye=='R'
    col=2;
end
%%
Red=1;
Green=2;
Blue=3;
fprintf('LCA data for %s eye\n',eye);
fprintf('Red focus %2.4fD +/- %0.3f\n',a11(Red,col),a12(Red,col))
fprintf('Green focus %2.4fD +/- %0.3f\n',a11(Green,col),a12(Green,col))
fprintf('Blue Focus %2.4fD +/- %0.3f \n',a11(Blue,col),a12(Blue,col))
fprintf('LCA of Eye+System: Red-Blue=%2.4fD  Grn-Blue=%2.4fD  Red-Grn=%2.4fD \n',a13(1,col),a13(2,col),a13(3,col));
fprintf('LCA of Eye: Red-Blue=%2.4fD  Grn-Blue=%2.4fD  Red-Grn=%2.4fD \n',a14(1,col),a14(2,col),a14(3,col));
fprintf('Trombone optotune powers(D): %2.4f %2.4f %2.4f , Mean Power: %2.4fD \n',a15(1,col), a15(2,col),a15(3,col),a16(1,col));
fprintf('\n');
fprintf('\n');

%% TCA RIGHT EYE
%Update TCA filename
load('G:\My Drive\exp_bvams\code_repo\data\AR data\April 30 2021\Without ACL\S10003_TCA_RightACL0_2104301055.mat')
fprintf('Total TCA Offsets measured subjectively for Right eye\n');
fprintf('Total Red-Green TCA offset: YOffset= %2.4f +/- %2.4f  XOffset = %2.4f +/- %2.4f\n',z1(Green,3),z2(Green,3),z1(Green,4),z2(Green,4));
fprintf('Total Red-Blue TCA offset:  YOffset= %2.4f +/- %2.4f XOffset= %2.4f +/- %2.4f\n', z1(Blue,3),z2(Blue,3),z1(Blue,4),z2(Blue,4));
fprintf('\n');
fprintf('System TCA for the Right side\n');

%Update LCA filename for SYstem TCA data
load('G:\My Drive\exp_bvams\code_repo\data\AR data\April 30 2021\Without ACL\S10003_LCA_RightACL0_2104301024.mat')
fprintf('System Red-Green TCA offset: YOffset= %2.4f   XOffset = %2.4f \n',z0(Green,3),z0(Green,4));
fprintf('System Red-Blue TCA offset: YOffset= %2.4f  XOffset= %2.4f \n', z0(Blue,3),z0(Blue,4));

fprintf('\n');
fprintf('Right EYE TCA OFFSET\n');
fprintf('Right Eye Red-Green TCA offset: YOffset= %2.4f +/- %2.4f   XOffset = %2.4f +/- %2.4f \n',z1(Green,3)-z0(Green,3),z2(Green,3), z1(Green,4)-z0(Green,4),z2(Green,4));
fprintf('Right Eye Red-Blue TCA offset: YOffset= %2.4f +/- %2.4f  XOffset= %2.4f +/- %2.4f \n', z1(Blue,3)-z0(Blue,3),z2(Blue,3),z1(Blue,4)-z0(Blue,4),z2(Blue,4));
fprintf('\n\n\n\n');
%% TCA LEFT EYE
%Update Left Eye TCA filename
load('G:\My Drive\exp_bvams\code_repo\data\AR data\April 30 2021\Without ACL\S10003_TCA_LeftACL0_2104301050.mat')
fprintf('Total TCA Offsets measured subjectively for LEFT eye\n');
fprintf('Total Red-Green TCA offset: YOffset= %2.4f +/- %2.4f  XOffset = %2.4f +/- %2.4f\n',z1(Green,1),z2(Green,1),z1(Green,2),z2(Green,2));
fprintf('Total Red-Blue TCA offset:  YOffset= %2.4f +/- %2.4f XOffset= %2.4f +/- %2.4f\n', z1(Blue,1),z2(Blue,1),z1(Blue,2),z2(Blue,2));
fprintf('\n');
fprintf('System TCA for the Right side\n');
%Update LEft EYE LCA filename for LCA data
load('G:\My Drive\exp_bvams\code_repo\data\AR data\April 30 2021\Without ACL\S10003_LCA_LeftACL0_2104301034.mat')
fprintf('System Red-Green TCA offset: YOffset= %2.4f   XOffset = %2.4f \n',z0(Green,1),z0(Green,2));
fprintf('System Red-Blue TCA offset: YOffset= %2.4f  XOffset= %2.4f \n', z0(Blue,1),z0(Blue,2));

fprintf('\n');
fprintf('Left EYE TCA OFFSET\n');
fprintf('Left Eye Red-Green TCA offset: YOffset= %2.4f +/- %2.4f   XOffset = %2.4f +/- %2.4f \n',z1(Green,1)-z0(Green,1),z2(Green,1), z1(Green,2)-z0(Green,2),z2(Green,2));
fprintf('Left Eye Red-Blue TCA offset: YOffset= %2.4f +/- %2.4f  XOffset= %2.4f +/- %2.4f \n', z1(Blue,1)-z0(Blue,1),z2(Blue,1),z1(Blue,2)-z0(Blue,2),z2(Blue,2));







