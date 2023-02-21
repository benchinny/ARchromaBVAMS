
%%%%%%%%%%%%%%%%MB LEFT EYE Red Blue GRating%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %to combine two data sets of half LCA correction  Red Blue GRating
% close all
% %load first data set 
% load('S10004_CSF_Left_ACL1_2101051145_halfLCACorr.mat')
% a80=a8; a70=a7; 
%     %load 2nd data set
% load('S10004_CSF_Left_ACL1_2101051258_halfLCACorr.mat')    
% a8=[a80 a8]; a7=[a70 a7];
% a9=psfs(a7, a8, a6, 0);


%%%%%%%%%%%%%%%%%combine 2 data sets of Full LCA correction  Red Blue GRating%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% close all
% %load first data set 
% load('S10004_CSF_Left_ACL1_2101051124_fullLCAcorr.mat')
% a80=a8; a70=a7; 
%     %load 2nd data set
% load('S10004_CSF_Left_ACL1_2101081225_fullLCAcorr.mat')    
% a8=[a80 a8]; a7=[a70 a7];
% a9=psfs(a7, a8, a6, 0);
% 
%%%%%%%%%%%%%%%%%combine 2 data sets of NO LCA correction  Red Blue GRating%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% close all
% %load first data set 
% load('S10004_CSF_Left_ACL0_2101081255_NoLCACorr.mat')
% a80=a8; a70=a7; 
%     %load 2nd data set
% load('S10004_CSF_Left_ACL0_2101081311_NoLCACorr.mat')    
% a8=[a80 a8]; a7=[a70 a7];
% a9=psfs(a7, a8, a6, 0);

%%%%%%%%%%%%%%%%%%%%%%%%to run 2 separate sets%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% to run 2 separate sets
% close all
% load('S10004_CSF_Left_ACL1_2101051145_halfLCACorr.mat')
% load('S10004_CSF_Left_ACL1_2101051124_fullLCAcorr.mat')
load('S10004_CSF_Left_ACL1_2101081225_fullLCAcorr.mat') 
 a9=psfs(a7, a8, a6, 0);
% 
% load('S10004_CSF_Left_ACL1_2101051124_fullLCAcorr')
% a9=psfs(a7, a8, a6, 0);
% 
% 

% load('G:\My Drive\exp_bvams\code_repo\data\MB_CSF_Left_ACL1 _2012291427.mat')
% % t0=psfs(r2, c2, s2, d0)
% 
% c20=c2; r20=r2;
% %load 2nd data set
% 
% % close all
% load('G:\My Drive\exp_bvams\code_repo\data\MB_CSF_Left_ACL1 _2012291410.mat')
% % t0=psfs(r2, c2, s2, d0)
% c21=c2; r21=r2;
% % load('G:\My Drive\exp_bvams\code_repo\data\MB_CSF_Left_ACL0 _2012231204.mat')
% 
% % load('G:\My Drive\exp_bvams\code_repo\data\MB_CSF_Left_ACL0 _2012281350.mat')
% load('G:\My Drive\exp_bvams\code_repo\data\MB_CSF_Left_ACL1 _2012291446.mat')
% c2=[c21 c20 c2]; r2=[r21 r20 r2];
% 
% d0=0
% t0=psfs(r2, c2, s2, d0)