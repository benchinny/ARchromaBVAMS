%% Bvams Optical Quality
%function [p11 rv wv wn]=boa(p0, p00, opto, port, name_map, rgd, bxy, ey, window1, window2);
function [p11 rv wv wn]=boa(p0, p00, rgd, bxy, ey, window1, window2);

% 0.00384deg/pixels,  260.417 pixels/degree, 4.34 pixels/arcmin,  0.7234 pixels/arcsec
%display =10 degrees
%FOV=5degrees

%n number of repetitions
%bxy TCA digital correction
%dly optotype presentation time
%ey right, left binocular
%w initial power of optotype base
%rgd pixels to drop
global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi sz cf rc00
n=p0(1); %number of repetitions
w=p0(2); % initial base-power
dly=p0(3);
sd=p0(4);


% 2D/1U done!
% average last N reversals
ms=10; %multisample
b=2; %b base of square root
wv0=[-2:10]; % E optotype base 2 powers
%w=11; %length(wv0)-5;
L='E'; %L optotype
cnt=0;% initialization of 1U/2D
%sz = [1080, 1920]; %sz size of screen
o=round(3.*rand(n,1))+1; %orientation R0 D1 L2 U3
rv=zeros(1,n); %response/reply vector
wv=zeros(1,n); %optotype size vector
xy=round(ms.*bxy);

%% generate pre-stim 20/30 optotype
i00={binv(opt(L, 0))}
s00=4.34.*2; %b.^(w./2);%stroke size
s11=round(5*s00);%optotype size in pixels

if rem(s00, 1)~=0
    i11=dszf(usz(double(i00{1}), s11.*ms), 5); % up down sample + upsample by 10
else
    i11=usz(double(i0{1}), s0.*ms); %upsample + upsample by 10
end
%sca
i22=embd(i11, ones(ms.*sz(1))); %sz(1)=1080
i33=ct3(imgf(dszf(circshift(i22, xy(1,:)), ms), sd));
cls_opt
addpath(genpath(fullfile('toolboxes')));
KbName('UnifyKeyNames');
opn_opt;

%name_map = containers.Map;
%% set/start optotune
    power_dispL=p00(1,1); power_dispR=p00(1,2);
    powerL=p00(2,1); powerR=p00(2,2);
    magL=p00(3,1); magR=p00(3,2);
    rot=p00(4,1);
    %if enable_optotunes
        opto(name_map('l_disp')).control.setFocalPower(power_dispL);
        opto(name_map('l_t_near')).control.setFocalPower(powerL);
        opto(name_map('l_t_far')).control.setFocalPower(powerL);
        opto(name_map('r_disp')).control.setFocalPower(power_dispR);
        opto(name_map('r_t_near')).control.setFocalPower(powerR);
        opto(name_map('r_t_far')).control.setFocalPower(powerR);
    %end
    
    %if enable_trombones
        zaber(name_map('rotation')).move_deg(rot);
        zaber(name_map('l_trombone')).move(l_trombone_f(powerL));
        zaber(name_map('r_trombone')).move(r_trombone_f(powerL));
        zaber(name_map('rotation')).control.waitforidle();
        zaber(name_map('l_trombone')).control.waitforidle();
        zaber(name_map('r_trombone')).control.waitforidle();
    %end


for k0=1:4; i0(k0)={binv(opt(L, k0-1))}; end %R1 U2 L3 D4

