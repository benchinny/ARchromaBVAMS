%220105 for JnJ_TCA including spherical refraction and minipad keycode
%function [xy4 n4 y6]=TCA13f(fnm, xy0, rgb, p0, p5, window1, window2);
function bTCA=TCA14f(fnm, xy0, rgb, p0, p5, sr, window1, window2);

%function [xy4 n4]=TCA7f(fnm, xy0, xy1, rgb, p0, p5, window1, window2);

%function xy4=TCA2f(fname, rkc, pp, ey ,window1, window2);
%think about making fname a variable instead of a file to load;

% function bxy=TCA2f(vd, lineWidthPix, pixelsPerPress, ey, vbl0, window1, window2);

% clear all
% close all
% clc
global snt sp kntr ifi cf sz rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto ey

% global ek uk dk lk rk snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi cf sz
%108 pix/degree
%display =10 degrees
%FOV=5degrees
%pp=[1 0.1];

p4=p5(1); chk=0; %step size
p3=p4; % initial step size
load(fnm);
ms=p0(1); %antialiasing/supersamling factor
n0=p0(2); %repetitions

addpath(genpath(fullfile('toolboxes')));
KbName('UnifyKeyNames');



n1=n0.*size(rgb,1); %total length of trials and conditions
n2=randperm(n1)./n1; %randomizing the conditions
n3=fct(size(rgb,1)); %fractions
%n4=(((-1).^[1:n1])>0)+1; %1 2 1 2 1 2 1 2 1 2
n4=repmat([1:size(rgb,1)], [1 n0]);

i0=uint8(zeros(sz));
i1=uint8(255.*ones(size(m_bkg)));
s0=[1 2]; s1=1; % [right left] screen keyboard control starting with the right screen

%load('TCA_E10c.mat', 'T10c'); %7pixels
Efcs=fcs_clr0(7, 2, window1, window2);
% opto(name_map('l_disp')).control.setFocalPower((14+sr(1)));
% opto(name_map('r_disp')).control.setFocalPower((14.4+sr(2)));
% zaber(name_map('rotation')).move_deg(-3); %%-6400

