%show CDF stimuli
% cls
% n4=2; %color to shift 2GREEN 3BLUE
% ni=40; %n0 number of trials
 f=73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
 s= 100; %gaussian  sigma
 d0=1.6; %contrast step size
 a00=10; %angle of image tilt
% % bxy=[0 0; 37 37; 20 20]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
% %bxy=[0 0; 0 0;0 0]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
% s2=-6:2:6; %ffTCA shift of green plane f
s2=[-3 -2 -1 0 1 2 3]./3;
k2=7
%'a*x^b'
%RED a=58.05 b=2.473
%GREEN a=174.8 b=2.501
%BLUE a=17.47 b=2.431


%KbName('UnifyKeyNames')
%% LEFT screen
% a1=[58.05 174.8 17.47]; %a gamma correcion
% n1=[2.473 2.501 2.431]; %ones(1,3).*2.33;
%RIGHT SCREEN
% a1=[56.42 164.1 17.89]; %a gamma correction
% n1=[2.458 2.611 2.482]; %ones(1,3).*2.33;

a0=[58.05 174.8 17.47; 56.42 164.1 17.89];
n0=[2.473 2.501 2.431; 2.458 2.611 2.482];

%n2=(a1.*1.^n1); n3= 255.*((n2./a1).^(1./n1));
n2=(a0.*1.^n0); n3= 255.*((n0./a0).^(1./n0));

cf=ones(3,2);
% if n4==1;
% %     n2=n2(1).*ones(1,3); %set equiluminance for RED-GREEN
%     n2=n2(:,1).*ones(2,3); %set equiluminance for RED-GREEN
%     cf(3,:)=0; %turn off primer 1RED 2GREEN 3BLUE
% elseif n4==2;
    n2=n2(:,3).*ones(2,3); %set equiluminance for RED-BLUE
    %n2=n2(3).*ones(1,3); %set equiluminance  for RED-BLUE
    cf(2,:)=0; %turn off primer 1RED 2GREEN 3BLUE
%end
%for k0=1:3; i3(:,:,k0)=255.*(i2(:,:,k0)./a1(k0)).^(1./n1(k0)); end ; %working
%ey='Left';ex='LCA';
%rc00=[0 0; 0 0];
sz = [1080, 1920]; % size of screen
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; %cf=[1 1];
%[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 2);

%responses
chk=0; %%reduce step size every two reversals

% i1=gbr(f, s, sz); i1=i1-mna(i1); i1=i1./mxa(i1); c0=mne(i1);
%f=73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
%s=100; %gaussian  sigma
% i0=n2(1,1).*gbr0([f 0 100], sz);  
% i1=n2(1,3).*gbr0([f 1 100], sz);
% cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %n0=4; cg='p'; %gamma corrected/purple background
% 
% i0=cf(1,1).*gbr0([f 0 100], sz);  
% i1=cf(3,1).*gbr0([f 0 100], sz);

% i0=n2(1,1).*gbr0([f 0 100], sz)./255;  
%i1=n2(1,3).*gbr0([f 0 100], sz)./255;


clear i1 i1L i1R
i0=gbr0([f 0 100], sz);  
for k0=1:length(s2); 
    
    i1{k0}=gbr0([f s2(k0) 100], sz); 
    i1L{k0}=cat(3, n2(1,1).*i0, zeros(sz),  n2(1,3).*i1{k0});
    i1R{k0}=cat(3, n2(2,1).*i0, zeros(sz),  n2(2,3).*i1{k0});
end




% 
% i2=ct8(i0, zeros(sz),    i1 );
% i2=ct8( (i0./a0(1,1)).^(1./n0(1,1)), zeros(sz),    (i1./a0(1,3)).^(1./n0(1,3)) );
% 
% 255.*(i2R(:,:,k0)./a0(2,k0)).^(1./n0(2,k0)); 
% 
% 
% i2=ct8(i0, zeros(sz), i1);
% i3=imrotate(i2, 10);
% imshow(i3)

% i1L=cs1(i1, [0 0;  0 0;  0 0], n2(1,:));
% i1R=cs1(i1, [0 0;  0 0;  0 0], n2(2,:));

%i1=cs1(gbr(f, s, sz), bxy, n2); c0=mean(stretchlim(i1, 0));
i0=ct3(zeros(sz));
snd(500, 0.2); %prime subject about upcoming stimulus
clear r2 c2
% for k2=1:length(s2)
    d1=1; %r0=zeros(1,ni); r1=0; n=1;%initial contrast