for ni=1:n;
    tic
    %for base=2 w=15 is the largest optotype for 1080 pixels
    %w=-5; ms=10; bxy=[0 0; 1.1 7.4; 20.2 15.1]; sd=0; sz=[1080 1920]; ni=7
    s0=b.^(w./2);%stroke size
    s1=round(5*s0);%optotype size in pixels
    
    if rem(s0, 1)~=0
        i1=dszf(usz(double(i0{o(ni)}), s1.*ms), 5); % up down sample + upsample by 10
    else
        i1=usz(double(i0{o(ni)}), s0.*ms); %upsample + upsample by 10
    end
    %sca
    i2=embd(i1, ones(ms.*sz(1))); %sz(1)=1080
    
    %xy=round(ms.*bxy);
    ir=imgf(dszf(circshift(i2, xy(1,:)), ms), sd);
    %ig=imgf(dszf(circshift(i2, xy(2,:)), ms), sd);
    %ib=imgf(dszf(circshift(i2, xy(3,:)), ms), sd);
    iw=ones(sz); %white background to embed optotype in
    ik=zeros(sz); %black background
    %     i3=uint8(255.*cat(3, embd(ir, iw), embd(ig, iw), embd(ib,iw)));
    i3=ct8( embd(ir, iw), embd(ir, iw), embd(ir,iw));
    %i3=ct8( embd(ir, iw), embd(ig, iw), embd(ib,iw));
    
    %i4=uint8(zeros(size(i3)));
    cl3=[1 1 1]; %intermission color
    for k0=1:length(rgd);
        i3(:,:, rgd(k0))=0; %background color
        i33(:,:,rgd(k0))=0;
        cl3(rgd(k0))=0;
    end
    
    
    %% present pre-stim optotype
    wn=cwin0(i33, ey, cf, rc00, window1, window2);
    %p1=[power_dispL power_dispR; powerL powerR; magL magR; rot rot];
     
    %% Control loop
    ListenChar(2);
    try
