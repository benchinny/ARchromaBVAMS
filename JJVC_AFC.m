%%211109 JJVC_AFC AFC2f include timing data
ex='AFC';
%   power_disp_min  initial_power_disp    max_power_dsp mag_min mag   mag_max rotation reptitions
% a0=[8               13.5                  17             0.9    1     1.3     -3       6];
% a0=[8               13.5                  17             0.9    1     1.4     -3       6];


fprintf('Display power: L = %f  , R = %f\n',opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power);
 fprintf('Trombone power: L = %f  , R = %f\n', opto(name_map('l_t_far')).control.getFocalPower.focal_power, opto(name_map('r_t_far')).control.getFocalPower.focal_power);
 fprintf('Trombone position: L = %f  , R = %f\n',  zaber(name_map('l_trombone')).control.getposition,  zaber(name_map('r_trombone')).control.getposition);
%fprintf('Pupil Center LX = %f  , LY = %f,   RX = %f  , RY = %f\n', PupCtr_LtX, PupCtr_LtY, PupCtr_RtX, PupCtr_RtY);
%fprintf('Rotation: %f degrees\n', rot);

disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);

[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0);

        %%input a output b
        cf=ones(3,2);

        %initial power=13.5 AR
        LCAim='texture0_1080_newfill_malt.png';        
%        LCAim{1}='texture0_1080_newfill_malt.png';
%         LCAim{2}='texture1_1080_newfill_malt.png';
%         LCAim{3}='texture2_1080_newfill_malt.png';
%         LCAim{4}='texture3_1080_newfill_malt.png';
        %texture3_1080_newfill_malt
        
        %LCAim{1}='opt1.png'; %'vrn10_R_sd1.png'; %'text2.png'; %
        %LCAim{2}='opt1.png'; %'vrn10_G_sd1.png';
        %LCAim{3}='opt1.png'; %'vrn10_B_sd1.png'; %'opt1.png'; %
        %           LCAim{1}='E500by500inv.png'
        %           LCAim{2}='E500by500inv.png'
        %           LCAim{3}='E500by500inv.png'
        v0=[-0.5:0.25:4]; %v00=[9	17	12	6	5	16	8	18	13	19	1	2	15	10	11	3	4	14	7	13	19	5	12	1	6	18	8	7	9	17	4	16	2	14	3	11	15	10	9	19	4	7	12	8	6	18	3	14	10	17	13	1	15	5	2	16	11	1	8	16	19	5	13	11	7	2	10	9	6	3	18	4	17	12	15	14] 
        %v00=[2	1	19	6	10	3	8	11	14	12	17	7	5	15	9	13	4	18	16	2	7	9	8	15	11	5	16	17	14	18	10	19	13	4	12	3	1	6	18	1	10	5	11	8	17	19	13	12	4	16	2	6	9	3	14	15	7	8	5	4	19	16	2	15	9	7	18	14	11	12	17	13	1	6	10	3]
        v00=[2	14	18	11	1	4	10	17	7	3	6	16	13	5	15	9	8	12	19	12	4	19	8	5	16	11	18	7	3	2	13	6	9	15	14	1	17	10	10	9	19	17	13	3	12	16	11	18	4	6	15	2	14	8	7	1	5	16	8	15	19	6	12	18	1	10	2	9	13	17	4	3	14	11	5	7]
        v000=v0(v00); %v000=v000(1:19); %v000=zeros(1,10);
        % v000=randi(5, 1, 10)-1
        %v000=[-1:1]
%        v000=[-0.5:0.25:4];
         [v1 t1]=AFC6f(LCAim, v000,  window1, window2); %p1(a10):data, p2:avg, p3:sd, (a13)p4:sys+eye, p5(a14):EyeLCA, p6:trom pwr

%          [v1 t1]=AFC4f(LCAim, v000,  window1, window2); %p1(a10):data, p2:avg, p3:sd, (a13)p4:sys+eye, p5(a14):EyeLCA, p6:trom pwr
%        [v1 t1 dgs]=AFC4f(LCAim, v000,  window1, window2); %p1(a10):data, p2:avg, p3:sd, (a13)p4:sys+eye, p5(a14):EyeLCA, p6:trom pwr

