if keyCode(KbName('UpArrow'))
    %                      mag = 1.3;
    %                     magR = magR + 0.01;%changed to 0.1 step size for new quadratic equation, 0.1 step size = 0.02D change in LCA for 8D optotune power and is 0.006D change in LCA for 12.5 D optotune power
    powerR=powerR-0.18;
elseif keyCode(KbName('w'))
    %                      mag = 1.3;
    %magL = magL + 0.01;%changed to 0.1 step size for new quadratic equation, 0.1 step size = 0.02D change in LCA for 8D optotune power and is 0.006D change in LCA for 12.5 D optotune power
    powerL=powerL-0.18;
    
elseif keyCode(KbName('DownArrow'))
    powerR=powerR+0.18;
    
    %magR = magR - 0.01; %0.005 for Austin %0.01 earlier
elseif keyCode(KbName('z'))
    powerL=powerL+0.18;
    %magL = magL - 0.01; %0.005 for Austin %0.01 earlier
elseif keyCode(KbName('l'))
    powerR=opR(1);%magnification of 1
    powerL=opL(1);%magnification of 1
    
elseif keyCode(KbName('RightArrow'))
    power_dispR=power_dispR+0.1;
elseif keyCode(KbName('s'))
    power_dispL=power_dispL+0.1;
elseif keyCode(KbName('LeftArrow'))
    power_dispR=power_dispR-0.1;
elseif keyCode(KbName('a'))
    power_dispL=power_dispL-0.1;
elseif keyCode(KbName('p'))
    rot = rot + .1; % Note this changes rotation stage in degrees
elseif keyCode(KbName('m'))
    rot = rot - .1; % Note this changes rotation stage in degrees
    %                  elseif keyCode(KbName('Shift'))
    %                      img=
    %                      wn=cwin(img, ey, cf, window1, window2);
elseif keyCode(KbName('ESCAPE')) | keyCode(KbName('Return'))
    %                     break
    opt_chk=1;
end