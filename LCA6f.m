%% LCA function with E size input and magnification output
% function [mag, power,power_disp, wn]=LCA5f(im_path, p0, ey, window1, window2)
function [p1, opto, port, name_map, wn]=LCA6f(im_path, p0, ey, window1, window2)

global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
% p0(1)=1000/75 +1/.789;  %power_disp
% p0(2)=12.5; % power
% p0(3)=0.8; %mag
% p0(4)=0; %rot
% p0(5)=0; % set to 1 to close optotune at the end of LCA experiment, otherwise 0.

% power_dispL=p0(1,1); power_dispR=p0(1,2);
% magR=p0(2,1);        magR=p0(2,2);
% rot=p0(3,1);

%      power_disp = 1000/75 +1/.789;%setting for calibration with offset lens %distance=38.3+40.6=78.9cm as we insreased the distance of display further by putting 40.6 cm cage rods
%      power=12.5;
%      mag = 0.8;
%      rot = 0.0;
opto_powerL=@(magL) 11.32.*((magL).^(-1.039));
% opto_powerR=@(magR) -9.9976*magR+21.164; %right side
opto_powerR=@(magR) 11.002.*((magR)^(-0.958));

% %to start from a smallar beam size
% mag=0.8;
% power=opto_power(mag); % 13.1659D  for mag of 0.8
% rot = 0; %at -3 degree, for left side, display shd be at 15.94


power_dispL=p0(1,1); power_dispR=p0(1,2);
magL=p0(2,1);        magR=p0(2,2);
rot=p0(3,1);

powerL=opto_powerL(magL); powerR=opto_powerR(magR);

% cls_opt; % close/make sure optotune&thrombone is closed


%Use the following if there is error with ports, this will find all ports
%and close it. You can run this separately in command window and it will
% work
% a = instrfind();
% fclose(a);
% delete(a)
% clear a
img=imread(im_path,'png'); %% image to show
sz=size(img);
wn=cwin0(img, ey, cf, rc00, window1, window2);

if zbr ==0;
    KbWait;
    
    %mag=1; power=1;
    
elseif zbr==1; %sca;
    cls_opt;
    addpath(genpath(fullfile('toolboxes')));
    KbName('UnifyKeyNames');
    
    opn_opt; %open optotune&thrombone
    
    % %% Setup optotunes
    
    %%%%%%%%ABOUT DISPLAY OPTOTUNE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %We have a negative lens ACN254-075-A - f = -75.0 mm, �1" Achromatic Doublet, ARC: 400 - 700 nm
    %Since power of lens=-13.33D (-1000/75), so we set DISPLAY optotune power to
    %+13.33D (=+1000/75) +1/0.3836, so factor of 13.33D can nullify each other. And then we can
    %place the source/display at 0.3836 meters distance, so output beam is now collimated.
    
    %IF half of the display subtends 5 degree FOV (108 px/degree),so display
    %needs to be at 0.3836 meters distance
    
    %%1080px (0.067meters width) display will subtend 10 degree FOV
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %     power=10.0;
    %     mag = 1.0;
    %----------------program settings----------------------
    % % % %      power_disp = 1000/75 +1/.3836;%setting for calibration with offset lens
    %      power_disp = 1000/75 +1/.789;%setting for calibration with offset lens %distance=38.3+40.6=78.9cm as we insreased the distance of display further by putting 40.6 cm cage rods
    %      power=12.5;
    %      mag = 0.8;
    %      rot = 0.0;
    %----------------program settings----------------------
    %----------------Marty settings ----------------------
    %     power_disp = 14.14;
    %     power=10.63;
    %     mag = 0.94;
    %-----------------------------------------------------------
    %     rot = 0.0;
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
    
    %% Control loop
    ListenChar(2);
    try
        %magR=mag; magL=mag;
        %power_dispR=power_disp; power_dispL=power_disp;
        
        opt_chk=0;
        while opt_chk==0
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown
                if keyCode(KbName('UpArrow'))
                    %                      mag = 1.3;
                    %                     magR = magR + 0.01;%changed to 0.1 step size for new quadratic equation, 0.1 step size = 0.02D change in LCA for 8D optotune power and is 0.006D change in LCA for 12.5 D optotune power
%                     powerR=powerR-0.26;
                    powerR=powerR-0.18;
%                 elseif keyCode(KbName('+'))
                     elseif keyCode(KbName('w'))

                    %                      mag = 1.3;
                    %magL = magL + 0.01;%changed to 0.1 step size for new quadratic equation, 0.1 step size = 0.02D change in LCA for 8D optotune power and is 0.006D change in LCA for 12.5 D optotune power
%                     powerL=powerL-0.26;
                       powerL=powerL-0.18;
                elseif keyCode(KbName('DownArrow'))
%                     powerR=powerR+0.26;
                    powerR=powerR+0.18;
                    
                    %magR = magR - 0.01; %0.005 for Austin %0.01 earlier
                elseif keyCode(KbName('z'))
