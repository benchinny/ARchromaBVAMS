%% LCA function with E size input and magnification output
% function [mag, power,power_disp, wn]=LCA5f(im_path, p0, ey, window1, window2)
function p1=LCAfcs0(iL, iR, p0, window1, window2)
%p1(k0,:)=[power_dispL power_dispR powerL powerR rot];
global zbr cf rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto

%% LCA params
%if set power_disp/optopower=0 randomize.
%  1power_dispL_min      power_dispR_min
power_dispL_min=p0(1,1); power_dispR_min=p0(1,2);
%  2power_dispL          power_dispR
power_dispL0=p0(2,1); power_dispR0=p0(2,2);
%  3power_dispL_max      power_dispL_max
power_dispL_max=p0(3,1); power_dispR_max=p0(3,2);
%  4L_optopower(mag)_min R_optopower(mag)_min
powerL_max=p0(4,1);   powerR_max=p0(4,2);
%  5L_optopower(mag)     R_optopower(mag)
powerL0=p0(5,1);   powerR0=p0(5,2);
%  6L_optopower(mag)_max R_optopower(mag)_max
powerL_min=p0(6,1);   powerR_min=p0(6,2);
%  7rot
rot=p0(7,1); %rotation
n0=p0(8,1); %number of repetitions

%powerL=opto_powerL(magL); powerR=opto_powerR(magR);

% for k0=1:length(im_path)
% img{k0}=imread(im_path{k0}); %% image to show
% end

%img=imread(im_path,'png'); %% image to show
%sz=size(img{1});

n1=1; %n0.*length(img); %total length of trials and conditions
% n2=randperm(n1)./n1; %randomizing the conditions
% n3=fct(length(img)); %fractions
% n4=zeros(size(n2)); %trials and conditions vector
% for k0=2:length(n3);
%     n4=(k0-1).*((n3(k0-1)< n2) & (n2 <= n3(k0)))+n4; % think about how to turn this into a function segmentation=sgt
% end

% % wn=cwin0(img, ey, cf, rc00, window1, window2)
% c9{1}='RED'; c9{2}='GREEN'; c9{3}='BLUE';

p1=0

if zbr ==0;
    cwin1(iR, iL, cf, rc00, window1, window2);
    
    KbWait;
    p1=0;
    %mag=1; power=1;
    
elseif zbr==1; %sca;
    %cls_opt;
    addpath(genpath(fullfile('toolboxes')));
    KbName('UnifyKeyNames');
    
    %OPNT; %opn_opt; %open optotune&thrombone
    
    try; opto(6).control.modeFocalPower();
    catch ERROR;
        for k0=1:3
            cls_opt; pause(3);
            
        end
        
        OPNT;
    end
    
    
    s2=['R' 'L'];
    for k0=1:n1 %% repetitions
        s0=[1 2]; s1=1; chk=0;% [right left] screen keyboard control starting with the right screen
        rndLCA; %use initial conditions or randomize optotune/trombone settings
        %wn=cwin0(img, ey, cf, rc00, window1, window2);
        
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
        %wn=cwin0(img{n4(k0)}, ey, cf, rc00, window1, window2);
        cwin1(iR, iL, cf, rc00, window1, window2);
        %disp(['Focus on '  n2s(n4(k0))]);
        %disp(['TRL#' n2s(k0) ' Focus on '  c9{n4(k0)}]);
        
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
                    kbLCA0; %take input from keyboard
                    lmtLCA; %check optotune and thrombone limits
                    
                    disp(['Controlling '  s2(s1) ' side' ]);
                    %fprintf('Initial MagnificationL: %f\n', magL);
                    %fprintf('Initial MagnificationR: %f\n', magR);
                    fprintf('Rotation: %f degrees\n', rot);
                    
                    opto(name_map('l_disp')).control.setFocalPower(power_dispL);
                    opto(name_map('r_disp')).control.setFocalPower(power_dispR);
                    
                    %powerL = mag_to_d(magL);
                    %powerR = mag_to_d(magR);
                    
                    
                    
                    l_trombone_target = l_trombone_f(powerL);
                    r_trombone_target = r_trombone_f(powerR);
                    %                 while( l_trombone_target <0 ||  l_trombone_target ==0)
                    %                     fprintf('Trying to access Negative zaber target postion for above value of Left optotune power');
                    %                     powerL=powerL-0.0001;
                    %                     fprintf('Setting powerL to %f\n',powerL);
                    %                     l_trombone_target = l_trombone_f(powerL);
                    %                 end
                    
                    fprintf('Display powerR: %f\n', power_dispR);
                    fprintf('Trombone powerR: %f\n', powerR);
                    fprintf('Trombone position (right): %u\n', r_trombone_target);
                    fprintf('\n');
                    fprintf('Display powerL: %f\n', power_dispL);
                    fprintf('Trombone powerL: %f\n', powerL);
                    fprintf('Trombone position (left): %u\n', l_trombone_target);
                    if( l_trombone_target <0 ||  l_trombone_target ==0)
                        fprintf('Trying to access Negative zaber target postion for above value of Left optotune power');
                        powerL=13.819067;
                        fprintf('Setting powerL to %f\n',powerL);
                        l_trombone_target = l_trombone_f(powerL);
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
            
            %         p1=[power_dispL power_dispR; powerL powerR; magL magR; rot image_displayed];
            p1=[power_dispL power_dispR powerL powerR rot]% n4(k0)];
            save('data\FCStmp.mat', 'p1', 'iR', 'iL');
            
            
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
end