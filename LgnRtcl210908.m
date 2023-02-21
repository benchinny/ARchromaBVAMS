%%210908 code to align reticle based on 210604 JJVC_LCA run LCA task
ex='LCA';
%   power_disp_min  initial_power_disp max_power_disp mag_min   mag  mag_max rotation reptitions
a0=[8               13.5                  17             0.9    1     1.3     -3       6];
a0=[8               13.5                  17             0.9    1     1.4     -3       6];


fprintf('Display power: L = %f  , R = %f\n',opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power);
 fprintf('Trombone power: L = %f  , R = %f\n', opto(name_map('l_t_far')).control.getFocalPower.focal_power, opto(name_map('r_t_far')).control.getFocalPower.focal_power);
 fprintf('Trombone position: L = %f  , R = %f\n',  zaber(name_map('l_trombone')).control.getposition,  zaber(name_map('r_trombone')).control.getposition);
%fprintf('Pupil Center LX = %f  , LY = %f,  RX = %f  , RY = %f\n', PupCtr_LtX, PupCtr_LtY, PupCtr_RtX, PupCtr_RtY);
%fprintf('Rotation: %f degrees\n', rot);

disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);

[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0);

        %%input a output b
        cf=ones(3,2);
        clear LCAim
        %initial power=13.5 AR
        LCAim{1}='texture0_nrm_br.png'
        LCAim{2}='texture0_1080_newfill_malt.png'
        LCAim{3}='texture2_1080_newfill_malt.png'
        %texture3_1080_newfill_malt
        
        %LCAim{1}='opt1.png'; %'vrn10_R_sd1.png'; %'text2.png'; %
        %LCAim{2}='opt1.png'; %'vrn10_G_sd1.png';
        %LCAim{3}='opt1.png'; %'vrn10_B_sd1.png'; %'opt1.png'; %
        %           LCAim{1}='E500by500inv.png'
        %           LCAim{2}='E500by500inv.png'
        %           LCAim{3}='E500by500inv.png'
        %[a10, a11, a12, a13, a14, a15, a16, a17, a18]=LCA12f(LCAim, a0, window1, window2); %p1(a10):data, p2:avg, p3:sd, (a13)p4:sys+eye, p5(a14):EyeLCA, p6:trom pwr
        [a10, a11, a12, a13, a14, a15, a16, a17, a18]=LCA13f(LCAim, a0, window1, window2); %p1(a10):data, p2:avg, p3:sd, (a13)p4:sys+eye, p5(a14):EyeLCA, p6:trom pwr

        [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(a18(5,1), a18(5,2)); %(LeftTromPwr, RightTromPwr);
        fprintf('New Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);
        fprintf('New Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
        
        
        %findz0;
        
        z0=fnz0(a18(5,:), ACL); %find system TCA
        VRCMprm; %save varichrome parameters into VRCMp
        LCAp=VRCMp;
        if sv==1; save(['data\S' num2str(sn) ey '_' ex '_ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','z0','ACL', 'LCAp'); end

%         if sv==1; save(['data\S' num2str(sn) '_LCA_' ey 'ACL' n2s(ACL) '_' tme], 'a0', 'a10', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a11','LCAim','PupCtr_RtX','PupCtr_RtY','PupCtr_LtX','PupCtr_LtY','z0','ACL'); end
        save('data\SPTtmp', 'a18', '-append');
        
        input(['\n PLEASE UPDATE PUPIL CENTER IN LABVIEW \n' 'rtX: ' n2s2(PupCtr_RtX) ' rtY: ' n2s2(PupCtr_RtY) ' ltX: ' n2s2(PupCtr_LtX) ' ltY: ' n2s2(PupCtr_LtY)])
        
        a18
        sca
        
        