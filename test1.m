load('G:\My Drive\exp_bvams\code_repo\data\MB data\NOv 23 2020\S10004_Left_LCA_ACL0_2011231325_16trials.mat')
% load('G:\My Drive\exp_bvams\code_repo\data\MB data\NOv 23 2020\S10004_Right_LCA_ACL0_2011231441_16trials.mat')
for k0=1:3
           p2(k0,:)=mean(p1(p1(:,6)==k0,:),1) 
end