% for k0=1:n0;
snd(500, 0.2); %prime subject about upcoming stimulus
for k0=1:n1;
    while p3~=p4
        p5=circshift(p5,[0 1]); p4=p5(1);
    end
    
    b=uint8(zeros([sz 3]));
    xy=round(rand(1,2).*xy0.*2)-xy0;
    im=m_bkg-circshift(m_crc{1,1}, xy); % background image;
    ic= circshift(m_crc{1,1}-(i1-m_crs{1,1}), xy);% center image
    %imshow(cat(3, im, i0, ic))
    %b=cat(3, embd(im, i0), i0, embd(ic, i0));
    b(:, :, rgb(n4(k0),1))=embd(ic, i0);
    b(:, :, rgb(n4(k0),2))=embd(im, i0);
    %    b(:,:,3)=embd(b_bkg, i0);
    b1=b; b2=b; xy=[xy; xy];
    
    ext=0;
    while ext == 0; %false; %find(KeyCode)~=ek
        
        cwin1(b1, b2, cf, rc00, window1, window2);
        %disp([x3r y3r x3l y3l; x2r y2r x2l y2l; x1r y1r x1l y1l]);
        [keyIsDown,secs, kc] = KbCheck;
        %[secs, keyCode, deltaSecs] = KbWait([deviceNumber][, forWhat=0][, untilTime=inf])
        %[keyIsDown, secs, keyCode, deltaSecs] = KbCheck([deviceNumber])
        %[secs, kc, deltaSecs] = KbStrokeWait;
        %kbcTCA0; %adjust keyboard press
        kbcTCA2; %adjust keyboard press equall both screens
        
        %         xr=xy(1,1)+xy1(2,1); yr=xy(1,2)+xy1(2,2);
        %         xl=xy(2,1)+xy1(1,1); yl=xy(2,2)+xy1(1,2);
        %
        
        xr=xy(1,1); yr=xy(1,2);
        xl=xy(2,1); yl=xy(2,2);
        %         % decimal integer correct
        [x1r x2r x3r]=d2i(xr, ms);
        [y1r y2r y3r]=d2i(yr, ms);
        
        [x1l x2l x3l]=d2i(xl, ms);
        [y1l y2l y3l]=d2i(yl, ms);
        
        
        
        %correct decimal for negative values
        %v0=[1 10 9 8 7 6 5 4 3 2];
        v0=[10:-1:1];
        
        x1r=x1r+1; if x3r<0; x1r=v0(x1r); end
        y1r=y1r+1; if y3r<0; y1r=v0(y1r); end
        
        x1l=x1l+1; if x3l<0; x1l=v0(x1l); end
        y1l=y1l+1; if y3l<0; y1l=v0(y1l); end
        
        xy(1,1)=x3r; xy(1,2)=y3r;
        xy(2,1)=x3l; xy(2,2)=y3l;
        
        s2=['R' 'L'];
        %        disp(['EXP' n2s(k0) ' L_EYE DOWN' n2s(x3l) ' RIGHT' n2s(y3l) ' R_EYE DOWN' n2s(x3r) ' RIGHT' n2s(y3r) ' RES' n2s(p4)  ' ' s2(s1)]);
        %        disp(['EXP' n2s(k0) ' L_EYE DOWN' n2s(x3l) ' RIGHT' n2s(y3l) ' R_EYE DOWN' n2s(x3r) ' RIGHT' n2s(y3r) ' RES' n2s(p4)  ' ' s2(s1)]);
        %        disp(['EXP' n2s(k0) ' Y' n2s(x3r) ' X' n2s(y3r) ' RES' n2s(p4)  ' ' s2(s1)]);
        disp(['EXP' n2s(k0) ' Y' n2s(x3r) ' X' n2s(y3r) ' RES' n2s(p4)  ' ' ey]);
        
        
        
        bcr=circshift(m_crc{x1r, y1r}, [x2r y2r]);
        bcl=circshift(m_crc{x1l, y1l}, [x2l y2l]);
        
        bsr=circshift(i1-m_crs{x1r, y1r}, [x2r y2r]);
        bsl=circshift(i1-m_crs{x1l, y1l}, [x2l y2l]);
        
        bgr= m_bkg-(bcr+b_bkg);
        bgl= m_bkg-(bcl+b_bkg);
        
        bcr=(bcr-bsr).*uint8(bcr~=0);
        bcl=(bcl-bsl).*uint8(bcl~=0);
        clear bsr bsl;
        
        b1(:, :, rgb(n4(k0), 1))=embd(bcr, i0); %right front circle
        b1(:, :, rgb(n4(k0), 2))=embd(bgr, i0); %right background circle
        
        b2(:, :, rgb(n4(k0), 1))=embd(bcl, i0); %left front circle
        b2(:, :, rgb(n4(k0), 2))=embd(bgl, i0); %left background circle
        
        b1(:,:,3)=b1(:,:,3)+embd(b_bkg,i0); b2(:,:,3)=b2(:,:,3)+embd(b_bkg,i0);
        
        
        clear bcl bcr bgl bgr;
        
    end
    xy4(k0, :)=[x3l y3l x3r y3r]; %n5=n4(1:k0);
   
    y6=[opto(name_map('l_disp')).control.getFocalPower.focal_power   opto(name_map('r_disp')).control.getFocalPower.focal_power;...
        opto(name_map('l_t_near')).control.getFocalPower.focal_power opto(name_map('r_t_near')).control.getFocalPower.focal_power;...
        opto(name_map('l_t_far')).control.getFocalPower.focal_power  opto(name_map('r_t_far')).control.getFocalPower.focal_power;...
        zaber(name_map('l_trombone')).control.getposition            zaber(name_map('r_trombone')).control.getposition;...
        zaber(name_map('rotation')).control.getposition              0];
    
    
    save('JnJ\TCAtmp.mat', 'xy4', 'rgb', 'n4', 'y6');
    %         load('TCAtmp.mat'); bxy=xy4; v0=n5;
    %         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
    %         z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
    %           if sv==1; save(['data\S' num2str(sn) '_TCA_' tme], 'bxy','rgb', 'v0'); end
    %            clear bxy v0
    %
    %          sv=1; sn=10007; % subject number
    %         load('TCAtmp.mat'); bxy=xy4; v0=n4(1:size(xy4,1));
    %         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
    %         z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
    %           if sv==1; save(['data\S' num2str(sn) '_TCA_' tme], 'bxy','rgb', 'v0'); end
    %            clear bxy v0
    
    
    %     xy4(k0, :)=[x3r y3r x3l y3l];
    %ETM input 3 by 4bxy: [R G B] by [Lx Ly Rx Ry ]
