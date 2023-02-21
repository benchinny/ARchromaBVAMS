% load('G:\My Drive\exp_bvams\code_repo\data\MB data\NOv 23 2020\S10004_Left_LCA_ACL0_2011231325_16trials.mat')
load('C:\SWATI DATA\JJVC\exp bvams copy from Nov 24 2020-20201125T140522Z-001\exp bvams copy from Nov 24 2020\exp_bvams\code_repo\data\MB data\NOv 23 2020\S10004_Right_LCA_ACL0_2011231441_16trials.mat');
p2_rt=meanp1(p1);
magn=0.8;
eye=3; %both eyes
% 3 =both eyes 1=left eye 2=right eye 

load('C:\SWATI DATA\JJVC\exp bvams copy from Nov 24 2020-20201125T140522Z-001\exp bvams copy from Nov 24 2020\exp_bvams\code_repo\data\MB data\NOv 23 2020\S10004_Left_LCA_ACL0_2011231325_16trials.mat');
p2_lft=meanp1(p1);
p2_rt
p3=set_opt_RightEye(p2_rt,magn)
p2_lft
p4=set_opt_LeftEye(p2_lft,magn)

if eye==3
     p5=[p4 p3]
     
elseif eye==2 %tested right eye and don't have p4 to load in
    p4=zeros(8,1); %p4=p0(:,1);
    p5=[p4 p3]
elseif eye==1 %tested left eye and don't have p3 to load in
    p3=zeros(8,1); %p3=p0(:,2);
    p5=[p4 p3]
end

% opt0(p5);