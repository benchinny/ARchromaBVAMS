
%%220110 introducing TCAp
ex='TCA';
%%input c output d
%SysTCA210818 cf=[1 1; 1 1; 1 1]; 
cf=[RB./RR LB./LR; 0.3 0.3; 1 1]; if ey(1)=='R'; cf(:,2)=0; elseif ey(1)=='L'; cf(:,1)=0; end
% cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1]
ms=10;
rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
r2p=1./(0.00384.*60); %pixe ls in one arcmin
xy0=25; %inital positio n of small circle
ppp = [5 0.5] ; %resolution pixelsPerPress
n2=6; %3; %numb er of  repetitions
%         TCAfnm='c130_b145to540_w10_ms10_sd1_6';
TCAfnm='c65_b75to540_w10_ms10_sd1_6';

fprintf('Display power: L = %f  , R = %f\n',opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power);
fprintf('Trombone power: L = %f  , R = %f\n', opto(name_map('l_t_far')).control.getFocalPower.focal_power, opto(name_map('r_t_far')).control.getFocalPower.focal_power);
fprintf('Trombone position: L = %f  , R = %f\n',  zaber(name_map('l_trombone')).control.getposition,  zaber(name_map('r_trombone')).control.getposition);

%disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);
disp(['Subject #' n2s(sn) 'Visit #' n2s(vs) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);

[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0); %start psychtoolbox

%[bxy v0 y6]=TCA11f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2); %line62 in TCA9f to add/remove blue reticle on green
%bTCA=TCA13f(TCAfnm, xy0, rgb, [ms n2], ppp, sr, window1, window2); %line62 in TCA9f to add/remove blue reticle on green
TCAp=TCA14f(TCAfnm, xy0, rgb, [ms n2], ppp, sr, window1, window2); %line62 in TCA9f to add/remove blue reticle on green

% z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
% z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]