%         magR=mag; magL=mag;
%         power_dispR=power_disp; power_dispL=power_disp;
        
        opt_chk=0;
        while opt_chk==0;
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown
                if keyCode(KbName('w'))
                    %                      mag = 1.3;
                    magL = magL + 0.01;%changed to 0.1 step size for new quadratic equation, 0.1 step size = 0.02D change in LCA for 8D optotune power and is 0.006D change in LCA for 12.5 D optotune power
                    magR = magR + 0.01;%changed to 0.1 step size for new quadratic equation, 0.1 step size = 0.02D change in LCA for 8D optotune power and is 0.006D change in LCA for 12.5 D optotune power
                elseif keyCode(KbName('z'))
                    magL = magL - 0.01; %0.005 for Austin %0.01 earlier
                    magR = magR - 0.01; %0.005 for Austin %0.01 earlier
                elseif keyCode(KbName('s'))
                    power_dispL=power_dispL+0.1;
                    power_dispR=power_dispR+0.1;
                elseif keyCode(KbName('a'))
                    power_dispL=power_dispL-0.1;
                    power_dispR=power_dispR-0.1;
                elseif keyCode(KbName('p'))
                    rot = rot + .1; % Note this changes rotation stage in degrees
                elseif keyCode(KbName('m'))
                    rot = rot - .1; % Note this changes rotation stage in degrees
                elseif keyCode(KbName('ESCAPE'))
                    %break
                    opt_chk=1;
                end
                
                % Hard-coded limits for magnification
                if magL < 0.8
                    magL = 0.8;
                elseif magL > 1.2
                    magL = 1.2;
                end
                
                if magR < 0.8
                    magR = 0.8;
                elseif magR > 1.2
                    magR = 1.2;
                end
                
                
                fprintf('MagnificationL: %f\n', magL);
                fprintf('MagnificationR: %f\n', magR);
                fprintf('Rotation: %f degrees\n', rot);
                
                opto(name_map('l_disp')).control.setFocalPower(power_dispL);
                opto(name_map('r_disp')).control.setFocalPower(power_dispR);
                fprintf('Display powerL: %f\n', power_dispL);
                fprintf('Display powerR: %f\n', power_dispR);
                
                powerL = mag_to_d(magL);
                powerR = mag_to_d(magR);
                fprintf('Target powerL: %f\n', powerL);
                fprintf('Target powerR: %f\n', powerR);
                
                l_trombone_target = l_trombone_f(powerL);
                r_trombone_target = r_trombone_f(powerR);
                fprintf('Target trombone (left): %u\n', l_trombone_target);
                fprintf('Target trombone (right): %u\n', r_trombone_target);
                
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
                
                fprintf('\n');
            end
            
            % Key debounce routine, which waits for key to be released
            while keyIsDown
                [ keyIsDown, keyTime, keyCode ] = KbCheck;
            end
        end
        
        p11=[power_dispL power_dispR; powerL powerR; magL magR; rot rot];
        
    catch ERROR
        cls_opt
        rethrow(ERROR)
        
    end
    
    t=toc; %w-5=3.1secs w0=3.2secs w7=3.2secs w11=3secs, w15=15sec,
    if o(ni)==1; st=rk; elseif o(ni)==2; st=dk; elseif o(ni)==3; st=lk; elseif o(ni)==4; st=uk; end
    wn=cwin0(i3, ey, cf, rc00, window1, window2);
    disp([ni w s0 s1 t]);% trial, base-power, stroke size, optotype size, time to generate optotype
    startTime=WaitSecs(0);
    %[secs, keyCode, deltaSecs] = KbStrokeWait([], dly);
    [secs, keyCode, deltaSecs] = KbStrokeWait([], startTime+dly);
    %     Screen('FillRect', window1, white);
    %     Screen('FillRect', window2, white);
    
    Screen('FillRect', window1, cl3);
    Screen('FillRect', window2, cl3);
    
    Screen('Flip', window1);     Screen('Flip', window2);
    
    [secs, keyCode, deltaSecs] = KbStrokeWait;
    
    if find(keyCode)==ek; break; %L80 R79 U82 D81
    elseif find(keyCode)==st %L80 R79 U82 D81
        cnt=cnt+1; % taking care of 2D/1U
        %mm=[mm 1]; %memory
        snd(1000, 0.2); % 1000Hz beep 200ms
        rv(ni)=1; wv(ni)=w;
        %wv(ni)=wv0(w);
        
        if cnt==2
            %d=d-ds;
            w=w-1; %d=5*w;
            cnt=0;
        end
    else
        %d=d+ds;
        snd(250, 0.2); %250Hz beep 200ms
        %         wv(ni)=wv0(w);
        wv(ni)=w;
        
        w=w+1; %d=5*w
        %mm=[mm 0]; %memory
        cnt=0;
    end
    %calculate current criterion
    %     if length(mm)>=n
    %         cc=sum(mm(end-n+1:end))/n
    %     end
end
%wf=w
% Clear the screen.
%sca;










