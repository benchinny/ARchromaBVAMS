close all
clear all
clc
pa=0.2306;
% datafile_noACL={'G:\My Drive\exp_bvams\code_repo\data\S10004_TCA_LeftACL0_2103021338.mat',...
%    'G:\My Drive\exp_bvams\code_repo\data\S10004_TCA_LeftACL0_2103021341.mat',...
%    'G:\My Drive\exp_bvams\code_repo\data\S10004_TCA_LeftACL0_2103021345.mat'};
datafile_withACL={'G:\My Drive\exp_bvams\code_repo\data\S10004_TCA_LeftACL1_2103021401.mat',...
'G:\My Drive\exp_bvams\code_repo\data\S10004_TCA_LeftACL1_2103021405.mat',...
'G:\My Drive\exp_bvams\code_repo\data\S10004_TCA_LeftACL1_2103021409.mat'};
load('G:\My Drive\exp_bvams\code_repo\data\S10004_LCA_LeftACL0_2103021327.mat', 'z0')
datafile=datafile_withACL;
z1avg=0;
z2avg=0;
for n=1:length(datafile)
    load(datafile{n})
    z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)];
    z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)];
    z1_z0=z1-z0
    z1avg=z1avg+z1;
    z2avg=z2avg+z2.^2;
    errorbar(n,z1(2,1),z2(2,1),'--gx','LineWidth',1.5) %y GR
    hold on
    errorbar(n,z1(2,2),z2(2,2),'--ko','LineWidth',1.5) %x GR
    errorbar(n,z1(3,1),z2(3,1),'--b*','LineWidth',1.5) %y BR
    errorbar(n,z1(3,2),z2(3,2),'--cd','LineWidth',1.5) %x BR
    ax=gca;
    ax.FontSize=34;
    legend('Y GR', 'X GR', 'Y BR', 'X BR');
    xlabel('trial number');
    ylabel('TCA offset ');
    xlim([0 5])
    
end
z1avg
z2avg
z1avgf=z1avg/length(datafile)
z2avgf=sqrt(z2avg)
