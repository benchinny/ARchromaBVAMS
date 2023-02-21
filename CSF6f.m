%present 2AFC gabor stimuli
% function [r2 c2]=CSF3f(ni, n4, f, s, d0, a00, s2, window1, window2);
function [r2 c2 s3]=CSF6f(x0, s2, window1, window2);
%global snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
global snt sp kntr ifi cf sz rc00 name_map l_trombone_f r_trombone_f l_opto_f r_opto_f  enable_optotunes enable_trombones zaber opto ey
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% cls
ni=x0(1); % ni=40; %n0 number of trials
f=x0(2); % f=2*73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
s=x0(3); % s= 100; %gaussian  sigma
d0=x0(4);% d0=1.6; %contrast step size
a00=x0(5)% a00=10; %angle of image tilt
d00=x0(6); %initial contrast 
% % bxy=[0 0; 37 37; 20 20]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
% %bxy=[0 0; 0 0;0 0]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
% s2=-6:2:6; %ffTCA shift of green plane f
%s2=[-0.25 0 0.5]
%'a*x^b'
%RED a=58.05 b=2.473
%GREEN a=174.8 b=2.501
%BLUE a=17.47 b=2.431

KbName('UnifyKeyNames')
%% LEFT screen
% a1=[58.05 174.8 17.47]; %a gamma correcion
% n1=[2.473 2.501 2.431]; %ones(1,3).*2.33;
%RIGHT SCREEN
% a1=[56.42 164.1 17.89]; %a gamma correction
% n1=[2.458 2.611 2.482]; %ones(1,3).*2.33;
%[LEFT RIGHT]
a0=[58.05 174.8 17.47; 56.42 164.1 17.89];
n0=[2.473 2.501 2.431; 2.458 2.611 2.482];

%n2=(a1.*1.^n1); n3= 255.*((n2./a1).^(1./n1));
n2=(a0.*1.^n0); n3= 255.*((n0./a0).^(1./n0));
%focus on green optotype!
 cf=0.6.*ones(3,2); E_fnl=fcs_clr(7, 2, window1, window2);   cf=ones(3,2);


    n2=n2(:,3).*ones(2,3); %set equiluminance for RED-BLUE
    %n2=n2(3).*ones(1,3); %set equiluminance  for RED-BLUE
    cf(2,:)=0; %turn off primer 1RED 2GREEN 3BLUE
    
    %get gamma correctted values (n2./a0).^(1./n0)
    %L0.6153    0.3982    1.0000
    %R0.6267    0.4279    1.0000  
    
    

sz = [1080, 1920]; % size of screen

%responses
chk=0; %%reduce step size every two reversals


clear i1 i1L i1R
i0=gbr0([f 0 100], sz);  
for k0=1:length(s2); 
    
    i1{k0}=gbr0([f s2(k0) 100], sz); 
    i1L{k0}=cat(3, n2(1,1).*i0, zeros(sz),  n2(1,3).*i1{k0});
    i1R{k0}=cat(3, n2(2,1).*i0, zeros(sz),  n2(2,3).*i1{k0});
end

for k0=1:3 
%             i3(:,:,k0)=255.*(i2(:,:,k0)./a1(k0)).^(1./n1(k0)); 
            i5R(:,:,k0)=255.*((n2(1,1)./2).*ones(sz)./a0(2,k0)).^(1./n0(2,k0)); 
            i5L(:,:,k0)=255.*((n2(2,1)./2).*ones(sz)./a0(1,k0)).^(1./n0(1,k0)); 
 end ; %working

%% focus on green optotype
 
i0=ct3(zeros(sz));
snd(500, 0.2); %prime subject about upcoming stimulus
clear r2 c2

%initialize final variables
r2=-1.*ones(length(s2), ni); 
c2=r2;
s3=randperm(length(s2)); %randize shifts


for k2=1:length(s2)
    %d1=1; r0=zeros(1,ni); r1=0; n=1; chk=0;%initial contrast
    d1=d00; %initialize contrast 
    r0=zeros(1,ni); r1=0; n=1; chk=0;%initial contrast

    while n<=ni
        if d1>1
            d1=1; 
        elseif d1<=0 
            d1=0; 
        end % make sure contrast is between 0 and 1
        
        
        if  d1>=1;
%             i2R=i1R;
%             i2L=i1L;

            i2R=i1R{s3(k2)};
            i2L=i1L{s3(k2)};

        else
            %i2= imadjust(i1, stretchlim(i1, 0), [c0-c1; c0+c1]);
            for k0=1:3 

                i2R(:,:,k0)=idj(i1R{s3(k2)}(:,:,k0), d1); 
                i2L(:,:,k0)=idj(i1L{s3(k2)}(:,:,k0), d1); 
            end %adjust contrast
        end
        %gamma correction
        
        for k0=1:3 
            i3R(:,:,k0)=255.*(i2R(:,:,k0)./a0(2,k0)).^(1./n0(2,k0)); 
            i3L(:,:,k0)=255.*(i2L(:,:,k0)./a0(1,k0)).^(1./n0(1,k0)); 

        end ; %working
        

       if rand<0.5
            i4R=imrotate(uint8(i3R), a00);
            i4L=imrotate(uint8(i3L), a00);

            r1=1; d2='L';
        else

            i4R=imrotate(uint8(i3R), -a00);
            i4L=imrotate(uint8(i3L), -a00);

            r1=2; d2='R';
         end

        
        cwin1(flipud(i4R), flipud(i4L), cf, rc00, window1, window2);
        
        disp(['CS_SHIFT' n2s(s2(s3(k2))) ' TRL' n2s(n) ' ORIENTATION ' d2 ' CONTRAST' n2s2(100.*d1)]) ;
        [secs, kc, deltaSecs] = KbStrokeWait;
        
        cwin1(uint8(i5R), uint8(i5L), cf, rc00, window1, window2);
        
        
        n00=n;
        if kc(KbName('RightArrow'))
            r0(n)=(r1==2);

        elseif kc(KbName('LeftArrow'))
            r0(n)=(r1==1);
            
        else
            
            n=n-1; %repeat trial if not Left/right arrowkey
            
        end
        if n00==n
            c1(n)=d1; %record contrast
            if r0(n)==1;
                snd(1000, 0.2);
                chk=chk+1; r1=0;
                if chk == 2
                    d1=d1./d0; %reduce contrast
                    chk=0;
                end
            else
                snd(250, 0.2);
                d1=d1.*d0; %increase contrast
                chk=0;
            end
            if d1>1; d1=1; elseif d1<=0; d1=0; end;
        end
        n=n+1; %increment while counter
    end
    r2(s3(k2),:)=r0; %response
    c2(s3(k2),:)=c1; %contrast
    i6{s3(k2)}=i4R;
    save(['data\CSFtmp'], 'r2', 'c2', 's2', 's3', 'i6')
    
end

%sca
%save(['data\MB_CSF_Left_ACL0 _' tme], 'r2', 'c2', 's2')