end
%[bxy v0 y6]
%[xy4 n4 y6] 
 bTCA.bxy=xy4;
 bTCA.v0=n4;
 bTCA.y6=y6;
% function [xy4 n4]=TCA7f(fnm, xy0, xy1, rgb, p0, p5, window1, window2);
%
% %function xy4=TCA2f(fname, rkc, pp, ey ,window1, window2);
% %think about making fname a variable instead of a file to load;
%
% % function bxy=TCA2f(vd, lineWidthPix, pixelsPerPress, ey, vbl0, window1, window2);
%
% % clear all
% % close all
% % clc
% global snt sp kntr ifi cf sz rc00
%
% % global ek uk dk lk rk snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi cf sz
% %108 pix/degree
% %display =10 degrees
% %FOV=5degrees
% %pp=[1 0.1];
%
% p4=p5(1); chk=0; %step size
% p3=p4; % initial step size
% load(fnm);
% ms=p0(1); %antialiasing/supersamling factor
% n0=p0(2); %repetitions
%
% n1=n0.*size(rgb,1); %total length of trials and conditions
% n2=randperm(n1)./n1; %randomizing the conditions
% n3=fct(size(rgb,1)); %fractions
% n4=zeros(size(n2)); %trials and conditions vector
% for k0=2:length(n3);
%     n4=(k0-1).*((n3(k0-1)< n2) & (n2 <= n3(k0)))+n4; % think about how to turn this into a function segmentation=sgt
% end
% i0=uint8(zeros(sz));
% i1=uint8(255.*ones(size(m_bkg)));
% s0=[1 2]; s1=1; % [right left] screen keyboard control starting with the right screen
%
% % for k0=1:n0;
% for k0=1:n1;
%      while p3~=p4
%           p5=circshift(p5,[0 1]); p4=p5(1); %initalize step size
%      end
%
%     b=uint8(zeros([sz 3]));
%     xy=round(rand(1,2).*xy0.*2)-xy0;
%     im=m_bkg-circshift(m_crc{1,1}, xy); % background image;
%     ic= circshift(m_crc{1,1}-(i1-m_crs{1,1}), xy);% center image
%     %imshow(cat(3, im, i0, ic))
%     %b=cat(3, embd(im, i0), i0, embd(ic, i0));
%     b(:, :, rgb(n4(k0),1))=embd(ic, i0);
%     b(:, :, rgb(n4(k0),2))=embd(im, i0);
%     b1=b; b2=b; xy=[xy; xy];
%
%     ext=0;
%     while ext == 0; %false; %find(KeyCode)~=ek
%
% %         cwin2(b1, b2, cf, rc00, window1, window2);
%         cwin2(b1, b2, cf, window1, window2);
%
% %disp([x3r y3r x3l y3l; x2r y2r x2l y2l; x1r y1r x1l y1l]);
%         [keyIsDown,secs, kc] = KbCheck;
% %[secs, keyCode, deltaSecs] = KbWait([deviceNumber][, forWhat=0][, untilTime=inf])
% %[keyIsDown, secs, keyCode, deltaSecs] = KbCheck([deviceNumber])
%         %[secs, kc, deltaSecs] = KbStrokeWait;
% %         kbcTCA0; %adjust keyboard press
%           kbcTCA1; %adjust keyboard press control both screens equally
%
%
%
%         xr=xy(1,1)+xy1(2, 1); yr=xy(1,2)+xy1(2, 1);
%         xl=xy(2,1)+xy1(1,1); yl=xy(2,2)+xy1(1, 2);
%         % decimal integer correct
%         [x1r x2r x3r]=d2i(xr, ms);
%         [y1r y2r y3r]=d2i(yr, ms);
%
%         [x1l x2l x3l]=d2i(xl, ms);
%         [y1l y2l y3l]=d2i(yl, ms);
%
%
%         %correct decimal for negative values
%         %v0=[1 10 9 8 7 6 5 4 3 2];
%         v0=[10:-1:1];
%
%         x1r=x1r+1; if x3r<0; x1r=v0(x1r); end
%         y1r=y1r+1; if y3r<0; y1r=v0(y1r); end
%
%         x1l=x1l+1; if x3l<0; x1l=v0(x1l); end
%         y1l=y1l+1; if y3l<0; y1l=v0(y1l); end
%
%         xy(1,1)=x3r; xy(1,2)=y3r;
%         xy(2,1)=x3l; xy(2,2)=y3l;
%
%         s2=['R' 'L'];
%         disp(['EXP' n2s(k0) ' LEFT X' n2s(x3l) ' Y' n2s(y3l) ' RIGHT X' n2s(x3r) ' Y' n2s(y3r) ' RES' n2s(p4)  ' ' s2(s1)]);
%
%
%         bcr=circshift(m_crc{x1r, y1r}, [x2r y2r]);
%         bcl=circshift(m_crc{x1l, y1l}, [x2l y2l]);
%
%         bsr=circshift(i1-m_crs{x1r, y1r}, [x2r y2r]);
%         bsl=circshift(i1-m_crs{x1l, y1l}, [x2l y2l]);
%
%         bgr= m_bkg-bcr;
%         bgl= m_bkg-bcl;
%
%         bcr=(bcr-bsr).*uint8(bcr~=0);
%         bcl=(bcl-bsl).*uint8(bcl~=0);
%         clear bsr bsl;
%
%         b1(:, :, rgb(n4(k0), 1))=embd(bcr, i0); %right front circle
%         b1(:, :, rgb(n4(k0), 2))=embd(bgr, i0); %right background circle
%
%         b2(:, :, rgb(n4(k0), 1))=embd(bcl, i0); %left front circle
%         b2(:, :, rgb(n4(k0), 2))=embd(bgl, i0); %left background circle
%         clear bcl bcr bgl bgr;
%
%     end
%         xy4(k0, :)=[x3l y3l x3r y3r]; %n5=n4(1:k0);
%         save('data\TCAtmp.mat', 'xy4', 'rgb', 'n4');
% %         load('TCAtmp.mat'); bxy=xy4; v0=n5;
% %         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
% %         z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
% %           if sv==1; save(['data\S' num2str(sn) '_TCA_' tme], 'bxy','rgb', 'v0'); end
% %            clear bxy v0
% %
% %          sv=1; sn=10007; % subject number
% %         load('TCAtmp.mat'); bxy=xy4; v0=n4(1:size(xy4,1));
% %         z1=[0 0 0 0;   mean(bxy(v0==2,:),1); mean(bxy(v0==1,:),1)]; %input for ETM: [R G B] by [xL yL xR yR]
% %         z2=[0 0 0 0;   std(bxy(v0==2,:),0,1); std(bxy(v0==1,:),0,1)]; %input for ETM: [R G B] by [xL yL xR yR]
% %           if sv==1; save(['data\S' num2str(sn) '_TCA_' tme], 'bxy','rgb', 'v0'); end
% %            clear bxy v0
%
%
% %     xy4(k0, :)=[x3r y3r x3l y3l];
%     %ETM input 3 by 4bxy: [R G B] by [Lx Ly Rx Ry ]
% end
