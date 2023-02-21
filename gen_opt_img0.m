%% generate optotype image with TCA correction

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz rc00
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']); 
cls
c0=0.00384; %deg/pixels
c1=1./(c0.*60);
bxy=z1;
ms=10; % downsampling factor
r1=4; % right standing E optotype
w1=7; % initial optotype size.

%% LCA params
p0=zeros(8,2) ;
% %if set power_disp/optopower=0 randomize.
% p0(1,:)=[8                    8];               %power_dispL_min      power_dispR_min
% p0(2,:)=[1000./75+1/0.789     1000/75+1/0.789]; %power_dispL          power_dispR   
% p0(3,:)=[25                   25];              %power_dispL_max      power_dispL_max                   
% p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p0(5,:)=[opL(1)               opR(1)];          %L_optopower(mag)     R_optopower(mag)     
% p0(6,:)=[opL(1.2)             opR(1.2)];        %L_optopower(mag)_max R_optopower(mag)_max
% p0(7,:)=-3; %rotation
% p0(8,:)=10; %number of repetitions  

% marty settings nov 24th
p0(1,:)=[9                   9];               %power_dispL_min      power_dispR_min
% p0(2,:)=[12.2717     13.40192]; %power_dispL11.27175          power_dispR 12.80192  
p0(3,:)=[17                  17];              %power_dispL_max      power_dispL_max                   
p0(4,:)=[opL(0.8)             opR(0.8)];        %L_optopower(mag)_min R_optopower(mag)_min         
% p0(5,:)=[8.7838            8.9288];          %L_optopower(mag)     R_optopower(mag)     
p0(6,:)=[opL(1.3)             opR(1.3)];        %L_optopower(mag)_max R_optopower(mag)_ma   x
p0(7,:)=-3; %rotation
p0(8,:)=10; %number of repetitions  
% p0(2,:)=[12.2717     13.4019 ]; %power_dispL 11.27175          power_dispR  12.80192 
% p0(5,:)=[9.8896    9.8375];
p0(2,:)=[14.379142    14.379142]; %AR 
p0(5,:)=[9.406237    9.406237];
% p0=p4; run after loading LCA file
sz = [1080, 1920];
zbr=1; %activate zebar/optotune 
rc00=[0 0; 0 0];
 cf=ones(3,2); %to show white background
% cf=[0 0; 1 1;0 0]; %to show green bkg
i1=ones(sz);
%if exist(  'E10c')==0 | isempty(E10c)==1; load('E_b3_p1_p13_o4_ms10_201123.mat'); end ; e0=E10c;%E optotype base 3
if exist('E10c')==0 | isempty(E10c)==1; load('E_b2s4_p1_p13_o4_ms10_201130.mat');  end %E optotype base 4 17secs to load
e0=E10c;
disp(['OPTOTYPE 20/' n2s(20.*STK(w1)./c1)]);

screens = Screen('Screens');
screenNumber = max(screens);
[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, 'ETM'); %add background parameter!



[j4 j3 j2 j1 j0]=d4i(bxy, ms); % number to integer and decimal
%  
     %r1=round(3.*rand)+1; %orientation 1U 2L 3D 4R
     %if r1==1; r2=KbName('DownArrow'); elseif r1==2; r2=KbName('LeftArrow'); elseif r1==3; r2=KbName('UpArrow'); elseif r1==4; r2=KbName('RightArrow'); end
     %ir=embd(e0{w1, r1, 1, 1},i1); %red primer
     
     ir2= embd(circshift(e0{w1, r1, j3(1,1), j3(1,2)}    ,[j1(1,1)-j4(1,1) j1(1,2)-j4(1,2)] ),i1); %window2 LFT screen RED
     ir1= embd(circshift(e0{w1, r1, j3(1,3), j3(1,4)}    ,[j1(1,3)-j4(1,3) j1(1,4)-j4(1,4)] ),i1); %window1 RGT screen RED

     ig2= embd(circshift(e0{w1, r1, j3(2,1), j3(2,2)}    ,[j1(2,1)-j4(2,1) j1(2,2)-j4(2,2)] ),i1); %window2 LFT screen GREEN
     ig1= embd(circshift(e0{w1, r1, j3(2,3), j3(2,4)}    ,[j1(2,3)-j4(2,3) j1(2,4)-j4(2,4)] ),i1); %window1 RGT screen GREEN

     ib2= embd(circshift(e0{w1, r1, j3(3,1), j3(3,2)}    ,[j1(3,1)-j4(3,1) j1(3,2)-j4(3,2)] ),i1); %window2 LFT screen BLUE
     ib1= embd(circshift(e0{w1, r1, j3(3,3), j3(3,4)}    ,[j1(3,3)-j4(3,3) j1(3,4)-j4(3,4)] ),i1); %window1 RGT screen BLUE

         i3=ct8(ir1, ig1, ib1); %shift TCA right screen
         i4=ct8(ir2, ig2, ib2); %shift TCA left screen
         
        p1=LCAfcs(i4, i3, p0, window1, window2);
        
        
%                 for k0=1:length(LCAim)
%            p2(k0,:)=mean(p1(p1(:,6)==k0,:),1)
%             p3(k0,:)=std(p1(p1(:,6)==k0,:), 0, 1) 
%         end
%              
%              
%                       if strcmp(ey,'Right') 
%             [p3,flag]=set_opt_RightEye(p0(:,2), p2, magn); %gives optotune settings for Right eye only usign defocus adjustments from subject, i.e 2nd column in p0
%             %Nadav:add line to save p3 for the subject-> Sub_OptSettings_RightEye_NoAcl_Date
%             p4=[p0(:, 1) p3];  %first column for left eye
%         elseif strcmp(ey,'Left') 
%             [p3,flag]=set_opt_LeftEye(p0(:,1), p2, magn);
%             p4=[p3 p0(:,2)]; 
%             %Nadav:add line to save p4 for subject--> Sub_OptSettings_LeftEye_NoACL_Date
%             %Nadav:load saved p3 for right eye from above
%             
%             %LEFT SIDE IS GIVING YOU IMAGINERY VALUES
%            
%         end
%         %p5=[p4 p3];
%         opt0(p4,flag);
%          
          sca
         
         

 