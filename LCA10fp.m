%% LCA function with E size input and magnification output
% function [mag, power,power_disp, wn]=LCA5f(im_path, p0, ey, window1, window2)
function [p1 p2 p3 p4 p5 p6 p7 p8 p9]=LCA10f(im_path, p0, ey, window1, window2)
%p1(k0,:)=[power_dispL power_dispR powerL powerR rot];
global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00

%% LCA params
%if set power_disp/optopower=0 randomize.
%  1power_dispL_min      power_dispR_min
power_dispL_min=p0(1); power_dispR_min=p0(1);
%  2power_dispL          power_dispR
power_dispL0=p0(2); power_dispR0=p0(2);
%  3power_dispL_max      power_dispL_max
power_dispL_max=p0(3); power_dispR_max=p0(3);
%  4L_optopower(mag)_min R_optopower(mag)_min
powerL_max=13.819067;   powerR_max=opR(p0(4));
% powerL_max=opL(p0(4));   powerR_max=opR(p0(4));
%  5L_optopower(mag)     R_optopower(mag)
powerL0=opL(p0(5));   powerR0=opR(p0(5));
%  6L_optopower(mag)_max R_optopower(mag)_max
powerL_min=opL(p0(6));   powerR_min=opR(p0(6));
%  7rot
% rot=p0(7,1); %rotation
% n0=p0(8,1); %number of repetitions
rot=p0(7);
n0=p0(8);

%powerL=opto_powerL(magL); powerR=opto_powerR(magR);

for k0=1:length(im_path)
    img{k0}=imread(im_path{k0}); %% image to show
end

%img=imread(im_path,'png'); %% image to show
sz=size(img{1});

n1=n0.*length(img); %total length of trials and conditions
n2=randperm(n1)./n1; %randomizing the conditions
n3=fct(length(img)); %fractions
n4=zeros(size(n2)); %trials and conditions vector
for k0=2:length(n3);
    n4=(k0-1).*((n3(k0-1)< n2) & (n2 <= n3(k0)))+n4; % think about how to turn this into a function segmentation=sgt
end

% wn=cwin0(img, ey, cf, rc00, window1, window2)
c9{1}='RED'; c9{2}='GREEN'; c9{3}='BLUE';



if zbr ==0;
    KbWait;
    
    %mag=1; power=1;
    