%     while n<=ni
%         if d1>1
%             d1=1; 
%         elseif d1<=0 
%             d1=0; 
%         end % make sure contrast is between 0 and 1
        
        
        if  d1>=1;
%             i2R=i1R;
%             i2L=i1L;

            i2R=i1R{k2};
            i2L=i1L{k2};

        else
            %i2= imadjust(i1, stretchlim(i1, 0), [c0-c1; c0+c1]);
            for k0=1:3 
%                 i2R(:,:,k0)=idj(i1R(:,:,k0), d1); 
%                 i2L(:,:,k0)=idj(i1L(:,:,k0), d1); 
                i2R(:,:,k0)=idj(i1R{k2}(:,:,k0), d1); 
                i2L(:,:,k0)=idj(i1L{k2}(:,:,k0), d1); 
            end %adjust contrast
        end
        %gamma correction
        
        for k0=1:3 
%             i3(:,:,k0)=255.*(i2(:,:,k0)./a1(k0)).^(1./n1(k0)); 
            i3R(:,:,k0)=255.*(i2R(:,:,k0)./a0(2,k0)).^(1./n0(2,k0)); 
            i3L(:,:,k0)=255.*(i2L(:,:,k0)./a0(1,k0)).^(1./n0(1,k0)); 

        end ; %working
        
%         if n4==1
% %             i3(:,:,2)=circshift(i3(:,:,2), [0 s2(k2)]); %change green plane
%               i3L(:,:,2)=circshift(i3L(:,:,2), [0 s2(k2)]); %change green plane
%               i3R(:,:,2)=circshift(i3R(:,:,2), [0 s2(k2)]); %change green plane
% 
%         elseif n4==2
% %             i3(:,:,3)=circshift(i3(:,:,3), [0 s2(k2)]); %change blue plane
%               i3L(:,:,3)=circshift(i3L(:,:,3), [0 s2(k2)]); %change blue plane
%               i3R(:,:,3)=circshift(i3R(:,:,3), [0 s2(k2)]); %change blue plane
% 
%         end
        %imshow(uint8(i3))
        if rand<0.5
%             i4=imrotate(uint8(i3), a0);
            i4R=imrotate(uint8(i3R), a00);
            i4L=imrotate(uint8(i3L), a00);

            r1=1; d2='L';
        else
%             i4=imrotate(uint8(i3), -a0);
            i4R=imrotate(uint8(i3R), -a00);
            i4L=imrotate(uint8(i3L), -a00);

            r1=2; d2='R';
        end
        imshow(i4L); title([n2s2(s2(k2)) 'pi phase '  d2 ' 10deg tilt']) 
%        figure; imshow(i4R); title([n2s2(s2(k2)) 'pi phase Right 10deg tilt']) 
%         
%         %cwin1(i0, i0, cf, rc00, window1, window2);
%         
%         %KbWait;
%         
%         cwin1(flipud(i4R), flipud(i4L), cf, rc00, window1, window2);
%         
%         disp(['CS_SHIFT' n2s(s2(k2)) ' TRL' n2s(n) ' ORIENTATION ' d2 ' CONTRAST' n2s2(d1)]) ;
%         [secs, kc, deltaSecs] = KbStrokeWait;
%         n00=n;
%         if kc(KbName('RightArrow'))
%             r0(n)=(r1==2);
%             
%             
%             
%             
%         elseif kc(KbName('LeftArrow'))
%             r0(n)=(r1==1);
%             
%         else
%             
%             n=n-1; %repeat trial if not Left/right arrowkey
%             
%         end
%         if n00==n
%             c1(n)=d1; %record contrast
%             if r0(n)==1;
%                 snd(1000, 0.2);
%                 chk=chk+1; r1=0;
%                 if chk == 2
%                     d1=d1./d0; %reduce contrast
%                     chk=0;
%                 end
%             else
%                 snd(250, 0.2);
%                 d1=d1.*d0; %increase contrast
%             end
%             if d1>1; d1=1; elseif d1<=0; d1=0; end;
%         end
%         n=n+1; %increment while counter
%     end
%     r2(k2,:)=r0;
%     c2(k2,:)=c1;
%     save(['data\CSFtmp'], 'r2', 'c2', 's2')
%     
% end

%sca
%save(['data\MB_CSF_Left_ACL0 _' tme], 'r2', 'c2', 's2')





