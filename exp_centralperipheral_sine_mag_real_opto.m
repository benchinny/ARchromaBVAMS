function scene = exp_centralperipheral_sine_mag_real_opto()
    global AGL GL GLU log
    
    GLOBAL_ALPHA_A = 1;
    GLOBAL_ALPHA_B = 0.6162;
    %Ago's gamma calibration values. Add this command to the screen command
    %during the stimulus presentation similar to the following example.
    
    id = input('ID (default=TEST): ', 's');
    if isempty(id)
        id = 'TEST';
    end
    stereoMode = input('Stereo Mode (default=4): ');
    if isempty(stereoMode)
        stereoMode = 4;
    end
    
    clc
    rng('shuffle'); 
    addpath(genpath('scenes'))
    addpath(genpath('toolboxes'))
    
    log.CRITICAL = 5;
    log.ERROR = 4;
    log.WARNING = 3;
    log.INFO = 2;
    log.DEBUG = 1;
    log.LEVEL = log.DEBUG;
        
    % ---------------------------------------------------------------------
    % Experiment variables
    COND_REAL = 1;
    COND_REAL_CONFLICT = 2;
    conditions = [COND_REAL, COND_REAL_CONFLICT];

    %Effective screen distance
    fixation_diopters = 2.0;
    
    %Stimulus diopters in terms of the central target. Stimulus of the
    %peripheral target has same mag but with an opposite sign
    
    stimulus_diopters_center = fixation_diopters + linspace(-1.5, 1.5, 61);
    stimulus_speeds = [0.1, 0.2];
    stimulus_diameters = [14,20]; %[1, 2, 4, 8, 14, 20];
    textures = [0, 1, 2, 3];
    fixation_duration = 3.0;
    stimulus_duration = 10.0;
    postresp_duration  = 1.0;
    num_repetitions = 5;
    stimulus_rotations = [0, 90, 180, 270];
    stimulus_diopters_peri = flip(stimulus_diopters_center);
    
    % ---------------------------------------------------------------------
    % Generate scene file for a given user ID
    screen_res.width = 1920;
    screen_res.height = 1080;
    ar = screen_res.width/screen_res.height;
    scene = calibrate_calc_screen_dimensions_from_fov(0.1339, 28.5*ar, screen_res);
    scene.offset_lens = -8;
    scene = calibrate_gen_empty_scene(scene, stimulus_diopters_center, fixation_diopters);
    scene = calibrate_save_load_scene(id, scene);
    scene.stop = false;
    
    % ----------------------------------------------------------q-----------
    % Testing variables
    scene.debug = false;
    scene.opto_enable = true;
    scene.enable_tcp = false;
    scene.auto_advance = false;
    
    % ---------------------------------------------------------------------   
    % Display information about scene that may be critical for running
    if scene.opto_enable
        cmsg('Enabling Optotunes', log.INFO, log.LEVEL);
        
        scene = connect_optotune_1(scene);
        scene.opto1.setTemperatureLimits([20, 45]);
        scene.opto1.modeFocalPower();
        cmsg('Optotune 1 enabled', log.INFO, log.LEVEL);
        
        scene = connect_optotune_2(scene);
        scene.opto2.setTemperatureLimits([20, 45]);
        scene.opto2.modeFocalPower();
        cmsg('Optotune 2 enabled', log.INFO, log.LEVEL);
    end
    
    if scene.enable_tcp
        cmsg('TCP enabled', log.INFO, log.LEVEL);
        scene.tcp_socket = tcpip('169.229.228.200', 31000, 'NetworkRole', 'server');
        cmsg('Waiting for TCP socket connection...', log.INFO, log.LEVEL);
        fopen(scene.tcp_socket);
        cmsg('TCP connected!', log.INFO, log.LEVEL);
    end
    
    if scene.auto_advance
        cmsg('**** AUTO ADVANCE ENABLED ****', log.WARNING, log.LEVEL);
    end
    
    %Generating sequence
    cmsg('Generating trial sequence', log.INFO, log.LEVEL);
    
    %this generates a structured (counterbalance) trial sequence
    trials = [];
    for r = 1:num_repetitions
        new_seq = counterBalanceConditions(length(conditions), ...
                                           length(stimulus_speeds), ...
                                           length(stimulus_diameters));
        new_seq(:, end+1) = ones(1, length(new_seq)) * r;
        trials(end+1:end+length(new_seq), :) = new_seq;
    end

    % Create trial data storage in scene structure
    for t = 1:length(trials)
        scene.trials(t).condition = conditions(trials(t, 1));
        scene.trials(t).stimulus_speed = stimulus_speeds(trials(t, 2));
        scene.trials(t).stimulus_diameter = stimulus_diameters(trials(t, 3));
        scene.trials(t).central_display = (rand > 0.5) + 1;
        scene.trials(t).fixation_diopters = fixation_diopters;
        scene.trials(t).fixation_duration = fixation_duration;
        scene.trials(t).postresp_duration = postresp_duration;
        scene.trials(t).repetition = trials(t, end);
        scene.trials(t).texture = randsample(textures, 1);
        scene.trials(t).stimulus_rotation = randsample(stimulus_rotations, 1);
        scene.trials(t).stimulus_duration = stimulus_duration;
    end

    cmsg(['Number of trials: ' num2str(length(trials))], log.INFO, log.LEVEL);

    if scene.debug
       Screen('Preference', 'SkipSyncTests', 1);
    else
       Screen('Preference', 'SkipSyncTests', 0);
    % HDMI HACK:
       Screen('Preference', 'SkipSyncTests', 1);
    end
    Screen('Preference','VisualDebugLevel', 0);
    
    screenid = max(Screen('Screens'));
    
    white = [255 255 255];
    black = [0 0 0];
    gray = white/2;
    
    if IsWin && (stereoMode==4 || stereoMode==5)
       screenid = 0;
    end
    
    KbName('UnifyKeyNames');
    PsychImaging('PrepareConfiguration');
    if (stereoMode==4 || stereoMode==5 || stereoMode==10)
        % Necessary for flipping real central/peripheral stimuli given
        % mirror configuration.
        PsychImaging('AddTask', 'RightView', 'FlipHorizontal');
        PsychImaging('AddTask', 'AllViews', 'FlipVertical');
    end
    
    cmsg('Open window', log.INFO, log.LEVEL);
    if scene.debug
       scene.rect = [10 10 1920/2+10 1080/2+10];
       [windowPtr, scene.rect] = PsychImaging('OpenWindow', screenid, black, scene.rect, [], [], stereoMode);
    else
       [windowPtr, scene.rect] = PsychImaging('OpenWindow', screenid, black, [], [], [], stereoMode);
        HideCursor();
        ListenChar(2);
    end
    stim_rect = [scene.rect(3)/2-scene.rect(4)/2, 0, ...
                 scene.rect(3)/2+scene.rect(4)/2, scene.rect(4)];

    Screen('BlendFunction', windowPtr, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    % Load calibration texture
    filename = fullfile(pwd, 'Opto', 'calibration_target.png');
    img_in = im2uint8(imread(filename));
    tex_calibration = Screen('MakeTexture', windowPtr, img_in);
    cmsg('Loaded calibration texture', log.INFO, log.LEVEL);
    
    % Load fixation texture
    tex_fixation = zeros(length(textures), 1);
    
    for i = 1:length(textures) 
        filename = fullfile(pwd, 'Opto', 'textures', sprintf('texture%d.png', textures(i)));
        img_in = im2uint8(imread(filename));
        tex_fixation(i) = Screen('MakeTexture', windowPtr, img_in);
        cmsg(sprintf('Loaded fixation texture: %s', filename), log.INFO, log.LEVEL);
    end
    
    %load central textures
    
    tex_central = zeros(length(textures), length(stimulus_diameters));
    
    for i = 1:length(textures) 
        for j = 1:length(stimulus_diameters)
            filename = fullfile(pwd, 'Opto', 'stimuli', 'center', ... 
              sprintf('center_tex%d_dia%d.png', textures(i), stimulus_diameters(j)));
            img_in = im2uint8(imread(filename));
            tex_central(i, j) = Screen('MakeTexture', windowPtr, img_in);
            cmsg(sprintf('Loaded central texture: %s', filename), log.INFO, log.LEVEL);
        end
    end
    
    %Load peripheral textures

    tex_peripheral = zeros(length(textures), length(stimulus_diameters));
    
    for i = 1:length(textures) 
        for j = 1:length(stimulus_diameters)
            filename = fullfile(pwd, 'Opto', 'stimuli', 'periphery', ... 
              sprintf('periphery_tex%d_dia%d.png', textures(i), stimulus_diameters(j)));
            img_in = im2uint8(imread(filename));
            tex_peripheral(i, j) = Screen('MakeTexture', windowPtr, img_in);
            cmsg(sprintf('Loaded peripheral texture: %s', filename), log.INFO, log.LEVEL);
        end
    end
    
    % Load fixation cross-only texture
    img_in = im2uint8(imread([pwd, filesep, ...
             'Opto', filesep, 'cross_only.png']));
    tex_cross = Screen('MakeTexture', windowPtr, img_in);
    cmsg(sprintf('Loaded fixation cross-only texture'), log.INFO, log.LEVEL);
    
%     %---------------------------------------------------------------------
%     %Welcome display
%     
%     move_optotune1(scene, fixation_diopters)
%     move_optotune2(scene, fixation_diopters)
%     send_tcp(scene, 0);
%     
%     Screen('FillRect', windowPtr, black);
%     for stereo_buffer = [0, 1]
%         Screen('SelectStereoDrawBuffer', windowPtr, stereo_buffer);
%         Screen('DrawTexture', windowPtr, tex_cross, [], stim_rect, 0);
%     end
%     Screen('Flip', windowPtr);
% 
%     while true
%         [keyIsDown, ~, keyCode] = KbCheck();
%         if keyIsDown && keyCode(KbName('q'))
%             scene.stop = true;
%             break
%         elseif keyIsDown && keyCode(KbName('space'))
%             break
%         end
% %         if scene.auto_advance 
% %             break
% %         end
%     end
% 
%     pause(0.25)
    
    %-----------------------------------------------------------------
    %Alignment target

    baseRect = [0 0 50 50];
    [xCenter, yCenter] = RectCenter(stim_rect);
    centeredRect1 = CenterRectOnPointd(baseRect, xCenter, yCenter);

    [xCenter1, yCenter1] = RectCenter(stim_rect);
    centeredRect2 = CenterRectOnPointd(baseRect, xCenter1, yCenter1);

    fixation_size = 25;

    %fixation cross 1
    xCoords1 = [-fixation_size 0 0 0];
    yCoords1 = [0 0 -fixation_size 0];

    %fixation cross 2
    xCoords2 = [fixation_size 0 0 0];
    yCoords2 = [0 0 fixation_size 0];

    %fixation cross x
    xCoords3 = [-fixation_size fixation_size -fixation_size fixation_size];
    yCoords3 = [-fixation_size fixation_size fixation_size -fixation_size];

    allCoords_1 = [xCoords1; yCoords1];
    allCoords_2 = [xCoords2; yCoords2];
    allCoords_3 = [xCoords3; yCoords3];

    lineWidth = 4;

    shift_left = 0;
    shift_top = 0;
    sine_idx = 1;
    sine_powers = sin((1:20)/20*2*pi)*4.5;
    while true

        [keyIsDown, ~, keyCode] = KbCheck();
        if keyIsDown && keyCode(KbName('q'))
            scene.stop = true;
            break
        elseif keyIsDown && keyCode(KbName('LeftArrow'))
            xCenter1 = xCenter1 - 1;
            shift_left = shift_left - 1;
            centeredRect2 = CenterRectOnPointd(baseRect, xCenter1, yCenter1);
        elseif keyIsDown && keyCode(KbName('RightArrow'))
            xCenter1 = xCenter1 + 1;
            shift_left = shift_left + 1;
            centeredRect2 = CenterRectOnPointd(baseRect, xCenter1, yCenter1);
        elseif keyIsDown && keyCode(KbName('UpArrow'))
            yCenter1 = yCenter1 - 1;
            shift_top = shift_top - 1;
            centeredRect2 = CenterRectOnPointd(baseRect, xCenter1, yCenter1);
        elseif keyIsDown && keyCode(KbName('DownArrow'))
            yCenter1 = yCenter1 + 1;
            shift_top = shift_top + 1;
            centeredRect2 = CenterRectOnPointd(baseRect, xCenter1, yCenter1);
        elseif keyIsDown && keyCode(KbName(',<'))
            scene.mag_factor = scene.mag_factor - 0.1;
        elseif keyIsDown && keyCode(KbName('.>'))
            scene.mag_factor = scene.mag_factor + 0.1;
        elseif keyIsDown && keyCode(KbName('space'))
            break
        end

        opto_power_1 = 2.0; %fixation_diopters + sine_powers(sine_idx);
        move_optotune1(scene, opto_power_1)
        scale = (fixation_diopters-opto_power_1)*scene.mag_factor;
        rect = [stim_rect(1) - scale, ...
                stim_rect(2) - scale, ...
                stim_rect(3) + scale, ...
                stim_rect(4) + scale];
        Screen('SelectStereoDrawBuffer', windowPtr, 0);
%         Screen('DrawTexture', windowPtr, tex_calibration, [], rect)
        Screen('FrameRect', windowPtr, white, centeredRect1);
        Screen('DrawLines', windowPtr, allCoords_1, lineWidth, white, [xCenter yCenter], 2);
        Screen('DrawLines', windowPtr, allCoords_3, lineWidth, white, [xCenter yCenter], 2);

        opto_power_2 = 2.0; %fixation_diopters - sine_powers(sine_idx);
        move_optotune2(scene, opto_power_2)
        scale = (fixation_diopters-opto_power_2)*scene.mag_factor;
        rect = [stim_rect(1) - scale + shift_left, ...
                stim_rect(2) - scale + shift_top, ...
                stim_rect(3) + scale + shift_left, ...
                stim_rect(4) + scale + shift_top];
        Screen('SelectStereoDrawBuffer', windowPtr, 1);
%         Screen('DrawTexture', windowPtr, tex_calibration, [], rect)
        Screen('FrameRect', windowPtr, white, centeredRect2);
        Screen('DrawLines', windowPtr, allCoords_2, lineWidth, white, [xCenter1 yCenter1], 2);
        Screen('DrawLines', windowPtr, allCoords_3, lineWidth, white, [xCenter1 yCenter1], 2);

        Screen('Flip', windowPtr);

        sine_idx = mod(sine_idx, length(sine_powers)) + 1;
    end

    stim_rect_1 = stim_rect;
    stim_rect_2 = CenterRectOnPointd(stim_rect, xCenter1, yCenter1);
    centeredRect2 = CenterRectOnPointd(baseRect, xCenter1, yCenter1);

   

    cmsg(sprintf('Alignment done'), log.DEBUG, log.LEVEL);
    %---------------------------------------------------------------------
    
    Screen('Flip', windowPtr); % Clear the screen
    scene.trial_num = 0;
    while (scene.stop == false)
        scene.trial_num = scene.trial_num + 1;
        trial = scene.trials(scene.trial_num);
        
        cmsg(sprintf('Trial: %u', scene.trial_num), log.INFO, log.LEVEL);
        
        % Show trial info
        orderfields(trial)
        
        %Breaks
        percent_done = (scene.trial_num/length(scene.trials) * 100);
        if (percent_done == 25 || percent_done == 50 || percent_done == 75)
            pause(0.250)
            move_optotune1(scene, trial.fixation_diopters)
            move_optotune2(scene, trial.fixation_diopters)
            scene.stim_diopters_ind = find(stimulus_diopters_center == trial.fixation_diopters);
            send_tcp(scene, 0);

            for s = 1:10
                for stereo_buffer = [0, 1]
                    Screen('SelectStereoDrawBuffer', windowPtr, stereo_buffer);
                    Screen('FillRect', windowPtr, black);
                    Screen('TextSize',windowPtr, 32);
                    DrawFormattedText(windowPtr, [num2str(percent_done) '% done\n\nPlease wait ' num2str(10-s) ' seconds'], 'center', 'center', [255 255 255]);
                end
                Screen('Flip', windowPtr, [], 0, 0);
                pause(1.0)
            end
            
            for stereo_buffer = [0, 1]
                Screen('SelectStereoDrawBuffer', windowPtr, stereo_buffer);
                Screen('FillRect', windowPtr, black);
                Screen('TextSize',windowPtr, 32);
                DrawFormattedText(windowPtr, [num2str(percent_done) '% done\n\nPlease press any key\nto continue.'], 'center', 'center', [255 255 255]);
            end
            Screen('Flip', windowPtr, [], 0, 0);
            
             while true
                [keyIsDown, ~, keyCode] = KbCheck();
                if keyIsDown && keyCode(KbName('q'))
                    scene.stop = true;
                    break
                elseif keyIsDown && keyCode(KbName('space'))
                    break
                end
                if scene.auto_advance 
                    break
                end
             end
                                   
        end
        
        tex_type_ind = find(textures == trial.texture);
        stim_diameter_idx = find(stimulus_diameters == trial.stimulus_diameter);
        
        % Fixation
        move_optotune1(scene, trial.fixation_diopters)
        move_optotune2(scene, trial.fixation_diopters)
        scene.stim_diopters_ind = find(stimulus_diopters_center == trial.fixation_diopters);
        send_tcp(scene, 1);
        
        Screen('SelectStereoDrawBuffer', windowPtr, 0);
        Screen('DrawTexture', windowPtr, tex_fixation(tex_type_ind), [], [], trial.stimulus_rotation, [], GLOBAL_ALPHA_A); 
        
        Screen('SelectStereoDrawBuffer', windowPtr, 1);
        Screen('FillRect', windowPtr, black);
                
        Screen('Flip', windowPtr);
        
        WaitSecs(trial.fixation_duration);
        
        %Stimulus textures
        t_start = GetSecs();
        t_now = 0;
        while (t_now < trial.stimulus_duration)
            t_now = GetSecs() - t_start;
            stim_diopters_ind = round(sin(t_now * trial.stimulus_speed * 2*pi)*30+31);
            scene.stim_diopters_ind = stim_diopters_ind;
            send_tcp(scene, 2);
            if (trial.condition == COND_REAL)
                move_optotune1(scene, stimulus_diopters_center(stim_diopters_ind))
                move_optotune2(scene, stimulus_diopters_center(stim_diopters_ind))
                scale = (trial.fixation_diopters - stimulus_diopters_center(stim_diopters_ind))*scene.mag_factor;
                if (trial.central_display == 1) % Display 1 has central stimulus, Display 2 has none
                    rect = [stim_rect_1(1) - scale, ...
                            stim_rect_1(2) - scale, ...
                            stim_rect_1(3) + scale, ...
                            stim_rect_1(4) + scale];
                
                    Screen('SelectStereoDrawBuffer', windowPtr, 0);
                    Screen('DrawTexture', windowPtr, tex_central(tex_type_ind, stim_diameter_idx), [], [], trial.stimulus_rotation, [], GLOBAL_ALPHA_A);
                    Screen('SelectStereoDrawBuffer', windowPtr, 1);
                    Screen('FillRect', windowPtr, black);
                elseif (trial.central_display == 2) % Display 2 has central stimulus, Display 1 has none
                    rect = [stim_rect_2(1) - scale, ...
                            stim_rect_2(2) - scale, ...
                            stim_rect_2(3) + scale, ...
                            stim_rect_2(4) + scale];
                        
                    Screen('SelectStereoDrawBuffer', windowPtr, 0);
                    Screen('FillRect', windowPtr, black);
                    Screen('SelectStereoDrawBuffer', windowPtr, 1);
                    Screen('DrawTexture', windowPtr, tex_central(tex_type_ind, stim_diameter_idx), [], [], trial.stimulus_rotation, [], GLOBAL_ALPHA_B);
                end
                Screen('Flip', windowPtr);
                
            elseif (trial.condition == COND_REAL_CONFLICT)
                scale_center = (trial.fixation_diopters-stimulus_diopters_center(stim_diopters_ind))*scene.mag_factor;
                scale_peri = (trial.fixation_diopters-stimulus_diopters_peri(stim_diopters_ind))*scene.mag_factor;
                if (trial.central_display == 1) % Display 1 has central stimulus
                    rect_1 = [stim_rect_1(1) - scale_center, ...
                              stim_rect_1(2) - scale_center, ...
                              stim_rect_1(3) + scale_center, ...
                              stim_rect_1(4) + scale_center];

                    rect_2 = [stim_rect_2(1) - scale_peri, ...
                              stim_rect_2(2) - scale_peri, ...
                              stim_rect_2(3) + scale_peri, ...
                              stim_rect_2(4) + scale_peri];
                   
                    Screen('SelectStereoDrawBuffer', windowPtr, 0); % Display 1
                    move_optotune1(scene, stimulus_diopters_center(stim_diopters_ind))
                    Screen('DrawTexture', windowPtr, tex_central(tex_type_ind, stim_diameter_idx), [], [], trial.stimulus_rotation, [], GLOBAL_ALPHA_A);
                    
                    Screen('SelectStereoDrawBuffer', windowPtr, 1); % Display 2
                    move_optotune2(scene, stimulus_diopters_peri(stim_diopters_ind))
                    Screen('DrawTexture', windowPtr, tex_peripheral(tex_type_ind, stim_diameter_idx), [], [], trial.stimulus_rotation, [], GLOBAL_ALPHA_B);
                elseif (trial.central_display == 2) % Display 2 has central stimulus
                    rect_1 = [stim_rect_1(1) - scale_peri, ...
                              stim_rect_1(2) - scale_peri, ...
                              stim_rect_1(3) + scale_peri, ...
                              stim_rect_1(4) + scale_peri];

                    rect_2 = [stim_rect_2(1) - scale_center, ...
                              stim_rect_2(2) - scale_center, ...
                              stim_rect_2(3) + scale_center, ...
                              stim_rect_2(4) + scale_center];
                          
                    Screen('SelectStereoDrawBuffer', windowPtr, 0); % Display 1
                    move_optotune1(scene, stimulus_diopters_peri(stim_diopters_ind))
                    Screen('DrawTexture', windowPtr, tex_peripheral(tex_type_ind, stim_diameter_idx), [], [], trial.stimulus_rotation, [], GLOBAL_ALPHA_A);
                    
                    Screen('SelectStereoDrawBuffer', windowPtr, 1); % Display 2
                    move_optotune2(scene, stimulus_diopters_center(stim_diopters_ind))
                    Screen('DrawTexture', windowPtr, tex_central(tex_type_ind, stim_diameter_idx), [], [], trial.stimulus_rotation, [], GLOBAL_ALPHA_B);
                end
                
                Screen('Flip', windowPtr);
                
            end
            
            [keyIsDown, ~, keyCode] = KbCheck();
            if keyIsDown && keyCode(KbName('q'))
                scene.stop = true;
                break
            end
        end
        
        % Post stimulus
        
        %fixation cross +
        xCoords4 = [-fixation_size fixation_size 0 0];
        yCoords4 = [0 0 -fixation_size fixation_size];
        allCoords_4 = [xCoords4; yCoords4];
        
        send_tcp(scene, 3);
        Screen('Flip', windowPtr);
        move_optotune1(scene, trial.fixation_diopters)
        move_optotune2(scene, trial.fixation_diopters)
        WaitSecs(trial.postresp_duration);
        
        send_tcp(scene, 0);

        Screen('SelectStereoDrawBuffer', windowPtr, 0);
        Screen('FrameRect', windowPtr, white, centeredRect1);
        Screen('DrawLines', windowPtr, allCoords_4, lineWidth, white, [xCenter yCenter], 2);
        Screen('SelectStereoDrawBuffer', windowPtr, 1);
        Screen('FrameRect', windowPtr, white, centeredRect2);
        Screen('DrawLines', windowPtr, allCoords_3, lineWidth, white, [xCenter1 yCenter1], 2);
        Screen('Flip', windowPtr);
        
        % Response
        while true
            [keyIsDown, ~, keyCode] = KbCheck();
            if keyIsDown && keyCode(KbName('q'))
                scene.stop = true;
                break
            elseif keyIsDown && keyCode(KbName('space'))
                break
            end
            if scene.auto_advance
                break
            end
            if scene.stop
                break
            end
        end
        
        scene = calibrate_save_load_scene(id, scene);
          
        if (scene.trial_num+1 > length(scene.trials))
            scene.stop = true;
        end
    end
    
    %----------------------------------------------------------------------
    % Shutdown
    cmsg('Shutting down', log.INFO, log.LEVEL);
    scene = calibrate_save_load_scene(id, scene);
    
    send_tcp(scene, 0);
    Screen('CloseAll');
    if (scene.opto_enable)
        scene.opto1.Close();
        scene.opto2.Close();
    end
    if scene.enable_tcp
        fclose(scene.tcp_socket);
    end
    ShowCursor();
    ListenChar(0);
    Priority(0);
    
    %----------------------------------------------------------------------
    % Local functions
    function move_optotune1(scene, target_d)
        if (scene.opto_enable)
            lens_power = scene.opto_shift_D(target_d);
            cmsg(['Moving Optotune1 to ' num2str(target_d) 'D (' num2str(lens_power) 'D optotune)'], log.DEBUG, log.LEVEL);
            while (scene.opto1.etl_port.BytesToOutput > 0) % Wait for data to be transmitted
                pause(0.0001);
                cmsg('WAITING', log.DEBUG, log.LEVEL);
            end
            scene.opto1.setFocalPower(lens_power);
        end
    end
    function move_optotune2(scene, target_d)
        if (scene.opto_enable)
            lens_power = scene.opto_shift_D(target_d);
            cmsg(['Moving Optotune2 to ' num2str(target_d) 'D (' num2str(lens_power) 'D optotune)'], log.DEBUG, log.LEVEL);
            while (scene.opto2.etl_port.BytesToOutput > 0) % Wait for data to be transmitted
                pause(0.0001);
                cmsg('WAITING', log.DEBUG, log.LEVEL);
            end
            scene.opto2.setFocalPower(lens_power);
        end
    end


    function send_tcp(scene, stage)
        %{
            6 byte serial output format:
            Byte 1: Trial
            Byte 2: Stage
            Byte 3: Condition
            Byte 4: Stimulus Diameter
            Byte 5: Stimulus Frequency
            Byte 6: Stimulus Diopters
        %}
        if scene.enable_tcp
            if stage > 0
                trial_ = scene.trial_num;
                condition_ = scene.trials(trial_).condition;
                stimdiam_ = scene.trials(trial_).stimulus_diameter;
                stimfreq_ = find(stimulus_speeds == scene.trials(trial_).stimulus_speed);
                stimdiop_ = scene.stim_diopters_ind;
            else
                trial_ = 0;
                condition_ = 0;
                stimdiam_ = 0;
                stimfreq_ = 0;
                stimdiop_ = 0;
            end
            assert((stage <= 255) && (stage >= 0))
            assert((condition_ <= 255) && (condition_ >= 0))
            assert((stimdiam_ <= 255) && (stimdiam_ >= 0))
            assert((stimfreq_ <= 255) && (stimfreq_ >= 0))
            assert((stimdiop_ <= 255) && (stimdiop_ >= 0))

            data = [trial_ stage condition_ stimdiam_ stimfreq_ stimdiop_];
            cmsg(['TCP sending ' num2str(data(1)) ':' num2str(data(2)) ...
                  ':' num2str(data(3)) ':' num2str(data(4)) ...
                  ':' num2str(data(5)) ':' num2str(data(6))], ...
                  log.DEBUG, log.LEVEL);
            fwrite(scene.tcp_socket, data);
        end
    end
end
   