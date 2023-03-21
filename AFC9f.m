%%220508 AFC9f include TCA correction 
% function [v1 t3 dgs]=AFC8f(im_path, v0, sr, window1, window2)
function AFCp=AFC9f(e0, e1, bxyL, bxyR, v0, sr, window1, window2)

%v0 vector of accomodations
%        control: [1×1 Zaber.AsciiDevice]
%     unit_scale: 2.1333e+03
%           move: @(x)zaber(name_map(ident)).control.moveabsolute(x)
%       move_deg: @(x)zaber(name_map(ident)).control.moveabsolute(x*zaber(name_map(ident)).unit_scale)
%        move_mm: []


% function [p1 p2 p3 p4 p5 p6 p7 p8 p9]=AFC0f(im_path, p0, window1, window2)
%p1(k0,:)=[power_dispL power_dispR powerL powerR rot];
global ek uk wk dk zk lk ak rk sk st black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr sz cf rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto ey log
ms=10;
[j4L j3L j2L j1L j0L]=d4i(bxyL, ms); % system+subject TCA
[j4R j3R j2R j1R j0R]=d4i(bxyR, ms); % system+subject TCA

i1=ones(sz); i255=255.*i1;

irL0= embd(circshift(e0{j3L(1,1), j3L(1,2)}    ,[j1L(1,1)-j4L(1,1) j1L(1,2)-j4L(1,2)] ),i255); %window2 LFT screen RED

igL0= embd(circshift(e0{j3L(2,1), j3L(2,2)}    ,[j1L(2,1)-j4L(2,1) j1L(2,2)-j4L(2,2)] ),i255); %window2 LFT screen GREEN

ibL0= embd(circshift(e0{j3L(3,1), j3L(3,2)}    ,[j1L(3,1)-j4L(3,1) j1L(3,2)-j4L(3,2)] ),i255); %window2 LFT screen BLUE
     
irR0= embd(circshift(e0{j3R(1,1), j3R(1,2)}    ,[j1R(1,1)-j4R(1,1) j1R(1,2)-j4R(1,2)] ),i255); %window2 RGT screen RED

igR0= embd(circshift(e0{j3R(2,1), j3R(2,2)}    ,[j1R(2,1)-j4R(2,1) j1R(2,2)-j4R(2,2)] ),i255); %window2 RGT screen GREEN

ibR0= embd(circshift(e0{j3R(3,1), j3R(3,2)}    ,[j1R(3,1)-j4R(3,1) j1R(3,2)-j4R(3,2)] ),i255); %window2 RGT screen BLUE
     
irL1= embd(circshift(e1{j3L(1,1), j3L(1,2)}    ,[j1L(1,1)-j4L(1,1) j1L(1,2)-j4L(1,2)] ),i255); %window2 LFT screen RED

igL1= embd(circshift(e1{j3L(2,1), j3L(2,2)}    ,[j1L(2,1)-j4L(2,1) j1L(2,2)-j4L(2,2)] ),i255); %window2 LFT screen GREEN

ibL1= embd(circshift(e1{j3L(3,1), j3L(3,2)}    ,[j1L(3,1)-j4L(3,1) j1L(3,2)-j4L(3,2)] ),i255); %window2 LFT screen BLUE 
 
irR1= embd(circshift(e1{j3R(1,1), j3R(1,2)}    ,[j1R(1,1)-j4R(1,1) j1R(1,2)-j4R(1,2)] ),i255); %window2 RGT screen RED

igR1= embd(circshift(e1{j3R(2,1), j3R(2,2)}    ,[j1R(2,1)-j4R(2,1) j1R(2,2)-j4R(2,2)] ),i255); %window2 RGT screen GREEN

ibR1= embd(circshift(e1{j3R(3,1), j3R(3,2)}    ,[j1R(3,1)-j4R(3,1) j1R(3,2)-j4R(3,2)] ),i255); %window2 RGT screen BLUE

im2L0=cat(3, irL0, igL0, ibL0); 
im2R0=cat(3, irR0, igR0, ibR0); 
          
im2L1=cat(3, irL1, igL1, ibL1); 
im2R1=cat(3, irR1, igR1, ibR1); 