elseif zbr==1; %sca;
    for ii=1:4
    cls_opt;
    end
    addpath(genpath(fullfile('toolboxes')));
    KbName('UnifyKeyNames');
    
    opn_opt; %open optotune&trombone
    s2=['R' 'L'];
    for k0=1:n1 %% repetitions
        s0=[1 2]; s1=1; chk=0;% [right left] screen keyboard control starting with the right screen
        %rndLCA; %use initial conditions or randomize optotune/trombone settings
        %wn=cwin0(img, ey, cf, rc00, window1, window2);
        power_dispL=power_dispL0; power_dispR=power_dispR0;
        powerL=powerL0; powerR=powerR0;
        if enable_optotunes
            opto(name_map('l_disp')).control.setFocalPower(power_dispL);
            opto(name_map('l_t_near')).control.setFocalPower(powerL);
            opto(name_map('l_t_far')).control.setFocalPower(powerL);
            opto(name_map('r_disp')).control.setFocalPower(power_dispR);
            opto(name_map('r_t_near')).control.setFocalPower(powerR);
            opto(name_map('r_t_far')).control.setFocalPower(powerR);
        end
        
        if enable_trombones
            zaber(name_map('rotation')).move_deg(rot);
            zaber(name_map('l_trombone')).move(l_trombone_f(powerL));
            zaber(name_map('r_trombone')).move(r_trombone_f(powerR));
            zaber(name_map('rotation')).control.waitforidle();
            zaber(name_map('l_trombone')).control.waitforidle();
            zaber(name_map('r_trombone')).control.waitforidle();
        end
        wn=cwin0(img{n4(k0)}, ey, cf, rc00, window1, window2);
        %disp(['Focus on '  n2s(n4(k0))]);
        disp(['TRL#' n2s(k0) ' Focus on '  c9{n4(k0)}]);
        
        %% Control loop
        ListenChar(2);
        try
            %magR=mag; magL=mag;
            %power_dispR=power_disp; power_dispL=power_disp;
            %'left_shift'
            opt_chk=0;
            while opt_chk==0
                [ keyIsDown, keyTime, keyCode ] = KbCheck;
                if keyIsDown
                    kbLCA1; %take input from keyboard
                    lmtLCA; %check optotune and thrombone limits
                    
                    %disp(['Controlling '  s2(s1) ' side' ]);
                    %fprintf('Initial MagnificationL: %f\n', magL);
                    %fprintf('Initial MagnificationR: %f\n', magR);
                    
                    
                    opto(name_map('l_disp')).control.setFocalPower(power_dispL);
                    opto(name_map('r_disp')).control.setFocalPower(power_dispR);
                    
                    %powerL = mag_to_d(magL);
                    %powerR = mag_to_d(magR);
                    
                    
                    
                    l_trombone_target = l_trombone_f(powerL);
                    r_trombone_target = r_trombone_f(powerR);
                    
                    [PupCtr_LtX,PupCtr_LtY,PupCtr_RtX,PupCtr_RtY]=findPupilCenter(powerL,powerR);
                    
                    fprintf('Display powerR: %f\n', power_dispR);
                    fprintf('Trombone powerR: %f\n', powerR);
                    fprintf('Trombone position (right): %u\n', r_trombone_target);
                    fprintf('Right Pupil Center X = %f  , Y = %f\n',PupCtr_RtX,PupCtr_RtY);
                    fprintf('\n');
                    fprintf('Rotation: %f degrees\n', rot);
                    fprintf('Display powerL: %f\n', power_dispL);
                    fprintf('Trombone powerL: %f\n', powerL);
                    fprintf('Trombone position (left): %u\n', l_trombone_target);
                    fprintf('Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
                    if( l_trombone_target <0 ||  l_trombone_target ==0)
                        fprintf('Trying to access Negative zaber target postion for above value of Left optotune power\n');
                        powerL=13.819067;
                        fprintf('Setting powerL to %f\n',powerL);
                        l_trombone_target = l_trombone_f(powerL);
                        fprintf('Updated trombone (left) position: %u\n', l_trombone_target);
                        [PupCtr_LtX,PupCtr_LtY,~,~]=findPupilCenter(powerL,powerR);
                        fprintf('Updated Left Pupil Center X = %f  , Y = %f\n',PupCtr_LtX,PupCtr_LtY);
                    end
                    
                    
                    
                    
                    
                    if enable_trombones && enable_optotunes
                        zaber(name_map('rotation')).move_deg(rot);
                        zaber(name_map('l_trombone')).move(l_trombone_target);
                        zaber(name_map('r_trombone')).move(r_trombone_target);
                        
                        pos_l = zaber(name_map('l_trombone')).control.getposition;
                        pos_r = zaber(name_map('r_trombone')).control.getposition;
                        while (pos_l ~= l_trombone_target) || (pos_r ~= r_trombone_target)
                            power_int_l = l_opto_f(pos_l);
                            power_int_r = r_opto_f(pos_r);
                            opto(name_map('l_t_near')).control.setFocalPower(power_int_l);
                            opto(name_map('l_t_far')).control.setFocalPower(power_int_l);
                            opto(name_map('r_t_near')).control.setFocalPower(power_int_r);
                            opto(name_map('r_t_far')).control.setFocalPower(power_int_r);
                            % fprintf('L (pos, opto): %u, %f\n', pos_l, power_int_l);
                            % fprintf('R (pos, opto): %u, %f\n', pos_r, power_int_r);
                            
                            pos_l = zaber(name_map('l_trombone')).control.getposition;
                            pos_r = zaber(name_map('r_trombone')).control.getposition;
                        end
                        zaber(name_map('rotation')).control.waitforidle();
                        zaber(name_map('l_trombone')).control.waitforidle();
                        zaber(name_map('r_trombone')).control.waitforidle();
                    elseif enable_trombones
                        % Only trombones are enabled
                        zaber(name_map('rotation')).move_deg(rot);
                        zaber(name_map('l_trombone')).move(l_trombone_target);
                        zaber(name_map('r_trombone')).move(l_trombone_target);
                        zaber(name_map('rotation')).control.waitforidle();
                        zaber(name_map('l_trombone')).control.waitforidle();
                        zaber(name_map('r_trombone')).control.waitforidle();
                    elseif enable_optotunes
                        % Only optotunes are enabled
                        opto(name_map('l_t_near')).control.setFocalPower(powerL);
                        opto(name_map('l_t_far')).control.setFocalPower(powerL);
                        opto(name_map('r_t_near')).control.setFocalPower(powerR);
                        opto(name_map('r_t_far')).control.setFocalPower(powerR);
                    end
                    fprintf('\n');
                end
                
                % Key debounce routine, which waits for key to be released
                while keyIsDown
                    [ keyIsDown, keyTime, keyCode ] = KbCheck;
                end
            end
            
            %         p1=[power_dispL power_dispR; powerL powerR; rot image_displayed];
            p1(k0,:)=[power_dispL power_dispR powerL powerR rot n4(k0)];
            save('data\LCAtmp', 'p1', 'im_path');
            
            
        catch ERROR
            if enable_optotunes
                for p = 1:6
                    opto(p).control.Close();
                end
            end
            if enable_trombones
                fclose(port);
                delete(port);
            end
            
            a = instrfind();
            if ~isempty(a) %isempty(Obj) returns logical 1 (true) if Obj is an empty ExptData object. Otherwise, it returns logical 0 (false). An empty ExptData object contains no data elements.
                fclose(a);
                delete(a)
                clear a
            end
            
            rethrow(ERROR)
            
        end
        ListenChar(0);
    end
    
    for k0=1:length(im_path)
        p2(k0,:)=mean(p1(p1(:,6)==k0,:),1);%sorting the particular color focus values, and finding average of those
        p3(k0,:)=std(p1(p1(:,6)==k0,:), 0, 1) %CAUTION:also p3 is being used further!!!
    end
    %Compute the LCA of the system+eye between the primaries using the defocus
    %measurments for the subject (when there is NO ACL)
    p4(1,:)=(p2(1,:)-p2(3,:)); % red-blue
    p4(2,:)=p2(2,:)-p2(3,:); % green-blue
    p4(3,:)=p2(1,:)-p2(2,:); % red-green
    
    %Compute the LCA of the system with no ACL in place
    %note: important to use m=1 during subject's defocus adjustment
    %We will use same value of mag to compute system LCA
    
    %Compute the LCA of the eye by subtracting LCA of the systen
    p5(1,:)=p4(1,:)-(0.2174.*p0(5)+0.0818); %LCA eye Red-Blue
    p5(2,:)=p4(2,:)-(0.1231.*p0(5)+0.0297); %LCA eye Green-Blue
    p5(3,:)=p4(3,:)-(0.0943.*p0(5)+0.0521); %LCA eye Red-Green
    
    % To correct the LCA of the eye, put the ACL in place and adjust the trombone according to the equations on figure 6
    p6(:,1)=([9.2813 7.1652 6.8831].*((p5(:,1)').^[-0.403 -0.414 -0.39]))'; %left side
    p6(:,2)=([9.1613 7.2167 6.9543].*(p5(:,2)').^[-0.371 -0.382 -0.36])'; %Right side
  

    %calculate mean
    p7=mean(p6,1);

         
    %set display power to green average value
    opto(name_map('l_disp')).control.setFocalPower(p2(2,1)); %(power_dispL);
    opto(name_map('r_disp')).control.setFocalPower(p2(2,2)); %(power_dispR);
    
    %constrain trombone power
    p8(1)=bnd(p7(1), powerL_min, powerL_max);
    p8(2)=bnd(p7(2), powerR_min, powerR_max);
    
    %set trombone power
    opto(name_map('l_t_near')).control.setFocalPower(p8(1)); %(powerL);
    opto(name_map('l_t_far')).control.setFocalPower(p8(1)); %(powerL);
    
    opto(name_map('r_t_near')).control.setFocalPower(p8(2));%(powerR);
    opto(name_map('r_t_far')).control.setFocalPower(p8(2));%(powerR);
    
    
    l_trombone_target = l_trombone_f(p8(1)); %(powerL);
    r_trombone_target = r_trombone_f(p8(2)); %(powerR);
    
    zaber(name_map('l_trombone')).move(l_trombone_target);
    zaber(name_map('r_trombone')).move(r_trombone_target);
    
    p9=[p0' p0']; %right left matrix convention
    p9(2,:)=p2(2,1:2); %display power
    p9(5,:)=p8; %trombone power
    
    
    
    
end

%n=3; p2=p1(p1(:,6)==n,:); [mean(p2); std(p2)]