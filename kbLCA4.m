
PWRres=0.05;
if keyCode(KbName('1!'))
        if ey(1)=='R'
    pR0=1;%magnification of 1
    elseif ey(1)=='L'
    pL0=1;%magnification of 1
        end
elseif keyCode(KbName('UpArrow'))
    
    if ey(1)=='R'
        pR0=pR0+PWRres;
        %elseif s1==2;
    elseif ey(1)=='L'
        pL0=pL0+PWRres;
    end
    
        
elseif keyCode(KbName('DownArrow'))
    
    if ey(1)=='R'
        pR0=pR0-PWRres;
        %elseif s1==2;
    elseif ey(1)=='L'
        pL0=pL0-PWRres;
    end

elseif keyCode(KbName('RightArrow'))
    %     chk=0
    %     if s1==1;
    if ey(1)=='R'
        power_dispR=power_dispR+0.1;
        %elseif s1==2;
    elseif ey(1)=='L'
        power_dispL=power_dispL+0.1;
    end
    %end
elseif keyCode(KbName('LeftArrow'))
    %     chk=0;
    %     if s1==1;
    if ey(1)=='R'
        power_dispR=power_dispR-0.1;
        %elseif s1==2;
    elseif ey(1)=='L'
        power_dispL=power_dispL-0.1;
    end
    %end
elseif keyCode(KbName('p'))
    rot = rot + 0.5; %.1; % Note this changes rotation stage in degrees
elseif keyCode(KbName('m'))
    rot = rot - 0.5; % .1; % Note this changes rotation stage in degrees
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
    
elseif keyCode(KbName('tab')) %| keyCode(KbName('Return'))
    %                     break
    if ey(1)=='R'
        ey='L';
    elseif ey(1)=='L'
        ey='R';
    end
    
end


powerR=opR(pR0);%magnification of 1
powerL=opL(pL0);%magnification of 1