% %% Bvams Optical Quality 201022
% function [rv wv wn]=boa(p0, rgd, bxy, ey, window1, window2);
% %function [rv wv wn]=ETM6f(n, w, bxy, dly, ey, window1, window2);
%
% %n number of repetitions
% %bxy TCA digital correction
% %dly optotype presentation time
% %ey right, left binocular
% %w initial power of optotype base
% %rgd pixels to drop
% global ek uk dk lk rk st black white grey screenXpixels screenYpixels xCenter yCenter ifi sz cf rc00
% n=p0(1); %number of repetitions
% w=p0(2); % initial base-power
% dly=p0(3);
% sd=p0(4);
%
%
% % 2D/1U done!
% % average last N reversals
% ms=10; %multisample
% b=2; %b base of square root
% wv0=[-2:10]; % E optotype base 2 powers
% %w=11; %length(wv0)-5;
% L='E'; %L optotype
% cnt=0;% initialization of 1U/2D
% %sz = [1080, 1920]; %sz size of screen
% o=round(3.*rand(n,1))+1; %orientation R0 D1 L2 U3
% rv=zeros(1,n); %response/reply vector
% wv=zeros(1,n); %optotype size vector
%
% for k0=1:4; i0(k0)={binv(opt(L, k0-1))}; end %R1 U2 L3 D4
%
% for ni=1:n;
%     tic
%     %for base=2 w=15 is the largest optotype for 1080 pixels
%     %w=-5; ms=10; bxy=[0 0; 1.1 7.4; 20.2 15.1]; sd=0; sz=[1080 1920]; ni=7
%     s0=b.^(w./2);%stroke size
%     s1=round(5*s0);%optotype size in pixels
%
%     if rem(s0, 1)~=0
%     i1=dszf(usz(double(i0{o(ni)}), s1.*ms), 5); % up down sample + upsample by 10
%     else
%     i1=usz(double(i0{o(ni)}), s0.*ms); %upsample + upsample by 10
%     end
%     %sca
%     i2=embd(i1, ones(ms.*sz(1))); %sz(1)=1080
%
%     xy=round(ms.*bxy);
%     ir=imgf(dszf(circshift(i2, xy(1,:)), ms), sd);
%     %ig=imgf(dszf(circshift(i2, xy(2,:)), ms), sd);
%     %ib=imgf(dszf(circshift(i2, xy(3,:)), ms), sd);
%     iw=ones(sz); %white background to embed optotype in
%     ik=zeros(sz); %black background
% %     i3=uint8(255.*cat(3, embd(ir, iw), embd(ig, iw), embd(ib,iw)));
%     i3=ct8( embd(ir, iw), embd(ir, iw), embd(ir,iw));
%         %i3=ct8( embd(ir, iw), embd(ig, iw), embd(ib,iw));
%
%     %i4=uint8(zeros(size(i3)));
%     cl3=[1 1 1]; %intermission color
%     for k0=1:length(rgd);
%         i3(:,:, rgd(k0))=0; %background color
%         cl3(rgd(k0))=0;
%     end
%
%     t=toc; %w-5=3.1secs w0=3.2secs w7=3.2secs w11=3secs, w15=15sec,
%     if o(ni)==1; st=rk; elseif o(ni)==2; st=dk; elseif o(ni)==3; st=lk; elseif o(ni)==4; st=uk; end
%
%    wn=cwin0(i3, ey, cf, rc00, window1, window2);
%    disp([ni w s0 s1 t]);% trial, base-power, stroke size, optotype size, time to generate optotype
%     startTime=WaitSecs(0);
%     %[secs, keyCode, deltaSecs] = KbStrokeWait([], dly);
%     [secs, keyCode, deltaSecs] = KbStrokeWait([], startTime+dly);
% %     Screen('FillRect', window1, white);
% %     Screen('FillRect', window2, white);
%
%     Screen('FillRect', window1, cl3);
%     Screen('FillRect', window2, cl3);
%
%     Screen('Flip', window1);     Screen('Flip', window2);
%
%     [secs, keyCode, deltaSecs] = KbStrokeWait;
%
%     if find(keyCode)==ek; break; %L80 R79 U82 D81
%     elseif find(keyCode)==st %L80 R79 U82 D81
%         cnt=cnt+1; % taking care of 2D/1U
%         %mm=[mm 1]; %memory
%         snd(1000, 0.2); % 1000Hz beep 200ms
%         rv(ni)=1; wv(ni)=w;
%         %wv(ni)=wv0(w);
%
%         if cnt==2
%             %d=d-ds;
%             w=w-1; %d=5*w;
%             cnt=0;
%         end
%     else
%         %d=d+ds;
%         snd(250, 0.2); %250Hz beep 200ms
% %         wv(ni)=wv0(w);
%           wv(ni)=w;
%
%         w=w+1; %d=5*w
%         %mm=[mm 0]; %memory
%         cnt=0;
%     end
%     %calculate current criterion
% %     if length(mm)>=n
% %         cc=sum(mm(end-n+1:end))/n
% %     end
% end
% %wf=w
% % Clear the screen.
% %sca;
%
%
%
%
%
%
