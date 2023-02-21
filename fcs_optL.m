%210701 focuse optotune/type before experiment ETM16f FRNG4f

function w1=fcs_optL(w0, j4, j3, j2, j1, i255, e0, s20, window1, window2)

global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi sz cf rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto ey cntrst

power_dispL=opto(name_map('l_disp')).control.getFocalPower.focal_power;
power_dispR=opto(name_map('r_disp')).control.getFocalPower.focal_power;
opt_chk=0; w1=0;
while opt_chk==0
    
    if w1~=w0;
     %% TCA corrected 
     w1=w0; r1=4;
     ir1= embd(circshift(e0{w1, r1, j3(1,1), j3(1,2)}    ,[j1(1,1)-j4(1,1) j1(1,2)-j4(1,2)] ),i255); %window2 LFT screen RED

     ig1= embd(circshift(e0{w1, r1, j3(2,1), j3(2,2)}    ,[j1(2,1)-j4(2,1) j1(2,2)-j4(2,2)] ),i255); %window2 LFT screen GREEN

     ib1= embd(circshift(e0{w1, r1, j3(3,1), j3(3,2)}    ,[j1(3,1)-j4(3,1) j1(3,2)-j4(3,2)] ),i255); %window2 LFT screen BLUE

%      i3=ct8(ir1, ig1, ib1); %shift TCA right screen
%      i4=ct8(ir2, ig2, ib2); %shift TCA left screen

     im1=cat(3, ir1, ig1, ib1); %shift TCA right screen
     %contrast
%      if cntrst~=1;
%      i30=double(i3); i31=i30-mxa(i30); i32=cntrst.*i31; i3=uint8(i32+mxa(i30));
%      i40=double(i4); i41=i40-mxa(i40); i42=cntrst.*i41; i4=uint8(i42+mxa(i40));
%      end

     if cntrst~=1;
     i30=im1-mxa(im1); i31=cntrst.*i30; im1=i31+mxa(im1);
     end

     cwin1(im1, im1, cf, rc00, window1, window2);
    end
    
    
    
    [ keyIsDown, keyTime, keyCode ] = KbCheck;
    if keyIsDown
        if keyCode(KbName('RightArrow'))
%             if ey(1)=='R'
%             power_dispR=power_dispR+0.1;
%             elseif ey(1)=='L'
            power_dispL=power_dispL+0.1;
%             end
        elseif keyCode(KbName('LeftArrow'))
%             if ey(1)=='R'
%             power_dispR=power_dispR-0.1;
%             elseif ey(1)=='L'
            power_dispL=power_dispL-0.1;
%             end
        elseif keyCode(KbName('UpArrow'))
            w0=w0+1;
        elseif keyCode(KbName('DownArrow'))
            w0=w0-1;
                        
        elseif keyCode(KbName('ESCAPE')) %| keyCode(KbName('Return'))
            %                     break
            opt_chk=1;
        end
%         if ey(1)=='L'
        opto(name_map('l_disp')).control.setFocalPower(power_dispL);
%         elseif ey(1)=='R'
%         opto(name_map('r_disp')).control.setFocalPower(power_dispR);
%         end
        if w0<1; w0=1; elseif w0>length(s20); w0=length(s20); end
%         disp(['L' n2s2(power_dispL) ' R' n2s2(power_dispR) ' POWER DISPLAY' ' OPT'  n2s(w1) ' 20/' n2s(s20(w1))])
        disp(['L' n2s2(power_dispL) ' POWER DISPLAY' ' OPT'  n2s(w1) ' 20/' n2s(s20(w1))])

        
    end
    % Key debounce routine, which waits for key to be released
    while keyIsDown
        [ keyIsDown, keyTime, keyCode ] = KbCheck;
    end
end