power_dispR=14.4+sr(2); %starting display power
power_dispL=14+sr(1); %starting display power
opto(name_map('r_disp')).control.setFocalPower(power_dispR);
opto(name_map('l_disp')).control.setFocalPower(power_dispL);

% wn=cwin0(img0, 'Stereo', cf, rc00, window1, window2);
[iLf0 iRf0]=cwin3(im2L0, im2R0, cf, rc00, window1, window2);

%tcpip
log.CRITICAL = 5;
log.ERROR = 4;
log.WARNING = 3;
log.INFO = 2;
log.DEBUG = 1;
log.LEVEL = log.DEBUG;
scene.enable_tcp=0;
scene.trial_num=1;

if scene.enable_tcp
    cmsg('TCP enabled', log.INFO, log.LEVEL);
    scene.tcp_socket = tcpip('169.229.228.75', 31000, 'NetworkRole', 'server');
    cmsg('Waiting for TCP socket connection...', log.INFO, log.LEVEL);
    fopen(scene.tcp_socket);
    cmsg('TCP connected!', log.INFO, log.LEVEL);
end

%[power_dispL power_dispR]=fcs_afc(window1, window2);
%tan=opp/adj
ipd=62./1000; %atand opposite/adjacent devi
%dgs=atand(1./(ipd.*(power_dispL+v0))); %degrees to rotate
%dgs=atand(ipd.*(power_dispL+v0)); %degrees to rotate
dgs=atand(ipd.*v0)./2-3; dgs(dgs<=-3)=-3; %degrees to rotate
dgs0=atand(ipd.*2)./2-3; dgs0(dgs0<=-3)=-3; %degrees to rotate

t0=zeros(length(v0), 6); t1=t0; t2=t0;
% stage) 0stop 1record figure this out with Steve
disp('ready to start');  KbWait([], 2); 
for k0=1:length(v0)

      %wn=cwin0(img1, 'Stereo', cf, rc00, window1, window2);
      [iLf1 iRf1]=cwin3(im2L1, im2R1, cf, rc00, window1, window2);
      opto(name_map('l_disp')).control.setFocalPower(power_dispL-v0(k0));
      opto(name_map('r_disp')).control.setFocalPower(power_dispR-v0(k0));
      zaber(name_map('rotation')).move_deg(dgs(k0)); %%-6400

      %disp( n2s(v0(k0)));        
      fprintf('TRL= %f, L = %f  , R = %f , DEG = %f, Demand = %f\n' ,k0, opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power, (zaber(name_map('rotation')).control.getposition)./2.1333E3, v0(k0) );

      snd(250, 0.25); %pause(2.75);
      KbWait([], 2); 

      if scene.enable_tcp; send_tcp0(scene, 1); end; t0(k0,:)=clock;
      for k1=1:3; snd(1000, 0.2); pause(0.8); end
      if scene.enable_tcp; send_tcp0(scene, 0); end %stage) 0stop 1record
      %pause(3);
      %wn=cwin0(img0, 'Stereo', cf, rc00, window1, window2);
      [iLf0 iRf0]=cwin3(im2L0, im2R0, cf, rc00, window1, window2);
      opto(name_map('l_disp')).control.setFocalPower(power_dispL-2);
      opto(name_map('r_disp')).control.setFocalPower(power_dispR-2);
    %           zaber(name_map('rotation')).move_deg(-3); %%-6400
      zaber(name_map('rotation')).move_deg(dgs0); %%-6400

      t1(k0,:)=clock;

      %snd(2000, 0.25);  pause(2.75);
      pause(3);

      %if scene.enable_tcp; send_tcp0(scene, 0); end %stage) 0stop 1record
      t2(k0,:)=clock;

    scene.trial_num=k0;
end

if scene.enable_tcp; fclose(scene.tcp_socket); end
AFCp.v1=power_dispR
AFCp.t3=cat(3, t0, t1, t2);
AFCp.dgs=dgs;
AFCp.imL0=im2L0;  AFCp.imR0=im2R0;
AFCp.imL1=im2L1;  AFCp.imR1=im2R1;
