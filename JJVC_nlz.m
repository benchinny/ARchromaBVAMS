%% CSF

a0=0; %a7=h0, a8=h1
%a9=psfs(h0, h1, g1+a0, 0);
a9=psf_CSF(h0, h1, g0(2), g1+a0, 0);

% a9=psfs(a7, a8, a6+a0, 0);

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c rc00
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data']); addpath([pwd '\psignifit-master']);

        %a0=3.3; %  system TCA horizontal shift
        %load S10004_CSF_Left_ACL0_2104071255.mat %load first data set
        load S10004_CSF_Left_ACL0_2104091110.mat
        a80=a8; a70=a7; a60=a6; %create copy/dummy variables 
        
        load S10004_CSF_Left_ACL0_2104071317.mat %load 2nd data set
       
        a81=zeros(size(a80)); a71=zeros(size(a70)); %create dummy vars
        
        %%arrange data according to 2nd data set order 
        for k0=1:length(a6);
            a61=find(a6(k0)==a60);
            a81(k0,:)=a80(a61,:)
            a71(k0,:)=a70(a61,:)       
        end 
        %% run the entire forloop before proceeding
       a8=[a81 a8]; a7=[a71 a7]; %combine data from both experiments
                 a9=psfs(a7, a8, a6+a0, 0);
                 
                 %%% one set
                   a0=2.5785; %  system TCA horizontal shift
        load S10003_CSF_Right_ACL1_2104021455.mat %load first data set
        load S10004_CSF_Left_ACL0_2104091110
         a9=psfs(a7, a8, a6+a0, 0);
         
 %% ETM
 
 %         %% first step to analyze
                c0=0.00384; %deg/pixels
                c1=1./(c0.*60); % pixels/arcmin
                w3=w2; rc=size(w2); for r=1:rc(1); for c=1:rc(2); w3(r, c)=STK(w2(r,c)); end; end;
                w4=20.*w3./c1; 20.*STK./c1
%         %% end of first step
%                 strc(y0, w4, [mna(20.*STK./c1) mxa(20.*STK./c1)]); %step 2: show staircase
%                 strc(y0, w4, [mna(20.*STK./c1) mxa(w4)]); %step 2: show staircase
% % % 
%                   d1=5; [r0 r1]=psf(y0, y1, w2, d1, STK); %step3 psignfit individual experiments
%                    d1=5; [r00 r11]=psfa(y0, y1, w2, d1, STK); %%step4 psignfit combined
                 %d1=5; y0=[0 0]; [r00 r11]=psfa(y0, y1, w2, d1, STK); %step4 psignfit for green background
%  y0=[0 0 0 0]; [r00 r11]=psfa(y0, y1, w2, d1, STK); 

%210520 FRNGS
for k0=1:8; n1(k0)=sum(n0(m0==k0)); n2(k0)=sum(m0==k0);  end; [1:8; n1; n2]

% %210520 FRNGS
% rsp=(rsp==0); %run only once after loading!
% for k0=1:4; r=rsd(1,:)==k0; r0(k0)=sum(r); r1(k0)=sum(rsp(r));  end %1up 2right 3down 4left %
% 
% % s0=rsd(1,:)+4.*(rsd(2,:)-1);
% % for k0=1:8; s=(s0==k0); s1(k0)=sum(s); s2(k0)=sum(rsp(s));  end %1up 2right 3down 4left %

%210521 CNT
       %y0 up/down responses
        %y1 disparities 
        %y2   invert responses
        %y3 up1 buttom0 blue/disparity
        [rslt d0]=psfn(y1, y2);
        
 %210525 fgr_ETM ETM data for paper
cls; w22=[]; y00=[]; y11=[]; 
for k0=1:length(a0)
    load(a0(k0));
    w22=[w22; w2]; y11=[y11; y1]; y00=[y00 y0];    
end
w2=w22; y1=y11; y0=y00;

d1=5; [r00 r11]=psfa(y0, y1, w2, d1, STK00); %%step4 psignfit combined
d1=5; y0=zeros(size(y0)); [r00 r11]=psfa(y0, y1, w2, d1, STK00); %step4 psignfit for green background
 





 