% %% 210510 present 2AFC gabor stimuli 
% % function [r2 c2]=CSF3f(ni, n4, f, s, d0, a00, s2, window1, window2);
% % 
% %         [a7 a8]=CSF3f(a0, a1, a2, a3, a4, a5, a6, window1, window2);
% 
% 
% n4=2; %a1=2; %color to shift 1RED-GREEN 2RED-BLUE
% ni=40;%a0=40 ; %number of trials
% f=2*73.6;%a2 %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
% s=100; % a3 gaussian  sigma
% d0=1.6; %a4 contrast step size
% a00=10; %a5 angle of image   tilt
% %      a6=[-12 0 12];
% s2=-6:2:6; %[-6:2:6]; %a6 s2=-6:2:6; %ffTCA shift of green plane f
% sz = [1080, 1920]; % size of screen
% % screens = Screen('Screens');
% % screenNumber = max(screens);
% load cal_val; %cf=[RB./RR LB./LR];
% % cf=[RB./RR LB./LR; 0.3 0.3; 1 1];
% % cf=[RB./RR LB./LR; RB./RG LB./LG; 1 1]
% % cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; %gamma corrected purple
% % background LATEST JAN 7
% 
% 
% 
% global snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf rc00
% % addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% % cls
% % n4=2; %color to shift 2GREEN 3BLUE
% % ni=40; %n0 number of trials
% % f=2*73.6; %frequency/number of bands : 73.6 cycles for 10cpd , 36.8 for 5 cpd, 147.2 for 20 cpd
% % s= 100; %gaussian  sigma
% % d0=1.6; %contrast step size
% % a0=10; %angle of image tilt
% % % bxy=[0 0; 37 37; 20 20]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
% % %bxy=[0 0; 0 0;0 0]; %TCA shift [ Yr Xr, Yg Xg, Yb Xb]
% % s2=-6:2:6; %ffTCA shift of green plane f
% 
% %'a*x^b'
% %RED a=58.05 b=2.473
% %GREEN a=174.8 b=2.501
% %BLUE a=17.47 b=2.431
% 
% 
% KbName('UnifyKeyNames')
% %% LEFT screen
% % a1=[58.05 174.8 17.47]; %a gamma correcion
% % n1=[2.473 2.501 2.431]; %ones(1,3).*2.33;
% %RIGHT SCREEN
% % a1=[56.42 164.1 17.89]; %a gamma correction
% % n1=[2.458 2.611 2.482]; %ones(1,3).*2.33;
% 
% a0=[58.05 174.8 17.47; 56.42 164.1 17.89];
% n0=[2.473 2.501 2.431; 2.458 2.611 2.482];
% 
% %n2=(a1.*1.^n1); n3= 255.*((n2./a1).^(1./n1));
% n2=(a0.*1.^n0); n3= 255.*((n0./a0).^(1./n0));
% 
% cf=ones(3,2);
% if n4==1;
% %     n2=n2(1).*ones(1,3); %set equiluminance for RED-GREEN
%     n2=n2(:,1).*ones(2,3); %set equiluminance for RED-GREEN
%     cf(3,:)=0; %turn off primer 1RED 2GREEN 3BLUE
% elseif n4==2;
%     n2=n2(:,3).*ones(2,3); %set equiluminance for RED-BLUE
%     %n2=n2(3).*ones(1,3); %set equiluminance  for RED-BLUE
%     cf(2,:)=0; %turn off primer 1RED 2GREEN 3BLUE
% end
% %for k0=1:3; i3(:,:,k0)=255.*(i2(:,:,k0)./a1(k0)).^(1./n1(k0)); end ; %working
% %ey='Left';ex='LCA';
% %rc00=[0 0; 0 0];
% sz = [1080, 1920]; % size of screen
% % screens = Screen('Screens');
% % screenNumber = max(screens);
% % load cal_val; %cf=[1 1];
% %[window1, window2, vbl0]=strt_psych0(screenNumber-1, screenNumber, 2);
% 
% %responses
% chk=0; %%reduce step size every two reversals
% 
% 
% %d1=1; %contrast;
% %im=ct3(gbr(f, s, sz)); c0=mean(stretchlim(im, 0));
% %im=cs3(gbr(f, s, sz), bxy); c0=mean(stretchlim(im, 0));
% i1=gbr(f, s, sz); i1=i1-mna(i1); i1=i1./mxa(i1); c0=mne(i1);
% i1L=cs1(i1, [0 0;  0 0;  0 0], n2(1,:));
% i1R=cs1(i1, [0 0;  0 0;  0 0], n2(2,:));
% 
% %i1=cs1(gbr(f, s, sz), bxy, n2); c0=mean(stretchlim(i1, 0));
% i0=ct3(zeros(sz));
% snd(500, 0.2); %prime subject about upcoming stimulus
% clear r2 c2
% % for k2=1:length(s2)
% %     d1=1; r0=zeros(1,ni); r1=0; n=1;%initial contrast
% %     while n<=ni
% %         if d1>1
% %             d1=1; 
% %         elseif d1<=0 
% %             d1=0; 
% %         end % make sure contrast is between 0 and 1
% %         if  d1>=1;
% %             i2R=i1R;
% %             i2L=i1L;
% % 
% %         else
% %             %i2= imadjust(i1, stretchlim(i1, 0), [c0-c1; c0+c1]);
%             for k0=1:3 
%                 i2R(:,:,k0)=idj(i1R(:,:,k0), d1); 
%                 i2L(:,:,k0)=idj(i1L(:,:,k0), d1); 
%             end %adjust contrast
% %        end
%         %gamma correction
%         
%         for k0=1:3 
% %             i3(:,:,k0)=255.*(i2(:,:,k0)./a1(k0)).^(1./n1(k0)); 
%             i3R(:,:,k0)=255.*(i2R(:,:,k0)./a0(2,k0)).^(1./n0(2,k0)); 
%             i3L(:,:,k0)=255.*(i2L(:,:,k0)./a0(1,k0)).^(1./n0(1,k0)); 
% 
%         end ; %working
%         
%         if n4==1
% %             i3(:,:,2)=circshift(i3(:,:,2), [0 s2(k2)]); %change green plane
%               i3L(:,:,2)=circshift(i3L(:,:,2), [0 s2(k2)]); %change green plane
%               i3R(:,:,2)=circshift(i3R(:,:,2), [0 s2(k2)]); %change green plane
% 
%         elseif n4==2
% %             i3(:,:,3)=circshift(i3(:,:,3), [0 s2(k2)]); %change blue plane
%               i3L(:,:,3)=circshift(i3L(:,:,3), [0 s2(k2)]); %change blue plane
%               i3R(:,:,3)=circshift(i3R(:,:,3), [0 s2(k2)]); %change blue plane
% 
%         end
%         %imshow(uint8(i3))
% %         if rand<0.5
% %             i4=imrotate(uint8(i3), a0);
%             i4R=imrotate(uint8(i3R), a00);
%             i4L=imrotate(uint8(i3L), a00);
% 
% %             r1=1; d2='L';
% %         else
% % %             i4=imrotate(uint8(i3), -a0);
% %             i4R=imrotate(uint8(i3R), -a00);
% %             i4L=imrotate(uint8(i3L), -a00);
% % 
% %             r1=2; d2='R';
% %         end
%         
%         %cwin1(i0, i0, cf, rc00, window1, window2);
%         
%         %KbWait;
%         imshow(i4R)
% %         cwin1(flipud(i4R), flipud(i4L), cf, rc00, window1, window2);
% %         
% %         disp(['CS_SHIFT' n2s(s2(k2)) ' TRL' n2s(n) ' ORIENTATION ' d2 ' CONTRAST' n2s2(d1)]) ;
% %         [secs, kc, deltaSecs] = KbStrokeWait;
% %         n00=n;
% %         if kc(KbName('RightArrow'))
% %             r0(n)=(r1==2);
% %             
% %             
% %             
% %             
% %         elseif kc(KbName('LeftArrow'))
% %             r0(n)=(r1==1);
% %             
% %         else
% %             
% %             n=n-1; %repeat trial if not Left/right arrowkey
% %             
% %         end
% %         if n00==n
% %             c1(n)=d1; %record contrast
% %             if r0(n)==1;
% %                 snd(1000, 0.2);
% %                 chk=chk+1; r1=0;
% %                 if chk == 2
% %                     d1=d1./d0; %reduce contrast
% %                     chk=0;
% %                 end
% %             else
% %                 snd(250, 0.2);
% %                 d1=d1.*d0; %increase contrast
% %             end
% %             if d1>1; d1=1; elseif d1<=0; d1=0; end;
% %         end
% %         n=n+1; %increment while counter
% %     end
% %     r2(k2,:)=r0;
% %     c2(k2,:)=c1;
% %     save(['data\CSFtmp'], 'r2', 'c2', 's2')
% %     
% % end
% 
% %sca
% %save(['data\MB_CSF_Left_ACL0 _' tme], 'r2', 'c2', 's2')
% 
