%% combine left and right LCA&TCA parameters


%Below are the 2 LCA files: one for left eye, other for right eye. 

% Need to extract a18(5,1)  from left eye LCA data and a18(5,2) from right eye LCA data and assign it in findz0 script as below:
% LeftTromPwr=a18(5,1);
% RightTromPwr=a18(5,2);
% Also need to extract whether these files are for ACL0 condition or ACL1 condition, to get correct z0 for binocular case.

% ACL=0 %or1
load('S10003_LCA_RightACL0_2103261450.mat', 'a18'); a18R=a18; %RIGHT LCA 
load('S10003_LCA_LeftACL0_2103261603.mat', 'a18');  a18L=a18; %LEFT LCA

a18(:,2)=a18R(:,2);

findz0;

% ------------------------------------------------------------------------------------------------------------------------------
% Similarly, below are 2 TCA files: 
load('S10003_TCA_RightACL0_2103261502.mat'); z1R=z1;
load('S10003_TCA_LeftACL0_2103261614.mat'); z1L=z1;
% These files already have z1 values saved. Need to extract the correct part of z1 values from each of above 2 files, and create a new z1 matrix which can be used in a binocular task.

z1(:, 3:4)=z1R(:, 3:4);


% Thank you
% Swati