TCAp.z1=[0 0 0 0;   mean(TCAp.bxy(TCAp.v0==2,:),1); mean(TCAp.bxy(TCAp.v0==1,:),1)]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
TCAp.z2=[0 0 0 0;   std(TCAp.bxy(TCAp.v0==2,:),0,1); std(TCAp.bxy(TCAp.v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]

TCAprm; %save varichrome parameters into VRCMp
%z0=fnz0(VRCMp.far_pwr, ACL);
TCAp.z0=fnz0(TCAp.far_pwr, double(ACL~=0));

% if ey(1)=='L'
%     VRCMp.sysTCA=bTCA.z0(:,1:2); VRCMp.sbjTCA=bTCA.z1(:,1:2); VRCMp.stdTCA=bTCA.z2(:,1:2);
% elseif ey(1)=='R'
%     VRCMp.sysTCA=bTCA.z0(:,3:4); VRCMp.sbjTCA=bTCA.z1(:,3:4); VRCMp.stdTCA=bTCA.z2(:,3:4);
% end

if ey(1)=='L'
    TCAp.sysTCA=TCAp.z0(:,1:2); TCAp.sbjTCA=TCAp.z1(:,1:2); TCAp.stdTCA=TCAp.z2(:,1:2);
elseif ey(1)=='R'
    TCAp.sysTCA=TCAp.z0(:,3:4); TCAp.sbjTCA=TCAp.z1(:,3:4); TCAp.stdTCA=TCAp.z2(:,3:4);
end

% TCAp=VRCMp; rb2=TCAp.sbjTCA(3,2)./r2p; %rb1=rb0./r2p; %difference between red&blue
TCAp.rb2=TCAp.sbjTCA(3,2)./r2p; %rb1=rb0./r2p; %difference between red&blue
%if sv==1; save(['data\S' num2str(sn) '_TCA_' ey 'ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0', 'z1','z2', 'VRCMp'); end
%if sv==1; save(['JnJ\S' num2str(sn) 'V' num2str(vs) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0', 'z1','z2', 'TCAp'); end
if sv==1; save(['JnJ\S' num2str(sn) 'V' num2str(vs) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'TCAp'); end

save('JnJ\SPTtmp', 'TCAp', '-append');
%           opto(name_map('l_disp')).control.setFocalPower(14+sr(1));
%           opto(name_map('r_disp')).control.setFocalPower(14.4+sr(2));
%           zaber(name_map('rotation')).move_deg(-3); %%-6400
[iLf iRf]=cwin3(imread('black.png'), imread('black.png') , cf, rc00, window2, window1);

sca


% %%220105 based on JJVC_TCA
% ex='TCA';
% %%input c output d
% %SysTCA210818 cf=[1 1; 1 1; 1 1]; 
% cf=[RB./RR LB./LR; 0.3 0.3; 1 1]; if ey(1)=='R'; cf(:,2)=0; elseif ey(1)=='L'; cf(:,1)=0; end
% % cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1]
% ms=10;
% rgb=[3 1; 2 1]; %TCA [front background] colors 1red 2green 3blue
% r2p=1./(0.00384.*60); %pixe ls in one arcmin
% xy0=25; %inital positio n of small circle
% ppp = [5 0.5] ; %resolution pixelsPerPress
% n2=6; %3; %numb er of  repetitions
% %         TCAfnm='c130_b145to540_w10_ms10_sd1_6';
% TCAfnm='c65_b75to540_w10_ms10_sd1_6';
% %
% %TCAfnm='c130_b145to540_r340to350_w10_ms10_sd1_6'; %for big circle
% %         input('\n UPDATED LABVIEW PUPIL CENTER?\n');
% %clear E10c
% %         [bxy v0]=TCA9f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2); %line62 in TCA9f to add/remove blue reticle on green
% %[bxy v0 y6]=TCA10f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2); %line62 in TCA9f to add/remove blue reticle on green
% 
% fprintf('Display power: L = %f  , R = %f\n',opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power);
% fprintf('Trombone power: L = %f  , R = %f\n', opto(name_map('l_t_far')).control.getFocalPower.focal_power, opto(name_map('r_t_far')).control.getFocalPower.focal_power);
% fprintf('Trombone position: L = %f  , R = %f\n',  zaber(name_map('l_trombone')).control.getposition,  zaber(name_map('r_trombone')).control.getposition);
% 
% %disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);
% disp(['Subject #' n2s(sn) 'Visit #' n2s(vs) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);
% 
% [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0); %start psychtoolbox
% 
% %[bxy v0 y6]=TCA11f(TCAfnm, xy0, rgb, [ms n2], ppp, window1, window2); %line62 in TCA9f to add/remove blue reticle on green
% bTCA=TCA13f(TCAfnm, xy0, rgb, [ms n2], ppp, sr, window1, window2); %line62 in TCA9f to add/remove blue reticle on green
% % z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
% % z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
% 
% bTCA.z1=[0 0 0 0;   mean(bTCA.bxy(bTCA.v0==2,:),1); mean(bTCA.bxy(bTCA.v0==1,:),1)]; %input for ETM: [R G B] by [Ldown Lright Rdown Rright]
% bTCA.z2=[0 0 0 0;   std(bTCA.bxy(bTCA.v0==2,:),0,1); std(bTCA.bxy(bTCA.v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
% 
% VRCMprm; %save varichrome parameters into VRCMp
% %z0=fnz0(VRCMp.far_pwr, ACL);
% bTCA.z0=fnz0(VRCMp.far_pwr, double(ACL~=0));
% 
% if ey(1)=='L'
%     VRCMp.sysTCA=bTCA.z0(:,1:2); VRCMp.sbjTCA=bTCA.z1(:,1:2); VRCMp.stdTCA=bTCA.z2(:,1:2);
% elseif ey(1)=='R'
%     VRCMp.sysTCA=bTCA.z0(:,3:4); VRCMp.sbjTCA=bTCA.z1(:,3:4); VRCMp.stdTCA=bTCA.z2(:,3:4);
% end
% 
% if ey(1)=='L'
%     bTCA.sysTCA=bTCA.z0(:,1:2); bTCA.sbjTCA=bTCA.z1(:,1:2); bTCA.stdTCA=bTCA.z2(:,1:2);
% elseif ey(1)=='R'
%     bTCA.sysTCA=bTCA.z0(:,3:4); bTCA.sbjTCA=bTCA.z1(:,3:4); bTCA.stdTCA=bTCA.z2(:,3:4);
% end
% 
% TCAp=VRCMp; rb2=TCAp.sbjTCA(3,2)./r2p; %rb1=rb0./r2p; %difference between red&blue
% bTCA.rgb=rgb;
% %if sv==1; save(['data\S' num2str(sn) '_TCA_' ey 'ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0', 'z1','z2', 'VRCMp'); end
% %if sv==1; save(['JnJ\S' num2str(sn) 'V' num2str(vs) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'bxy','rgb', 'v0', 'z1','z2', 'TCAp'); end
% if sv==1; save(['JnJ\S' num2str(sn) 'V' num2str(vs) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'bTCA', 'TCAp'); end
% 
% save('JnJ\SPTtmp', 'bTCA', 'TCAp', '-append');
% 
% sca

