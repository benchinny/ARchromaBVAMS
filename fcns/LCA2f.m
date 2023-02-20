%% LCA function with E size input and magnification output
function [mag, power,power_disp, wn]=LCA2f(im_path, ey, window1, window2)

global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00

a = instrfind();
        if ~isempty(a) %isempty(Obj) returns logical 1 (true) if Obj is an empty ExptData object. Otherwise, it returns logical 0 (false). An empty ExptData object contains no data elements.
           fclose(a);
           delete(a)
           clear a
        end
        
for p = 1:6
    try
        opto(p).control.Close();
    catch
    end
end

portName = 'COM9'; 
port1 = serial(portName);
fclose(port1);
delete(port1);
clear port1;


%Use the following if there is error with ports, this will find all ports
%and close it. You can run this separately in command window and it will
% work
% a = instrfind();
% fclose(a);
% delete(a)
% clear a

% Select the external screen if it is present, else revert to the native
% screen
%screenNumber = 0; %max(screens);

% Define black, white and grey
% black = BlackIndex(screenNumber);
% white = WhiteIndex(screenNumber);
% grey = white / 2;

%img=imread('peppers.png');
%img=imread('G:\My Drive\exp_bvams\textures\split\texture0_nrm_rb','png'); %% image to show
%img=imread('/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_rgb','png'); %% image to show
%img=imread('/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_br','png'); %% image to show
img=imread(im_path,'png'); %% image to show
sz=size(img);
%% option 2 add E to existing image
%E=Eti(0.3, 22, [1080 1080]);
%E=Eti(0.3, Esz, [1080 1080]);

% E=Eti(0.3, Esz, sz(1:2), L);
% 
% E=(E~=0); %imshow(E)
% img=img.*uint8(E);
%imshow(img)

