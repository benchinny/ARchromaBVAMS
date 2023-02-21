% if keyCode(KbName('UpArrow'))
% %     chk=0;
% %     if s1==1;
%     powerR=powerR-0.18;
%     %elseif s1==2;
%     powerL=powerL-0.18;
%     %end
% elseif keyCode(KbName('DownArrow'))    
% %     chk=0;
% %     if s1==1;
%     powerR=powerR+0.18;
%    % elseif s1==2;
%     powerL=powerL+0.18;
    %end
% elseif keyCode(KbName('l'))
if keyCode(KbName('l'))

    powerR=opR(1);%magnification of 1
    powerL=opL(1);%magnification of 1
    
elseif keyCode(KbName('RightArrow'))
%     chk=0
%     if s1==1;
    power_dispR=power_dispR+0.1;
    %elseif s1==2;
    power_dispL=power_dispL+0.1;
    %end
elseif keyCode(KbName('LeftArrow'))
%     chk=0;
%     if s1==1;
    power_dispR=power_dispR-0.1;
    %elseif s1==2;    
    power_dispL=power_dispL-0.1;
    %end
elseif keyCode(KbName('p'))
    rot = rot + .1; % Note this changes rotation stage in degrees
elseif keyCode(KbName('m'))
    rot = rot - .1; % Note this changes rotation stage in degrees
    %                  elseif keyCode(KbName('Shift'))
    %                      img=
    %                      wn=cwin(img, ey, cf, window1, window2);
% elseif keyCode(KbName('tab')) & chk == 0
%     s0=circshift(s0,[0 1]); s1=s0(1); chk=1;
elseif keyCode(KbName('ESCAPE')) %| keyCode(KbName('Return'))
    %                     break
    opt_chk=1;
    
elseif keyCode(KbName('Return')) %| keyCode(KbName('Return'))
    %                     break
    opt_chk=1;
    
end