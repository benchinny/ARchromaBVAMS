%211028 fcs_afc autorefractor focus for AFC0
function [power_dispL power_dispR]=fcs_afc(window1, window2)
global snt sp kntr ifi cf sz rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto ey


% i3=uint8(zeros([sz 3])); i3(:,:,2)=embd(T10c{13}, uint8(255.*ones(sz))); %%setgreen optotype image
% Esz=Esz0;
% i3=uint8(zeros([sz 3])); i3(:,:,clr_f)=uint8(255.*embd(usz(binv(opt('E', 4)), Esz), ones(sz))); %%setgreen optotype image
% cwin1(i3, i3, cf, rc00, window1, window2);

%% set focus!!!
dsp_v=[1 2]; dsp_chk=0;
%if ey(1)=='L'; dsp_sd=dsp_v(1); elseif ey(1)=='R'; dsp_v=circshift(dsp_v, [0 1]); dsp_sd=dsp_v(1); end %set initial focus side
dsp_sd=2;
power_dispL=opto(name_map('l_disp')).control.getFocalPower.focal_power;
power_dispR=opto(name_map('r_disp')).control.getFocalPower.focal_power;
opt_chk=0;
while opt_chk==0
    [ keyIsDown, keyTime, keyCode ] = KbCheck;
    if keyIsDown
        
        if keyCode(KbName('RightArrow'))
            if dsp_sd==2
                power_dispR=power_dispR+0.1;
            elseif dsp_sd==1
                power_dispL=power_dispL+0.1;
            end
            dsp_chk=0;
        elseif keyCode(KbName('LeftArrow'))
            if dsp_sd==2
                power_dispR=power_dispR-0.1;
            elseif dsp_sd==1
                power_dispL=power_dispL-0.1;
            end
            dsp_chk=0;
%         elseif keyCode(KbName('UpArrow'));
%             Esz=Esz+1;
%             i3=uint8(zeros([sz 3])); i3(:,:,clr_f)=uint8(255.*embd(usz(binv(opt('E', 4)), Esz), ones(sz))); %%setgreen optotype image
%             cwin1(i3, i3, cf, rc00, window1, window2);
%         elseif keyCode(KbName('DownArrow'));
%             Esz=Esz-1;
%             i3=uint8(zeros([sz 3])); i3(:,:,clr_f)=uint8(255.*embd(usz(binv(opt('E', 4)), Esz), ones(sz))); %%setgreen optotype image
%             cwin1(i3, i3, cf, rc00, window1, window2);
%             dsp_chk=0;
        elseif keyCode(KbName('TAB')) & (dsp_chk==0)
            dsp_v=circshift(dsp_v, [0 1]); dsp_sd=dsp_v(1); %shift focus side
            dsp_chk=1;
            
        elseif keyCode(KbName('ESCAPE')) %| keyCode(KbName('Return'))
            %                     break
            opt_chk=1;
        end
        opto(name_map('l_disp')).control.setFocalPower(power_dispL);
        opto(name_map('r_disp')).control.setFocalPower(power_dispR);
        
%         disp(['L' n2s2(power_dispL) ' R' n2s2(power_dispR) ' POWER DISPLAY, OPT SIZE' n2s2(Esz)])
        disp(['L' n2s2(power_dispL) ' R' n2s2(power_dispR)])

        
    end
    % Key debounce routine, which waits for key to be released
    while keyIsDown
        [ keyIsDown, keyTime, keyCode ] = KbCheck;
    end
end