% Open an on screen window and color it grey
% [window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% % Set the blend funciton for the screen
% Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% % Get the size of the on screen window in pixels
% % For help see: Screen WindowSize?
% [screenXpixels, screenYpixels] = Screen('WindowSize', window);

% % Get the centre coordinate of the window in pixels
% % For help see: help RectCenter
% [xCenter, yCenter] = RectCenter(windowRect);

wn=cwin0(img, ey, cf, rc00, window1, window2);

% switch ey
%     case 'Stereo'
%         tex_1 = Screen('MakeTexture', window1, imcal(img, cf(1)));
%         Screen('DrawTexture', window1, tex_1);
%         tex_2 = Screen('MakeTexture', window2, imcal(img, cf(2)));
%         Screen('DrawTexture', window2, tex_2);
%         Screen('Flip', window1);
%         Screen('Flip', window2);
%         wn='B';
%         %%
%     case 'Right'
%         tex_1 = Screen('MakeTexture', window1, imcal(img, cf(1)));
%         Screen('DrawTexture', window1, tex_1);
%         screen('Flip', window1);
%         wn='R'
%     case 'Left'
%         tex_2 = Screen('MakeTexture', window2, imcal(img, cf(2)));
%         Screen('DrawTexture', window2, tex_2);
%         Screen('Flip', window2);
%         wn='L'
%     case 'Random'
%         if rand<0.5
%             window =window1; wn='R'; cf0=cf(1);
%         else
%             window=window2; wn='L', cf0=cf(2);
%         end
%         tex = Screen('MakeTexture', window, imcal(img, cf0));
%         Screen('DrawTexture', window, tex);
%         Screen('Flip', window);       
% end

if zbr ==0;  mag=1; power=1; power_disp=2; KbWait; end

%% option 1 for drawing E as text in window
% Draw text in the middle of the screen in Courier in white
% Screen('TextSize', window, 80);
% %Screen('TextFont', window, 'Courier');
% Screen('TextFont', window, 'Optima');
% DrawFormattedText(window, 'E', 'center', screenYpixels * 0.5 +22, white);
%%

%
% % img=imread('G:\My Drive\exp_bvams\textures\split\texture3_inv_rgb','png');
% % img=imread('G:\My Drive\exp_bvams\textures\split\texture3_nrm_rgb','png');
% % img=imread('G:\My Drive\exp_bvams\textures\split\texture2_inv_bgr','png'); %better for joss
% % img=imread('G:\My Drive\exp_bvams\textures\split\texture2_nrm_br','png');%better swati
% %img=imread('G:\My Drive\exp_bvams\textures\split\texture0_nrm_rb','png'); %% image to show
% %img=imread('/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_rgb','png'); %% image to show
% img=imread('peppers.png');
% % imshow(img)
%
% % Setup the screen parameters for Psychtoolbox
% %Screen('Preference', 'SkipSyncTests', 1);
% %Screen('Preference','VisualDebugLevel', 0);
% PsychDefaultSetup(2);
% screens = Screen('Screens');
%
% % Open the window(s) with a black background
% [window_1, windowRect_1] = PsychImaging('OpenWindow', max(screens)-1, [0 0 0]);
% Screen('BlendFunction', window_1, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
% % [window_2, windowRect_2] = PsychImaging('OpenWindow', max(screens), [0 0 0]);
% % Screen('BlendFunction', window_2, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
%
% % % Make a texture with the image we produced earlier and flip (place) onto
% % % display 1
% % tex_1 = Screen('MakeTexture', window_1, img);
% % Screen('DrawTexture', window_1, tex_1);
%
%
%
% % Draw text in the middle of the screen in Courier in white
% Screen('TextSize', window_1, 80);
% Screen('TextFont', window_1, 'Courier');
% DrawFormattedText(window_1, 'Hello World', 'center', 'center', white);
%
%
% Screen('Flip', window_1);
%
% % Make a texture with the image we produced earlier and flip (place) onto
% % display 2
% tex_2 = Screen('MakeTexture', window_2, img);
% Screen('DrawTexture', window_2, tex_2);
% Screen('Flip', window_2);



% Clear the screen. "sca" is short hand for "Screen CloseAll". This clears
% all features related to PTB. Note: we leave the variables in the
% workspace so you can have a look at them if you want.
% For help see: help sca
if zbr==1; %sca;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    addpath(genpath(fullfile('toolboxes')));
    KbName('UnifyKeyNames');
    
    enable_optotunes = true;
    enable_trombones = true;
    
    %% Setup anonymous functions
    mag_to_d = @(x) 1/(x*0.1);
    measured_optopower = [8, 9, 10, 11, 12];
    
    % Setup interpolation function for left trombone
    % measured_trombonepos_l = [1082120, 765654, 509000, 299082, 135000];
    % measured_trombonepos_l = [1089471, 765302, 512073, 308409, 142441]; %updated 1/10
    % measured_trombonepos_l = [1056563, 736365, 471776, 263147, 88530]; %updated 1/13 using E
    measured_trombonepos_l =[1118902, 797630, 536757, 342365 ,176524];%updated 1/24 using shear plate but psf is not sharpest
    % measured_trombonepos_l = [1174521, 850677, 595023, 379309, 202719]; %updated 1/24 using shear plate and updated using sharp psf measurments after lens replacement
    l_trombone_f = @(x) round(interp1(measured_optopower, measured_trombonepos_l, x, 'pchip')); % Note that this uses shape-preserving interpolation
    l_opto_f = @(x) interp1(measured_trombonepos_l, measured_optopower, x, 'pchip'); % Note that this uses shape-preserving interpolation
    
    % Setup interpolation function for right trombone
    measured_trombonepos_r = [451223, 772527, 1018330, 1217662, 1381313];
    r_trombone_f = @(x) round(interp1(measured_optopower, measured_trombonepos_r, x, 'pchip')); % Note that this uses shape-preserving interpolation
    r_opto_f = @(x) interp1(measured_trombonepos_r, measured_optopower, x, 'pchip'); % Note that this uses shape-preserving interpolation
    
    % Plot left trombone measurements
    x = linspace(8, 12, 100);
    y = l_trombone_f(x);
    % plot(x, y);
    % hold on
    % plot(measured_optopower, measured_trombonepos_l, 'or');
    
    % Plot right trombone measurements
    y = r_trombone_f(x);
    % plot(x, y);
    % plot(measured_optopower, measured_trombonepos_r, 'or');
    
    name_map = containers.Map;
    
    %% Open translation stage ports
    if enable_trombones
        portName = 'COM9'; % Name of the serial port to use.
        baudRate = 115200; % Baud rate the Zaber device is configured to use.
        
        % Initialize port.
        port = serial(portName);
        set(port, ...
            'BaudRate', baudRate,   'DataBits', 8, ...
            'FlowControl', 'none',  'Parity', 'none', ...
            'StopBits', 1,          'Terminator','CR/LF');
        
        set(port, 'Timeout', 0.5)
        warning off MATLAB:serial:fgetl:unsuccessfulRead
        
        % Open the port.
        fopen(port);
        
        % In this example we know we're using the ASCII protocol, so just
        % instantiate it directly.
        protocol = Zaber.AsciiProtocol(port);
        
        % Rotation stage
        deviceAddress = 1; % Address the Zaber device is configured to use.
        ident = 'rotation';
        name_map(ident) = deviceAddress;
        zaber(name_map(ident)).control = Zaber.AsciiDevice.initialize(protocol, deviceAddress);
        zaber(name_map(ident)).unit_scale = 768000/360;
        zaber(name_map(ident)).move = @(x) zaber(name_map(ident)).control.moveabsolute(x);
        zaber(name_map(ident)).move_deg = @(x) zaber(name_map(ident)).control.moveabsolute(x*zaber(name_map(ident)).unit_scale);
        fprintf('Device %d is a %s with firmware version %f\n', ...
            deviceAddress, zaber(deviceAddress).control.Name, ...
            zaber(deviceAddress).control.FirmwareVersion);
        
        % Right translation stage
        deviceAddress = 2; % Address the Zaber device is configured to use.
        ident = 'r_trombone';
        name_map(ident) = deviceAddress;
        zaber(name_map(ident)).control = Zaber.AsciiDevice.initialize(protocol, deviceAddress);
        zaber(name_map(ident)).unit_scale = 1584048/75.440286;
        zaber(name_map(ident)).move = @(x) zaber(name_map(ident)).control.moveabsolute(x);
        zaber(name_map(ident)).move_mm = @(x) zaber(name_map(ident)).control.moveabsolute(x*zaber(name_map(ident)).unit_scale);
        fprintf('Device %d is a %s with firmware version %f\n', ...
            deviceAddress, zaber(deviceAddress).control.Name, ...
            zaber(deviceAddress).control.FirmwareVersion);
        
        % Left translation stage
        deviceAddress = 3; % Address the Zaber device is configured to use.
        ident = 'l_trombone';
        name_map(ident) = deviceAddress;
        zaber(name_map(ident)).control = Zaber.AsciiDevice.initialize(protocol, deviceAddress);
        zaber(name_map(ident)).unit_scale = 1584048/75.440286;
        zaber(name_map(ident)).move = @(x) zaber(name_map(ident)).control.moveabsolute(x);
        zaber(name_map(ident)).move_mm = @(x) zaber(name_map(ident)).control.moveabsolute(x*zaber(name_map(ident)).unit_scale);
        fprintf('Device %d is a %s with firmware version %f\n', ...
            deviceAddress, zaber(deviceAddress).control.Name, ...
            zaber(deviceAddress).control.FirmwareVersion);
        
        zaber(name_map('rotation')).control.home();
        zaber(name_map('r_trombone')).control.home();
        zaber(name_map('l_trombone')).control.home();
        zaber(name_map('rotation')).control.waitforidle();
        zaber(name_map('r_trombone')).control.waitforidle();
        zaber(name_map('l_trombone')).control.waitforidle();
        
        % fclose(port);
        % delete(port);
    end
    
    %% Open optotune ports
    try
        if enable_optotunes
            serial_ports = seriallist;
            opto = [];
            for p = 1:6
                fprintf('Optotune serial port: %s\n', serial_ports(p))
                opto(p).port = serial_ports(p);
                opto(p).control = Optotune(opto(p).port);
                opto(p).control.Open();
                fprintf('Optotune serial number: %s\n', opto(p).control.serial_number)
                switch opto(p).control.serial_number
                    case "AQAA2859"
                        fprintf('Optotune ID: Left display\n');
                        name_map('l_disp') = p;
                    case "AQAA3868"
                        fprintf('Optotune ID: Left trombone, near\n');
                        name_map('l_t_near') = p;
                    case "AQAA4262"
                        fprintf('Optotune ID: Left trombone, far\n');
                        name_map('l_t_far') = p;
                    case "AQAA4190"
                        fprintf('Optotune ID: Right display\n');
                        name_map('r_disp') = p;
                    case "AQAA3948"
                        fprintf('Optotune ID: Right trombone, near\n');
                        name_map('r_t_near') = p;
                    case "AQAA3864"
                        fprintf('Optotune ID: Right trombone, far\n');
                        name_map('r_t_far') = p;
                end
                opto(p).control.modeFocalPower();
                fprintf('\n');
            end
        end
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
        rethrow(ERROR)
    end
    
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
    power_disp = 1000/75 +1/.3836;%setting for calibration with offset lens
%     power=10.0;
%     mag = 1.0;
    power=12.5;
     mag = 0.8;
    
    rot = 0.0;
    if enable_optotunes
        opto(name_map('l_disp')).control.setFocalPower(power_disp);
        opto(name_map('l_t_near')).control.setFocalPower(power);
        opto(name_map('l_t_far')).control.setFocalPower(power);
        opto(name_map('r_disp')).control.setFocalPower(power_disp);
        opto(name_map('r_t_near')).control.setFocalPower(power);
        opto(name_map('r_t_far')).control.setFocalPower(power);
    end
    
    if enable_trombones
        zaber(name_map('rotation')).move_deg(rot);
        zaber(name_map('l_trombone')).move(l_trombone_f(power));
        zaber(name_map('r_trombone')).move(r_trombone_f(power));
        zaber(name_map('rotation')).control.waitforidle();
        zaber(name_map('l_trombone')).control.waitforidle();
        zaber(name_map('r_trombone')).control.waitforidle();
    end
    
    %% Control loop
    ListenChar(2);
    try
        while true
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown
                 if keyCode(KbName('UpArrow'))
                     mag = 1.3;
                elseif keyCode(KbName('DownArrow'))
                     mag = mag - 0.02;
                elseif keyCode(KbName('RightArrow')) 
                     power_disp=power_disp+0.1;
                elseif keyCode(KbName('LeftArrow'))
                     power_disp=power_disp-0.1;
                elseif keyCode(KbName('p'))
                     rot = rot + .3; % Note this changes rotation stage in degrees
                elseif keyCode(KbName('m'))
                      rot = rot - .3; % Note this changes rotation stage in degrees
%                  elseif keyCode(KbName('Shift'))
%                      img=
%                      wn=cwin(img, ey, cf, window1, window2);
                elseif keyCode(KbName('q'))
                    break
                end
                
                % Hard-coded limits for magnification
                if mag < 0.8
                    mag = 0.8;
                elseif mag > 1.3
                    mag = 1.3;
                end
                
                fprintf('Magnification: %f\n', mag);
                fprintf('Rotation: %f degrees\n', rot);
                
            opto(name_map('l_disp')).control.setFocalPower(power_disp);
            opto(name_map('r_disp')).control.setFocalPower(power_disp);
            fprintf('Display power: %f\n', power_disp);
                
                power = mag_to_d(mag);
                fprintf('Target power: %f\n', power);
                l_trombone_target = l_trombone_f(power);
                r_trombone_target = r_trombone_f(power);
                fprintf('Target trombone (left): %u\n', l_trombone_target);
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
                    opto(name_map('l_t_near')).control.setFocalPower(power);
                    opto(name_map('l_t_far')).control.setFocalPower(power);
                    opto(name_map('r_t_near')).control.setFocalPower(power);
                    opto(name_map('r_t_far')).control.setFocalPower(power);
                end
                fprintf('\n');
            end
            
            % Key debounce routine, which waits for key to be released
            while keyIsDown
                [ keyIsDown, keyTime, keyCode ] = KbCheck;
            end
        end
    catch ERROR
        a = instrfind();
        if ~isempty(a) %isempty(Obj) returns logical 1 (true) if Obj is an empty ExptData object. Otherwise, it returns logical 0 (false). An empty ExptData object contains no data elements.
           fclose(a);
           delete(a)
           clear a
        end
        if enable_optotunes
            for p = 1:6
                opto(p).control.Close();
            end
        end
        if enable_trombones
            fclose(port);
            delete(port);
        end
        rethrow(ERROR)
    end
    ListenChar(0);
    
    %%
    fprintf('Shutting down\n')
    sca;
    
    if enable_optotunes
        for p = 1:6
            try
%                 a = instrfind();
%                 fclose(a);
%                 delete(a);
                opto(p).control.Close();
            catch
            end
        end
    end
    if enable_trombones
        fclose(port);
        delete(port);
    end
    Screen('CloseAll');
end