%         [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(a18(5,1), a18(5,2)); %(LeftTromPwr, RightTromPwr);
%         fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);
%         fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
%         
%         
%         %findz0;
%         
%         z0=fnz0(a18(5,:), ACL); %find system TCA
%         VRCMprm; %save varichrome parameters into VRCMp
%         LCAp=VRCMp;
%         if sv==1; save(['data\S' num2str(sn) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','z0','ACL', 'LCAp'); end
% 
         if sv==1; save(['data\S' num2str(sn) '_AFC_' ey 'ACL' n2s(ACL) '_' tme], 'v1', 't1', 'v0', 'v00', 'v000', 'PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','ACL'); end
%         if sv==1; save(['data\S' num2str(sn) '_AFC_' ey 'ACL' n2s(ACL) '_' tme], 'v1', 't1', 'v000', 'PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','ACL'); end

         %         save('data\SPTtmp', 'a18', '-append');
%         
%         input(['\n PLEASE UPDATE PUPIL CENTER IN LABVIEW \n' 'rtX: ' n2s2(PupCtr_RtX) ' rtY: ' n2s2(PupCtr_RtY) ' ltX: ' n2s2(PupCtr_LtX) ' ltY: ' n2s2(PupCtr_LtY)])
%         
%         a18
        sca


% %%211109 JJVC_AFC setting up for Fabio/JJVC data sample
% ex='AFC';
% %   power_disp_min  initial_power_disp    max_power_dsp mag_min mag   mag_max rotation reptitions
% % a0=[8               13.5                  17             0.9    1     1.3     -3       6];
% % a0=[8               13.5                  17             0.9    1     1.4     -3       6];
% 
% 
% fprintf('Display power: L = %f  , R = %f\n',opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power);
%  fprintf('Trombone power: L = %f  , R = %f\n', opto(name_map('l_t_far')).control.getFocalPower.focal_power, opto(name_map('r_t_far')).control.getFocalPower.focal_power);
%  fprintf('Trombone position: L = %f  , R = %f\n',  zaber(name_map('l_trombone')).control.getposition,  zaber(name_map('r_trombone')).control.getposition);
% %fprintf('Pupil Center LX = %f  , LY = %f,  RX = %f  , RY = %f\n', PupCtr_LtX, PupCtr_LtY, PupCtr_RtX, PupCtr_RtY);
% %fprintf('Rotation: %f degrees\n', rot);
% 
% disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);
% 
% [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0);
% 
%         %%input a output b
%         cf=ones(3,2);
% 
%         %initial power=13.5 AR
%         LCAim='texture0_1080_newfill_malt.png';        
% %        LCAim{1}='texture0_1080_newfill_malt.png';
% %         LCAim{2}='texture1_1080_newfill_malt.png';
% %         LCAim{3}='texture2_1080_newfill_malt.png';
% %         LCAim{4}='texture3_1080_newfill_malt.png';
%         %texture3_1080_newfill_malt
%         
%         %LCAim{1}='opt1.png'; %'vrn10_R_sd1.png'; %'text2.png'; %
%         %LCAim{2}='opt1.png'; %'vrn10_G_sd1.png';
%         %LCAim{3}='opt1.png'; %'vrn10_B_sd1.png'; %'opt1.png'; %
%         %           LCAim{1}='E500by500inv.png'
%         %           LCAim{2}='E500by500inv.png'
%         %           LCAim{3}='E500by500inv.png'
%         v0=[-0.5:0.25:4]; v00=[9	17	12	6	5	16	8	18	13	19	1	2	15	10	11	3	4	14	7	13	19	5	12	1	6	18	8	7	9	17	4	16	2	14	3	11	15	10	9	19	4	7	12	8	6	18	3	14	10	17	13	1	15	5	2	16	11	1	8	16	19	5	13	11	7	2	10	9	6	3	18	4	17	12	15	1] 
%         v000=v0(v00);
%         %v0=[-1:1]
%         v1=AFC1f(LCAim, v000,  window1, window2); %p1(a10):data, p2:avg, p3:sd, (a13)p4:sys+eye, p5(a14):EyeLCA, p6:trom pwr
% 
% %         [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(a18(5,1), a18(5,2)); %(LeftTromPwr, RightTromPwr);
% %         fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);
% %         fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
% %         
% %         
% %         %findz0;
% %         
% %         z0=fnz0(a18(5,:), ACL); %find system TCA
% %         VRCMprm; %save varichrome parameters into VRCMp
% %         LCAp=VRCMp;
% %         if sv==1; save(['data\S' num2str(sn) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','z0','ACL', 'LCAp'); end
% % 
% % %         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','z0','ACL'); end
% %         save('data\SPTtmp', 'a18', '-append');
% %         
% %         input(['\n PLEASE UPDATE PUPIL CENTER IN LABVIEW \n' 'rtX: ' n2s2(PupCtr_RtX) ' rtY: ' n2s2(PupCtr_RtY) ' ltX: ' n2s2(PupCtr_LtX) ' ltY: ' n2s2(PupCtr_LtY)])
% %         
% %         a18
%         sca






% %%211014 JJVC_AFC autorefractor accomodation experiment
% 
% % opp=62./1000; %ipd 62mm
% % adj=1 %diopters
% % 
% % atand(opp./adj)
% 
% %%210908 code to align reticle based on 210604 JJVC_LCA run LCA task
% ex='AFC';
% %   power_disp_min  initial_power_disp    max_power_dsp mag_min mag   mag_max rotation reptitions
% % a0=[8               13.5                  17             0.9    1     1.3     -3       6];
% % a0=[8               13.5                  17             0.9    1     1.4     -3       6];
% 
% 
% fprintf('Display power: L = %f  , R = %f\n',opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power);
%  fprintf('Trombone power: L = %f  , R = %f\n', opto(name_map('l_t_far')).control.getFocalPower.focal_power, opto(name_map('r_t_far')).control.getFocalPower.focal_power);
%  fprintf('Trombone position: L = %f  , R = %f\n',  zaber(name_map('l_trombone')).control.getposition,  zaber(name_map('r_trombone')).control.getposition);
% %fprintf('Pupil Center LX = %f  , LY = %f,  RX = %f  , RY = %f\n', PupCtr_LtX, PupCtr_LtY, PupCtr_RtX, PupCtr_RtY);
% %fprintf('Rotation: %f degrees\n', rot);
% 
% disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);
% 
% [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0);
% 
%         %%input a output b
%         cf=ones(3,2);
% 
%         %initial power=13.5 AR
%         LCAim='texture0_1080_newfill_malt.png';        
% %        LCAim{1}='texture0_1080_newfill_malt.png';
% %         LCAim{2}='texture1_1080_newfill_malt.png';
% %         LCAim{3}='texture2_1080_newfill_malt.png';
% %         LCAim{4}='texture3_1080_newfill_malt.png';
%         %texture3_1080_newfill_malt
%         
%         %LCAim{1}='opt1.png'; %'vrn10_R_sd1.png'; %'text2.png'; %
%         %LCAim{2}='opt1.png'; %'vrn10_G_sd1.png';
%         %LCAim{3}='opt1.png'; %'vrn10_B_sd1.png'; %'opt1.png'; %
%         %           LCAim{1}='E500by500inv.png'
%         %           LCAim{2}='E500by500inv.png'
%         %           LCAim{3}='E500by500inv.png'
%         %v0=[-0.5:0.5:4] 3
%         v0=[-1:1]
%         v1=AFC0f(LCAim, v0,  window1, window2); %p1(a10):data, p2:avg, p3:sd, (a13)p4:sys+eye, p5(a14):EyeLCA, p6:trom pwr
% 
% %         [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(a18(5,1), a18(5,2)); %(LeftTromPwr, RightTromPwr);
% %         fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);
% %         fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
% %         
% %         
% %         %findz0;
% %         
% %         z0=fnz0(a18(5,:), ACL); %find system TCA
% %         VRCMprm; %save varichrome parameters into VRCMp
% %         LCAp=VRCMp;
% %         if sv==1; save(['data\S' num2str(sn) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','z0','ACL', 'LCAp'); end
% % 
% % %         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','z0','ACL'); end
% %         save('data\SPTtmp', 'a18', '-append');
% %         
% %         input(['\n PLEASE UPDATE PUPIL CENTER IN LABVIEW \n' 'rtX: ' n2s2(PupCtr_RtX) ' rtY: ' n2s2(PupCtr_RtY) ' ltX: ' n2s2(PupCtr_LtX) ' ltY: ' n2s2(PupCtr_LtY)])
% %         
% %         a18
%         sca
% 
% 



% %%211014 JJVC_AFC autorefractor accomodation experiment
% 
% % opp=62./1000; %ipd 62mm
% % adj=1 %diopters
% % 
% % atand(opp./adj)
% 
% %%210908 code to align reticle based on 210604 JJVC_LCA run LCA task
% ex='AFC';
% %   power_disp_min  initial_power_disp    max_power_dsp mag_min mag   mag_max rotation reptitions
% a0=[8               13.5                  17             0.9    1     1.3     -3       6];
% a0=[8               13.5                  17             0.9    1     1.4     -3       6];
% 
% 
% fprintf('Display power: L = %f  , R = %f\n',opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power);
%  fprintf('Trombone power: L = %f  , R = %f\n', opto(name_map('l_t_far')).control.getFocalPower.focal_power, opto(name_map('r_t_far')).control.getFocalPower.focal_power);
%  fprintf('Trombone position: L = %f  , R = %f\n',  zaber(name_map('l_trombone')).control.getposition,  zaber(name_map('r_trombone')).control.getposition);
% %fprintf('Pupil Center LX = %f  , LY = %f,  RX = %f  , RY = %f\n', PupCtr_LtX, PupCtr_LtY, PupCtr_RtX, PupCtr_RtY);
% %fprintf('Rotation: %f degrees\n', rot);
% 
% disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);
% 
% [window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0);
% 
%         %%input a output b
%         cf=ones(3,2);
% 
%         %initial power=13.5 AR
%         
%         LCAim{1}='texture0_nrm_br.png'
%         LCAim{2}='texture0_1080_newfill_malt.png'
%         LCAim{3}='texture2_1080_newfill_malt.png'
%         %texture3_1080_newfill_malt
%         
%         %LCAim{1}='opt1.png'; %'vrn10_R_sd1.png'; %'text2.png'; %
%         %LCAim{2}='opt1.png'; %'vrn10_G_sd1.png';
%         %LCAim{3}='opt1.png'; %'vrn10_B_sd1.png'; %'opt1.png'; %
%         %           LCAim{1}='E500by500inv.png'
%         %           LCAim{2}='E500by500inv.png'
%         %           LCAim{3}='E500by500inv.png'
%         [a10, a11, a12, a13, a14, a15, a16, a17, a18]=AFC0f(LCAim, window1, window2); %p1(a10):data, p2:avg, p3:sd, (a13)p4:sys+eye, p5(a14):EyeLCA, p6:trom pwr
% 
%         [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(a18(5,1), a18(5,2)); %(LeftTromPwr, RightTromPwr);
%         fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);
%         fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
%         
%         
%         %findz0;
%         
%         z0=fnz0(a18(5,:), ACL); %find system TCA
%         VRCMprm; %save varichrome parameters into VRCMp
%         LCAp=VRCMp;
%         if sv==1; save(['data\S' num2str(sn) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','z0','ACL', 'LCAp'); end
% 
% %         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','z0','ACL'); end
%         save('data\SPTtmp', 'a18', '-append');
%         
%         input(['\n PLEASE UPDATE PUPIL CENTER IN LABVIEW \n' 'rtX: ' n2s2(PupCtr_RtX) ' rtY: ' n2s2(PupCtr_RtY) ' ltX: ' n2s2(PupCtr_LtX) ' ltY: ' n2s2(PupCtr_LtY)])
%         
%         a18
%         sca




