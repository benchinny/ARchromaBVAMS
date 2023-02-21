%In order to set them displays: click on monitor 2, and then select the
%option of "" q
% Clear the workspace qand the screenqq
%close optotune
%Use the following if there is error with ports, this will find all ports
%and close it.
a = instrfind();
        if ~isempty(a) %isempty(Obj) returns logical 1 (true) if Obj is an empty ExptData object. Otherwise, it returns logical 0 (false). An empty ExptData object contains no data elements.
           fclose(a);
           delete(a)
           clear a
        end
        
 for p = 1:6
    try
        opto(p).control.Clqose();
    catch
    end
 end   
   portName = 'COM9'; 
   port1 = serial(portName);
   fclose(port1);
   delete(port1);
   clear port1;

% img=imread('G:\My Drive\exp_bvams\textures\text3','png');
img=imread('G:\My Drive\exp_bvams\textures\colored-dots-background-stock-illustration-2228056','jpg');
% img=imread('G:\My Drive\exp_bvams\textures\split\texture3_inv_rgb','png');
% img=imread('G:\My Drive\exp_bvams\textures\split\texture3_nrm_rgb','png');
% img=imread('G:\My Drive\exp_bvams\tepllllxtures\split\texture2_inv_bgr','png'); %better for joss
%  img=imread('G:\My Drive\exp_bvams\textures\split\texture2_nrm_br','png');%better swati
%      img=imread('G:\My Drive\exp_bvams\qtextures\split\texture0_nrm_rb','png'); %used for derek
%  img=imread('G:\My Drive\exp_bvams\textures\vrn_thick','png');
%  img=imread('G:\My Drive\exp_bvams\textures\download','png');
% img=imread('G:\My Drive\exp_bvams\textures\grn_box_400','png');
%  img=imread('G:\My Drive\exp_bvams\textures\black','png');
%     img=imread('C:\Users\bankslab\Documents\exp_bvams\textures\split\texture0_nrm_rb','png'); %used for derek
    % had been using above, now changing to below to test Nadav's stimulus
%     img=imread('C:\Users\bankslab\Documents\exp_bvams\textures\Iprd1','png');
    
%     texture0_nrm_rb changed luminance
%  img=imread('G:\My Drive\exp_bvams\textures\split\texture2_inv_bgr','png'); 
%  img=imread('G:\My Drive\exp_bvams\textures\split\test_inv_bgr','png'); 
% imshow(imgq)
%  img=imread('G:\My Drive\exp_bvams\textures\split\texture0_nrm_rgb','png');
% img=imread('G:\mmmmmmmmpppppmmmmmmmmppppppppppppmmmmppmppppmmmmmmmmmmmmqMy Drive\exp_bvams\textures\split\texture3_inv_rgb','png');
% img=imread('G:\My Drive\exp_bvams\textures\split\teppppppppmmmmmmmmmmmmmmmmst_nrm_br','png');
% img=imread('G:\My Drive\exp_bvams\textures\split\texture3_nrm_rgb','png');
% img=imread('G:\My Drive\exp_bvams\textures\split\redbluecheckered','jpeg');
% Setup the screen parameters for
% Psychtoolboxqppppppppmmmmmmmmmmmmmmmmpppppppppppmmm
Screen('Preference', 'SkipSyncTests', 1);
Screen('Preference','VisualDebugLevel', 0);
PsychDefaultSetup(2);
screens = Screen('Screens');

