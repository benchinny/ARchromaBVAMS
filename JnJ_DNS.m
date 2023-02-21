




%%220429 diagnosis for JnJ

clear LCAim
[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 0);

%%input a output b
cf=ones(3,2);
mag=1.4;
powerL=opL(mag); powerR=opR(mag)
            opto(name_map('l_t_near')).control.setFocalPower(powerL); %[6.8400 24.9500]
            opto(name_map('l_t_far')).control.setFocalPower(powerL); %[7.2400 27.2950]
            %zaber(na444me_map('l_trombone')).move(l_trombone_f(powerL));%[8.619 13.8]
            zaber(name_map('l_trombone')).move(l_trombone_f(powerL));%[8.619 13.8]
            zaber(name_map('l_trombone')).control.waitforidle();

            opto(name_map('r_t_near')).control.setFocalPower(powerR); %[6.8550 25.2250]
            opto(name_map('r_t_far')).control.setFocalPower(powerR); %[7.2400 27.2950]
%             zaber(name_map('r_trombone')).move(r_trombone_f(powerR)); %[7 20]
            zaber(name_map('r_trombone')).move(r_trombone_f(powerR)); %[7 20]
            zaber(name_map('r_trombone')).control.waitforidle();



%initial  power=13.5 AR
%LCAim='texture0_1080_newfill_malt.png';
%im2R='blac  k.png';
im2L='texture0_1080_newfill_malt.png';
im2R=im2L ;iLR=imread(im2L); iLR(:,:,[1 3])=0;

deg=-3; dgs=-3;
zaber(name_map('rotation')).move_deg(deg); %%-6400
zaber(name_map('rotation')).control.getposition

if exist('sr') ~=  1; sr=[0 0]; end
dmnd0=0;  ipd=62./1000; stpSz=0.05 %[-0.5:0.5:3]


%[iLf iRf]=cwin3(imread(im2L), imread(im2R) , cf, rc00, window2, window1);
[iLf iRf]=cwin3(iLR, iLR , cf, rc00, window2, window1);

%         for k0=1:length(dmnd)
ext=0; dmnd1=dmnd0;
while ext==0
    opto(name_map('r_disp')).control.setFocalPower(14.4+sr(2)-dmnd1);%-dmnd(k0));
    opto(name_map('r_disp')).control.getFocalPower.focal_power;
    
    opto(name_map('l_disp')).control.setFocalPower(14+sr(1)-dmnd1);%-dmnd(k0));
    opto(name_map('l_disp')).control.getFocalPower.focal_power;
    
%     dgs=atand(ipd.*dmnd1)./2-3; dgs(dgs<=-3)=-3;%degrees to rotate
%     zaber(name_map('rotation')).move_deg(dgs); %%-6400
%     zaber(name_map('rotation')).control.getposition;
    
    %[keyIsDown,secs, kc] = KbCheck;
        disp(['DMND' n2s(dmnd1) ' DSPfcsL' n2s(opto(name_map('l_disp')).control.getFocalPower.focal_power) ' DSPfcsR' n2s(opto(name_map('r_disp')).control.getFocalPower.focal_power) ' DGRS' n2s(dgs)]);
    [secs, kc, deltaSecs] = KbStrokeWait;
    
    KbName('UnifyKeyNames');
    if kc(KbName('6')); %kc(rk)
        dmnd1=dmnd1+stpSz;
        chk=0;
    elseif kc(KbName('4')); %kc(lk);
        dmnd1=dmnd1-stpSz;
        chk=0;
    elseif kc(KbName('ESCAPE')) & chk == 0; %find(KeyCode)==ek
        ext=true; chk=1;
    elseif kc(KbName('Return')) & chk == 0; %find(KeyCode)==ek
        ext=true; chk=1;
        % else
        %     disp('WRONG KEY'); snd(100, 0.25);
    end
    
    
    %disp(['DMND' n2s(dmnd1) ' DSPfcsL' n2s(opto(name_map('l_disp')).control.getFocalPower.focal_power) ' DSPfcsR' n2s(opto(name_map('r_disp')).control.getFocalPower.focal_power) ' DGRS' n2s(dgs)]);
    %KbWait([], 2);
end
%img=imread(LCAim); %% image to show
%wn=cwin0(img, 'Stereo', cf, rc00, window1, window2);

    opto(name_map('r_disp')).control.setFocalPower(14.4+sr(2));%-dmnd(k0));
    opto(name_map('r_disp')).control.getFocalPower.focal_power;
    
    opto(name_map('l_disp')).control.setFocalPower(14+sr(1));%-dmnd(k0));
    opto(name_map('l_disp')).control.getFocalPower.focal_power;

    zaber(name_map('rotation')).move_deg(-3); %%-6400
    zaber(name_map('rotation')).control.getposition;

%KbWait([], 2);
clear LCAim
sca