%                 elseif keyCode(KbName('RETURN'))
%                     powerL=powerL+0.26;
                     powerL=powerL+0.18;
                    %magL = magL - 0.01; %0.005 for Austin %0.01 earlier
                elseif keyCode(KbName('l'))
                    powerR=opto_powerR(1);%magnification of 1
%                     powerL=opto_powerL(1);%magnification of 1
                  
%                     elseif keyCode(KbName('t'))
%                     powerR=opto_powerR(0.8);%magnification of 1
%                     powerL=opto_powerL(0.8);%magnification of 1
                    
%                     elseif keyCode(KbName('h'))
%                     powerR=opto_powerR(1.2);%magnification of 1
%                     powerL=opto_powerL(1.2);%magnification of 1
                    
                elseif keyCode(KbName('RightArrow'))
                    power_dispR=power_dispR+0.1;
                elseif keyCode(KbName('s'))
%                elseif keyCode(KbName('.'))
                    power_dispL=power_dispL+0.1;
                elseif keyCode(KbName('LeftArrow'))
                    power_dispR=power_dispR-0.1;
                elseif keyCode(KbName('a'))
%                elseif keyCode(KbName('0'))
                    power_dispL=power_dispL-0.1;
                elseif keyCode(KbName('p'))
                    rot = rot + .1; % Note this changes rotation stage in degrees
                elseif keyCode(KbName('m'))
                    rot = rot - .1; % Note this changes rotation stage in degrees
%                  elseif keyCode(KbName('0'))
%                     rot = 0;
%                      elseif keyCode(KbName('2'))
%                     rot = 2.5;
%                      elseif keyCode(KbName('9'))
%                     rot = -2.5;
%                 elseif keyCode(KbName('ESCAPE')) | keyCode(KbName('Return'))
                 elseif keyCode(KbName('ESCAPE'))
                    %                     break
                    opt_chk=1;
                end
                
                
                % Hard-coded limits for magnification
                % Hard-coded limits for magnification
                if powerL>opto_powerL(0.8)
                    powerL=opto_powerL(0.8);
                elseif powerL<opto_powerL(1.2)
                    powerL=opto_powerL(1.2);
                end
                
                
                if powerR> opto_powerR(0.8)
                    powerR=opto_powerR(0.8);
                elseif powerR<opto_powerR(1.2)
                    powerR=opto_powerR(1.2);
                end
                
                if power_dispL < 8.0
                    power_dispL = 8.0;
                elseif power_dispL > 25
                    power_dispL = 25.0;
                end
                
                
                if power_dispR < 8.0
                    power_dispR = 8.0;
                elseif power_dispR > 25
                    power_dispR = 25.0;
                end
                
                
                
                %                 % Hard-coded limits for magnification
                %                 if magL < 0.8
                %                     magL = 0.8;
                %                 elseif magL > 1.2
                %                     magL = 1.2;
                %                 end
                %
                %                 if magR < 0.8
                %                     magR = 0.8;
                %                 elseif magR > 1.2
                %                     magR = 1.2;
                %                 end
                
                
                fprintf('Initial Mag Left: %f    ', magL);
                fprintf('Initial Mag Right: %f\n', magR);
                fprintf('Rotation Left: %f degrees\n', rot);
                
                opto(name_map('l_disp')).control.setFocalPower(power_dispL);
                opto(name_map('r_disp')).control.setFocalPower(power_dispR);
                fprintf('Display Power Left: %f    ', power_dispL);   
                fprintf('Display Power Right: %f\n', power_dispR);
                 
                %powerL = mag_to_d(magL);
                %powerR = mag_to_d(magR);            
                fprintf('Trombone power Left: %f    ', powerL);
                fprintf('Trombone power Right: %f\n', powerR);
                
                l_trombone_target = l_trombone_f(powerL);
                r_trombone_target = r_trombone_f(powerR);
%                 while( l_trombone_target <0 ||  l_trombone_target ==0)
%                     fprintf('Trying to access Negative zaber target postion for above value of Left optotune power');
%                     powerL=powerL-0.0001;  
%                     fprintf('Setting powerL to %f\n',powerL);
%                     l_trombone_target = l_trombone_f(powerL);
%                 end 
                if( l_trombone_target <0 ||  l_trombone_target ==0)
                    fprintf('Trying to access Negative zaber target postion for above value of Left optotune power\n');
                    powerL=13.819067;   
                    fprintf('Setting Trombone power Lef: %f\n',powerL);
                    l_trombone_target = l_trombone_f(powerL);
                end 
                fprintf('Target trombone (left): %u    ', l_trombone_target);
                fprintf('Target trombone (right): %u\n', r_trombone_target);
                
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
        
        %         p1=[power_dispL power_dispR; powerL powerR; magL magR; rot rot];
        p1=[power_dispL power_dispR; powerL powerR; rot rot];
        
        
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