% Open the window(s) with a black
% background
[window_1, windowRect_1] = PsychImaging('OpenWindow', max(screens)-1, [0 0 0]);
Screen('BlendFunction', window_1, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
[window_2, windowRect_2] = PsychImaging('OpenWindow', max(screens), [0 0 0]);
Screen('BlendFunction', window_2, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

% % Make a texture with the image we produced earlier and flip (place) onto
% % display 1
tex_1 = Screen('MakeTexture', window_1, img);
Screen('DrawTexture', window_1, tex_1);
Screen('Flip', window_1);

% Make a texture with the image we produced earlier and flip (place) onto
% display 2
tex_2 = Screen('MakeTexture', window_2, img);
Screen('DrawTexture', window_2, tex_2);
Screen('Flip', window_2);


% % Clear the screen. "sca" is short hand for "Screen CloseAll". This clears
% % all features related to PTB. Note: we leave the variables in the
% % workspace so you can have a look at them if you want.
% % For help see: help sca
% sca;q
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath(fullfile('toolboxes')));
KbName('UnifyKeyNames');

enable_optotunes = true;
enable_trombones = true;

%% Setup anonymous functions
%  mag_to_power = @(x) 1/(x*0.1); %magnification to optotune power, m=focalLengthOpto/100mm= 10D/Power_opto => hence opto_pow=10/m
% power_to_mag = @(x) 10/x;
measured_optopower = [8, 9, 10, 11, 12];

% Setup interpolation function for left trombone
% measured_trombonepos_l = [1082120, 765654, 509000, 299082, 135000];
% measured_trombonepos_l = [1089471, 765302, 512073, 308409, 142441];
% %updated
% 1/10
% measured_trombonepos_l = [l1056563, 736365, 471776, 263147, 88530]; %updated 1/13 using E
%  measured_trombonepos_l =[1118902, 797630, 536757, 342365 ,176524];%updated 1/24 using shear plate but psf is not sharpest
 measured_trombonepos_l = [1174521, 850677, 595023, 379309, 202719]; %updated 1/24 using shear plate and updated using sharp psf measurments after lens replacement
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
            a = instrfind();
            if ~isempty(a) %isempty(Obj) returns logical 1 (true) if Obj is an empty ExptData object. Otherwise, it returns logical 0 (false). An empty ExptData object contains no data elements.
                fclose(a);
                delete(a)
                clear a
            end
        fclose(port);
        delete(port);
    end
    rethrow(ERROR)
end

% %% Setup optotunes

%%%%%%%%ABOUT DISPLAY OPTOTUNE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%IF half of the display subtends 5 degree FOV (108 px/degree),so display
%needs to be at 0.3836 meters distance, hence the vergence due to the
%display is 1/.3836

%We have a negative lens ACN254-075-A - f = -75.0 mm, Ø1" Achromatic Doublet, ARC: 400 - 700 nm 
%Since power of lens=-13.33D (-1000/75), 

%so we set DISPLAY optotune power to
%+(1000/75) +1/0.3836, so the factor of 1000/75 can nullify -1000/75 from the negative lens. And then we can
%place the source/display at 0.3q836 meters distance, so output beam is now collimated. 



%%1080px (0.067meters widtqh) display will subtend 10 degree FOV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

power_disp = 1000/75 +1/.789;%NEW setting for calibration with offset lens %distance=38.3+40.6=78.9cm

%Austin's curve fitting  to mag vs optotune power data
opto_power=@(mag) -9.9976*mag+21.164;

%to start from a smallar beam size
mag=0.8;
power=opto_power(mag); % 13.1659D  for mag of 0.8
rot = 0; %at -3 degree, for left side, display shd be at 15.94

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
               power=power-0.26; %Reduce the power to increase the magnification
               %Step size 0f 0.26D in optotune power was determined using
               %new LCA equation for Red-Blue channels from Austin. This step size gives 16 steps
               %between our range of powers/mag and corresponds to LCA step
               %of 0.035 D to 0.049D
            elseif keyCode(KbName('DownArrow'))
               power=power+0.26; %when power increases, magnification decreases, downarrow=>low beam size=> lower mag
            elseif keyCode(KbName('l')) 
               power=opto_power(1);%magnification of 1
            elseif keyCode(KbName('p'))
                rot = rot + .1; % Note this changes rotation stage in degrees
            elseif keyCode(KbName('m'))
                rot = rot - .1; % Note this changes rotation stage in degrees
            elseif keyCode(KbName('RightArrow')) 
                power_disp=power_disp+0.1;
            elseif keyCode(KbName('LeftArrow'))
                power_disp=power_disp-0.1;
            elseif keyCode(KbName('q'))
                break
            end
            
            % Hard-coded limits for magnification
            if power> opto_power(0.8)
               power=opto_power(0.8);
             elseif power<opto_power(1.2)
               power=opto_power(1.2);
            end
            
             % Hard-coded limits for display optotune power
            if power_disp < 8.0
               power_disp = 8.0;
            elseif power_disp > 25
                power_disp = 25.0;
            end
   %magnification= ratio of focal lengths= focal length of optotune/ focal length of 100 mm lens= 
   %mag = 10D / Optotune Power , m=10/x; UPDATE NOTE: This eq no longer applies!! And
   %we cannot calculate mag of the system using this equation as we found
   %from calibration that there is another relationship 
     
            
           
            opto(name_map('l_disp')).control.setFocalPower(power_disp);
            opto(name_map('r_disp')).control.setFocalPower(power_disp);
            
            fprintf('Display Optotune power: %f\n', power_disp);
            fprintf('Trombone Optotune power: %f\n', power);
            fprintf('Rotation: %f degrees\n', rot);
            
                  
            l_trombone_target = l_trombone_f(power);
            r_trombone_target = r_trombone_f(power);
            fprintf('Target trombone position(left): %u\n', l_trombone_target);
            fprintf('Target trombone position(right): %u\n', r_trombone_target);
            
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
                % Only trombones areq enabled
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
% save(['mag_' num2str(yyyymmdd(datetime))], 'mag')
%%
fprintf('Shutting down\n')
sca;

if enable_optotunes
    for p = 1:6
        try
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