1.Google drive
2.Paralles
3.wired connected/internet (top right)
4.Use the pathway from terminal "my drive\m-wamvideocapture/videos/raw/centralperipheral_real
%%210720 AUTOREFRACTOR
yellow BNC to yellow BNC

To log into drive go back to mac and login to bankslab@berkeley.edu banks2019

to mount google drive look for it in mac applications and once signed in google drive logo will appear on top right

1 press swithch on & middle joystick button until you hear a beep

press mode to get into measurement bars mode

go to terminal (banks2019) verfiy Allfiles -> volumes -> google drive exists 

start terminal uparrow Enter BanksPassword Always record mode MyDrive -> M_wam_capture->videos->raw->alwaysrecord_notcp

start terminal uparrow Enter BanksPassword Always record mode MyDrive -> M_wam_capture->videos->processed->alwaysrecord_notcp



cd /media/psf/AllFiles/Volumes/



GoogleDrive/MyDrive/m-wamvideocapture/ && sudo python3 wam_capture_gui.py alwaysrecord_notcp.json

cd /media/psf/AllFiles/Volumes/GoogleDrive/MyDrive/m-wamvideocapture/ && sudo python3 wam_process_gui.py -s -e 'alwaysrecord_notcp' -f 'videos/raw/alwaysrecord_notcp/2021-08-10 15.00.mp4'

G:\My Drive\m-wamvideocapture\videos\processed\alwaysrecord_notcp

G:\My Drive\exp_centralperipheral_sine_mag\analysis\videos\processed

Wired Connected -> internet


    log.CRITICAL = 5;
    log.ERROR = 4;
    log.WARNING = 3;
    log.INFO = 2;
    log.DEBUG = 1;
    log.LEVEL = log.DEBUG;


        cmsg('TCP enabled', log.INFO, log.LEVEL);
        scene.tcp_socket = tcpip('169.229.228.200', 31000, 'NetworkRole', 'server');
        scene.tcp_socket = tcpip('169.254.201.1', 31000, 'NetworkRole', 'server');
        scene.tcp_socket = tcpip('169.254.69.140', 31000, 'NetworkRole', 'server');
        scene.tcp_socket = tcpip('10.211.55.5', 31000, 'NetworkRole', 'server');

        cmsg('Waiting for TCP socket connection...', log.INFO, log.LEVEL);
        fopen(scene.tcp_socket);
        
         fclose(scene.tcp_socket);
         
         
         
         
         
         
         %%211104 parse json file
         filetext = fileread('2021-11-04 15.20.json');
         jsondecode(filetext)
         dt=jsondecode(filetext)
         
         
dt = 

  struct with fields:

      ext_bottom_amp: [1×1 struct]
       ext_bottom_mu: [1×1 struct]
    ext_bottom_off_l: [1×1 struct]
    ext_bottom_off_r: [1×1 struct]
        ext_left_amp: [1×1 struct]
         ext_left_mu: [1×1 struct]
      ext_left_off_l: [1×1 struct]
      ext_left_off_r: [1×1 struct]
       ext_right_amp: [1×1 struct]
        ext_right_mu: [1×1 struct]
     ext_right_off_l: [1×1 struct]
     ext_right_off_r: [1×1 struct]
         ext_top_amp: [1×1 struct]
          ext_top_mu: [1×1 struct]
       ext_top_off_l: [1×1 struct]
       ext_top_off_r: [1×1 struct]
             pupil_r: [1×1 struct]
             pupil_v: [1×1 struct]
             pupil_x: [1×1 struct]
             pupil_y: [1×1 struct]
          time_hours: [1×1 struct]
         time_millis: [1×1 struct]
        time_minutes: [1×1 struct]
        time_seconds: [1×1 struct]
      time_totalsecs: [1×1 struct]
               trash: [1×1 struct]
               
               
               
               
           [cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)), cell2mat(struct2cell(dt.pupil_x)), cell2mat(struct2cell(dt.pupil_y)), cell2mat(struct2cell(dt.pupil_r)), cell2mat(struct2cell(dt.pupil_v))]
           [(cell2mat(struct2cell(dt.ext_bottom_mu))+cell2mat(struct2cell(dt.ext_top_mu)))./2, cell2mat(struct2cell(dt.pupil_x)), cell2mat(struct2cell(dt.pupil_y)), cell2mat(struct2cell(dt.pupil_r)), cell2mat(struct2cell(dt.pupil_v))]
           [(cell2mat(struct2cell(dt.ext_bottom_mu))+cell2mat(struct2cell(dt.ext_top_mu)))./2, (cell2mat(struct2cell(dt.ext_left_mu))+cell2mat(struct2cell(dt.ext_right_mu)))./2, cell2mat(struct2cell(dt.pupil_x)), cell2mat(struct2cell(dt.pupil_y)), cell2mat(struct2cell(dt.pupil_r)), cell2mat(struct2cell(dt.pupil_v))]
           [(cell2mat(struct2cell(dt.ext_bottom_mu))+cell2mat(struct2cell(dt.ext_top_mu)))./2, cell2mat(struct2cell(dt.pupil_y)),(cell2mat(struct2cell(dt.ext_left_mu))+cell2mat(struct2cell(dt.ext_right_mu)))./2, cell2mat(struct2cell(dt.pupil_x)) cell2mat(struct2cell(dt.pupil_r)), cell2mat(struct2cell(dt.pupil_v))]
           [(cell2mat(struct2cell(dt.ext_bottom_mu))+cell2mat(struct2cell(dt.ext_top_mu)))./2, cell2mat(struct2cell(dt.pupil_y)), (cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))./2, (cell2mat(struct2cell(dt.ext_left_mu))+cell2mat(struct2cell(dt.ext_right_mu)))./2, cell2mat(struct2cell(dt.pupil_x)) cell2mat(struct2cell(dt.pupil_r)), cell2mat(struct2cell(dt.pupil_v))]

           
           x=[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))./3.31, (cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))./3.59]
           x=cell2mat(struct2cell(dt.pupil_v))./3.4
           
           x=[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu))), cell2mat(struct2cell(dt.pupil_r))]
           
           x=[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu))), cell2mat(struct2cell(dt.pupil_v))]
           
           
           x=[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))]
           x0=x-mean(x(91:180))
           x1=x0./(-3.59)
           
           
           
                    
         
         %%211104 parse json file
         filetext = fileread('2021-11-04 15.20.json');
         filetext = fileread('2021-11-05 10.38.json');

         jsondecode(filetext)
         dt=jsondecode(filetext)
%horizontal
           x=[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))]
           x0=x-mean(x(91:180))
           x1=x0./(-3.59)
%vertical
           y=[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))]
           y0=x-mean(x(91:180))
           y1=y0./(-3.33)
           
           
           t=9.*[0:270-1]./(270-1)
           
           plot(t, [x1'; y1'])
           
           legend('Horizontal', 'Vertical')

                    %%211109 analyze Fabio data
         filetext = fileread('2021-11-09 15.47.json');

         dt=jsondecode(filetext);
%horizontal
           x=[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))]
           y=[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))]

           i0=1; x0=[]; y0=[]; v1=zeros(1, length(x))'; c=1;
           %for k0=1:64
           while i0.*180 <= length(x)    
              x0=[x0; x(i0.*180-179:i0.*180)'];
              y0=[y0; y(i0.*180-179:i0.*180)'];
              v1(i0.*180-89:i0.*180)=v000(i0);
              i0=i0+1;   
           end
               
           x1=(x0-mean(x0(:,61:90),2))./(-3.59)
           y1=(y0-mean(y0(:,61:90),2))./(-3.33)
           x2=x1'; x2=x2(:)'; 
           y2=y1'; y2=y2(:)'; 
           
           plot((length(x2)./30).*[0:length(x2)-1]./(length(x2)-1), [x2; y2; v1(1:6480)'])
           legend('Horizontal', 'Vertical', 'Accomodation Demand')
           
           
           
           
                   
           
           
                    %%211110 analyze Fabio data
                    load('S10003_AFC_RightACL0_2111101148.mat')
         filetext = fileread('2021-11-10 11.38.json');

         dt=jsondecode(filetext);
%horizontal
           x=[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))]
           y=[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))]

           
           
           i0=1; x0=[]; y0=[]; v11=zeros(1, length(x))'; c=1;
           %for k0=1:64
           while i0.*180 <= length(x)    
              x0=[x0; x(i0.*180-179:i0.*180)'];
              y0=[y0; y(i0.*180-179:i0.*180)'];
              v11(i0.*180-89:i0.*180)=v000(i0);
              i0=i0+1;   
           end
               
           x1=(x0-mean(x0(:,61:90),2))./(-3.59)
           y1=(y0-mean(y0(:,61:90),2))./(-3.33)
           x2=x1'; x2=x2(:)'; 
           y2=y1'; y2=y2(:)'; 
           
           plot((length(x2)./30).*[0:length(x2)-1]./(length(x2)-1), [x2; y2; v11(1:13680)'])
           legend('Horizontal', 'Vertical', 'Accomodation Demand')
           
           
           c=t0(1,:)
           
           %c1=round(c(6))+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
           c1=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
           clear t0
           
           
           
                               load('S10003_AFC_RightACL0_2111101148.mat')
         filetext = fileread('2021-11-10 11.38.json');

         dt=jsondecode(filetext);
%horizontal
           x=[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 

           for k0=1:76
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           
           x0=x; y0=y; a0=zeros(1, length(x0));
           for k0=1:76
              x0(t3(k0,1):t3(k0,3)-1)=x0(t3(k0,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
               y0(t3(k0,1):t3(k0,3)-1)=y0(t3(k0,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2))); 
               a0(t3(k0,2):t3(k0,3)-1)=v000(k0);
               
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
           for k0=1:76;
              x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
              y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           
           
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           legend('Horizontal','Vertical')
           
           
           
           
           
           
           
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
               
           
             load('S10003_AFC_RightACL0_2111101605.mat')
         filetext = fileread('2021-11-10 16.03.json');

         dt=jsondecode(filetext);
%horizontal
           x=[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 

           for k0=1:10
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           
           x0=x; y0=y; a0=zeros(1, length(x0));
           for k0=1:10
              x0(t3(k0,1):t3(k0,3)-1)=x0(t3(k0,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
               y0(t3(k0,1):t3(k0,3)-1)=y0(t3(k0,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2))); 
               a0(t3(k0,2):t3(k0,3)-1)=v000(k0);
               
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
           for k0=1:10;
              x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
              y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           
           
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           legend('Horizontal','Vertical')
           
           
           
     %%%Measure Fabio baseline

             load('S10003_AFC_RightACL0_2111101628.mat')
         filetext = fileread('2021-11-10 16.24.json');

         dt=jsondecode(filetext);
%horizontal
           x=[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 

           for k0=1:10
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           
           x0=x; y0=y; a0=zeros(1, length(x0));
           for k0=1:10
              x0(t3(k0,1):t3(k0,3)-1)=x0(t3(k0,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
               y0(t3(k0,1):t3(k0,3)-1)=y0(t3(k0,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2))); 
               a0(t3(k0,2):t3(k0,3)-1)=v000(k0);
               
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
           for k0=1:10;
              x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
              y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           
           
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           legend('Horizontal','Vertical')           
           
           
           
          
%%%% Fabio data with keypress


           
         load('S10003_AFC_RightACL0_2111101655.mat')
         filetext = fileread('2021-11-10 16.44.json');

         dt=jsondecode(filetext);
%horizontal
           x=-1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=-1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 

           for k0=1:76
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           
           x0=x; y0=y; a0=zeros(1, length(x0)); k1=1;
           for k0=1:76
%                if k0==1;
              x0(k1:t3(k0,3)-1)=x0(k1:t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
               y0(k1:t3(k0,3)-1)=y0(k1:t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                else
%                x0(t3(k0,1):t3(k0-1,3)-1)=x0(t3(k0-1,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(t3(k0,1):t3(k0-1,3)-1)=y0(t3(k0-1,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                end
               a0(t3(k0,2):t3(k0,3)-1)=v000(k0);
               k1=t3(k0,3);
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
           for k0=1:76;
              x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
              y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           plot([0:length(x1)-1]./30, [x1'; y1'; a0])
                      plot(t2, [x1'; y1'; a0])

           plot([1:length(x1)], [x1'; y1'; a0])

           
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           legend('Horizontal','Vertical')
           xlabel('Demand'); ylabel('Measurement')
           
           
           
           %%%% Fabio data with keypress


           
         load('S10003_AFC_RightACL0_2111101810.mat')
         filetext = fileread('2021-11-10 17.56.json');

         dt=jsondecode(filetext);
%horizontal
           x=-1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=-1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 

           for k0=1:76
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           
           x0=x; y0=y; a0=zeros(1, length(x0)); k1=1;
           for k0=1:76
%                if k0==1;
              x0(k1:t3(k0,3)-1)=x0(k1:t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
               y0(k1:t3(k0,3)-1)=y0(k1:t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                else
%                x0(t3(k0,1):t3(k0-1,3)-1)=x0(t3(k0-1,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(t3(k0,1):t3(k0-1,3)-1)=y0(t3(k0-1,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                end
               a0(t3(k0,2):t3(k0,3)-1)=v000(k0);
               k1=t3(k0,3);
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
           for k0=1:76;
              x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
              y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           plot([0:length(x1)-1]./30, [x1'; y1'; a0])
                      plot(t2, [x1'; y1'; a0])

           plot([1:length(x1)], [x1'; y1'; a0])

           
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           legend('Horizontal','Vertical')
           xlabel('Demand'); ylabel('Measurement')
           
           
           
           %211111 Fabio analysis
                    load('S10003_AFC_RightACL0_2111101810.mat')
         filetext = fileread('2021-11-10 17.56.json');

         dt=jsondecode(filetext);
%horizontal
           x=-1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=-1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 

           for k0=1:76
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           t4=circshift(t3(:,1),[-1 0]); t4(end)=length(x); %t3(end, end)
           x0=x; y0=y; a0=zeros(1, length(x0)); k1=1;
%            for k0=1:76
           for k0=1:76

%                if k0==1;
                x0(k1:t4(k0)-1)=x0(k1:t4(k0)-1)-mean(x0(k1+44:k1+90));
                y0(k1:t4(k0)-1)=y0(k1:t4(k0)-1)-mean(y0(k1+44:k1+90));

%               x0(k1:t3(k0,3)-1)=x0(k1:t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(k1:t3(k0,3)-1)=y0(k1:t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                else
%                x0(t3(k0,1):t3(k0-1,3)-1)=x0(t3(k0-1,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(t3(k0,1):t3(k0-1,3)-1)=y0(t3(k0-1,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                end
%                a0(t3(k0,2):t4(k0)-1)=v000(k0);
                 a0(k1+[90:180]-1)=v000(k0);

               k1=t4(k0);
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
%            for k0=1:76;
%               x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
%               y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
%            end

          for k0=1:76;
              x2(k0)=mean(x1(t4(k0)-44:t4(k0))); 
              y2(k0)=mean(y1(t4(k0)-44:t4(k0)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           plot([0:length(x1)-1]./30, [x1'; y1'; a0])
                      plot(t2, [x1'; y1'; a0])

           plot([1:length(x1)], [x1'; y1'; a0])
xlabel('Frame'); ylabel('Accommodative response'); legend('Horizontal', 'Vertical', 'Accommodative demand'); title('Fabio2111101756')
           
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           legend('Horizontal','Vertical')
           xlabel('Accommodative Demand'); ylabel('Accommodative response'); title('Fabio2111101756')
           
           
           %FF211112
           
                      %211111 Fabio analysis
                    load('S10003_AFC_RightACL0_2111121240.mat')
         filetext = fileread('2021-11-12 12.35.json');
         
                             load('S10003_AFC_RightACL0_2111121245.mat')
         filetext = fileread('2021-11-12 12.43.json');
         
                                      load('S10003_AFC_RightACL0_2111121442.mat')
         filetext = fileread('2021-11-12 14.33.json');
         
         load('S10003_AFC_RightACL0_2111101810.mat')
         filetext = fileread('2021-11-10 17.56.json');

         dt=jsondecode(filetext);
%horizontal
           x=-1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=-1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 

           for k0=1:length(v000)
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           t4=circshift(t3(:,1),[-1 0]); t4(end)=length(x); %t3(end, end)
           x0=x; y0=y; a0=zeros(1, length(x0)); k1=1;
%            for k0=1:76
           for k0=1:length(v000)

%                if k0==1;
                x0(k1:t4(k0)-1)=x0(k1:t4(k0)-1)-mean(x0(k1+44:k1+90));
                y0(k1:t4(k0)-1)=y0(k1:t4(k0)-1)-mean(y0(k1+44:k1+90));

%               x0(k1:t3(k0,3)-1)=x0(k1:t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(k1:t3(k0,3)-1)=y0(k1:t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                else
%                x0(t3(k0,1):t3(k0-1,3)-1)=x0(t3(k0-1,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(t3(k0,1):t3(k0-1,3)-1)=y0(t3(k0-1,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                end
%                a0(t3(k0,2):t4(k0)-1)=v000(k0);
                 a0(k1+[90:180]-1)=v000(k0);

               k1=t4(k0);
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
%            for k0=1:76;
%               x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
%               y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
%            end

          for k0=1:76;
              x2(k0)=mean(x1(t4(k0)-44:t4(k0))); 
              y2(k0)=mean(y1(t4(k0)-44:t4(k0)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           plot([0:length(x1)-1]./30, [x1'; y1'; a0])
                      plot(t2, [x1'; y1'; a0])

           plot([1:length(x1)], [x1'; y1'; a0])
xlabel('Frame'); ylabel('Accommodative response'); legend('Horizontal', 'Vertical', 'Accommodative demand'); title('Fabio2111101756')
           x5=[]; y5=[];
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
               x5=[x5; x2(v00==k0)];
               y5=[y5; y2(v00==k0)]; 
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           xlabel('Accommodative Demand'); ylabel('Accommodative response'); title('FF2111101756')
           ax=axis; axis([min([ax(1) ax(3)]) max([ax(2) ax(4)]) min([ax(1) ax(3)]) max([ax(2) ax(4)])])
           hold on; plot([min([ax(1) ax(3)]) max([ax(2) ax(4)])], [min([ax(1) ax(3)]) max([ax(2) ax(4)])], '--k')
           legend('Horizontal','Vertical', 'r=1')
           
           
           %%JT2111121517
         load('S10003_AFC_RightACL0_2111121532.mat')
         filetext = fileread('2021-11-12 15.17.json');

         dt=jsondecode(filetext);
%horizontal
           x=-1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=-1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 

           for k0=1:length(v000)
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           t4=circshift(t3(:,1),[-1 0]); t4(end)=length(x); %t3(end, end)
           x0=x; y0=y; a0=zeros(1, length(x0)); k1=1;
%            for k0=1:76
           for k0=1:length(v000)

%                if k0==1;
                x0(k1:t4(k0)-1)=x0(k1:t4(k0)-1)-mean(x0(k1+44:k1+90));
                y0(k1:t4(k0)-1)=y0(k1:t4(k0)-1)-mean(y0(k1+44:k1+90));

%               x0(k1:t3(k0,3)-1)=x0(k1:t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(k1:t3(k0,3)-1)=y0(k1:t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                else
%                x0(t3(k0,1):t3(k0-1,3)-1)=x0(t3(k0-1,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(t3(k0,1):t3(k0-1,3)-1)=y0(t3(k0-1,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                end
%                a0(t3(k0,2):t4(k0)-1)=v000(k0);
                 a0(k1+[90:180]-1)=v000(k0);

               k1=t4(k0);
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
%            for k0=1:76;
%               x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
%               y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
%            end

          for k0=1:76;
              x2(k0)=mean(x1(t4(k0)-44:t4(k0))); 
              y2(k0)=mean(y1(t4(k0)-44:t4(k0)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           plot([0:length(x1)-1]./30, [x1'; y1'; a0])
                      plot(t2, [x1'; y1'; a0])

           plot([1:length(x1)], [x1'; y1'; a0])
xlabel('Frame'); ylabel('Accommodative response'); legend('Horizontal', 'Vertical', 'Accommodative demand'); title('Fabio2111101756')
           x5=[]; y5=[]
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
               x5=[x5; x2(v00==k0)];
               y5=[y5; y2(v00==k0)]; 
               
               
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           figure; errorbar(v0, mean(x5'), std(x5',0)); hold on; errorbar(v0, mean(y5'), std(y5',0));

           xlabel('Accommodative Demand'); ylabel('Accommodative response'); title('JTP2111101515')
           ax=axis; axis([min([ax(1) ax(3)]) max([ax(2) ax(4)]) min([ax(1) ax(3)]) max([ax(2) ax(4)])])
           hold on; plot([min([ax(1) ax(3)]) max([ax(2) ax(4)])], [min([ax(1) ax(3)]) max([ax(2) ax(4)])], '--k')
           legend('Horizontal','Vertical', 'r=1')
           
           
           
           
                                 %211112 Max Greene
                    load('S10003_AFC_RightACL0_2111121702.mat')
         filetext = fileread('2021-11-12 16.47.json');

         dt=jsondecode(filetext);
%horizontal
           x=-1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=-1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 

           for k0=1:length(v000)
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           t4=circshift(t3(:,1),[-1 0]); t4(end)=length(x); %t3(end, end)
           x0=x; y0=y; a0=zeros(1, length(x0)); k1=1;
%            for k0=1:76
           for k0=1:length(v000)

%                if k0==1;
                x0(k1:t4(k0)-1)=x0(k1:t4(k0)-1)-mean(x0(k1+44:k1+90));
                y0(k1:t4(k0)-1)=y0(k1:t4(k0)-1)-mean(y0(k1+44:k1+90));

%               x0(k1:t3(k0,3)-1)=x0(k1:t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(k1:t3(k0,3)-1)=y0(k1:t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                else
%                x0(t3(k0,1):t3(k0-1,3)-1)=x0(t3(k0-1,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(t3(k0,1):t3(k0-1,3)-1)=y0(t3(k0-1,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                end
%                a0(t3(k0,2):t4(k0)-1)=v000(k0);
                 a0(k1+[90:180]-1)=v000(k0);

               k1=t4(k0);
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
%            for k0=1:76;
%               x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
%               y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
%            end

          for k0=1:76;
              x2(k0)=mean(x1(t4(k0)-44:t4(k0))); 
              y2(k0)=mean(y1(t4(k0)-44:t4(k0)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           plot([0:length(x1)-1]./30, [x1'; y1'; a0])
                      plot(t2, [x1'; y1'; a0])

           plot([1:length(x1)], [x1'; y1'; a0])
xlabel('Frame'); ylabel('Accommodative response'); legend('Horizontal', 'Vertical', 'Accommodative demand'); title('MG2111121647')
           x5=[]; y5=[];
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
               x5=[x5; x2(v00==k0)];
               y5=[y5; y2(v00==k0)]; 
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           xlabel('Accommodative Demand'); ylabel('Accommodative response'); title('MG2111121647')
           ax=axis; axis([min([ax(1) ax(3)]) max([ax(2) ax(4)]) min([ax(1) ax(3)]) max([ax(2) ax(4)])])
           hold on; plot([min([ax(1) ax(3)]) max([ax(2) ax(4)])], [min([ax(1) ax(3)]) max([ax(2) ax(4)])], '--k')
           legend('Horizontal','Vertical', 'r=1')
           
                                             %211123 JEV
                    load('S10003_AFC_RightACL0_2111231132.mat')
         filetext = fileread('2021-11-23 11.17.json');

         dt=jsondecode(filetext);
%horizontal
           x=-1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
           y=-1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
           
           
           %find timing
           t2=cell2mat(struct2cell(dt.time_hours)).*1E4+cell2mat(struct2cell(dt.time_minutes)).*1E2+cell2mat(struct2cell(dt.time_seconds))+cell2mat(struct2cell(dt.time_millis)).*1E-3 

           for k0=1:length(v000)
               for k1=1:3
              c=t1(k0, :, k1);
%               t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4+c(3)*1E6+c(2)*1E8+c(1)*1E10;
              t0(k0, k1)=c(6)+c(5)*1E2+c(4)*1E4;
              [M I]=min(abs(t0(k0, k1)-t2));
               t3(k0,k1)=I;  
               end
           end
           
           t4=circshift(t3(:,1),[-1 0]); t4(end)=length(x); %t3(end, end)
           x0=x; y0=y; a0=zeros(1, length(x0)); k1=1;
%            for k0=1:76
           for k0=1:length(v000)

%                if k0==1;
                x0(k1:t4(k0)-1)=x0(k1:t4(k0)-1)-mean(x0(k1+44:k1+90));
                y0(k1:t4(k0)-1)=y0(k1:t4(k0)-1)-mean(y0(k1+44:k1+90));

%               x0(k1:t3(k0,3)-1)=x0(k1:t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(k1:t3(k0,3)-1)=y0(k1:t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                else
%                x0(t3(k0,1):t3(k0-1,3)-1)=x0(t3(k0-1,1):t3(k0,3)-1)-mean(x0(t3(k0,2)-44:t3(k0,2)));
%                y0(t3(k0,1):t3(k0-1,3)-1)=y0(t3(k0-1,1):t3(k0,3)-1)-mean(y0(t3(k0,2)-44:t3(k0,2)));
%                end
%                a0(t3(k0,2):t4(k0)-1)=v000(k0);
                 a0(k1+[90:180]-1)=v000(k0);

               k1=t4(k0);
               
           end
           
           x1=x0./-3.59; y1=y0./-3.33;
           
%            for k0=1:76;
%               x2(k0)=mean(x1(t3(k0,3)-44:t3(k0,3))); 
%               y2(k0)=mean(y1(t3(k0,3)-44:t3(k0,3)));  
%            end

          for k0=1:76;
              x2(k0)=mean(x1(t4(k0)-44:t4(k0))); 
              y2(k0)=mean(y1(t4(k0)-44:t4(k0)));  
           end
           
           
           plot([0:length(x1)-1], [x1'; y1'; a0])
           plot([0:length(x1)-1]./30, [x1'; y1'; a0])
                     a0=a0(1:length(x1)); plot(t2, [x1'; y1'; a0])

           plot([1:length(x1)], [x1'; y1'; a0])
xlabel('Frame'); ylabel('Accommodative response'); legend('Horizontal', 'Vertical', 'Accommodative demand'); title('MG2111121647')
           x5=[]; y5=[];
           for k0=1:19
               x3(k0)=mean(x2(v00==k0)); x4(k0)=std(x2(v00==k0),0);
               y3(k0)=mean(y2(v00==k0)); y4(k0)=std(y2(v00==k0),0);
               x5=[x5; x2(v00==k0)];
               y5=[y5; y2(v00==k0)]; 
           end
           
           
           figure; errorbar(v0, x3, x4); hold on; errorbar(v0, y3, y4)
           xlabel('Accommodative Demand'); ylabel('Accommodative response'); title('MG2111121647')
           ax=axis; axis([min([ax(1) ax(3)]) max([ax(2) ax(4)]) min([ax(1) ax(3)]) max([ax(2) ax(4)])])
           hold on; plot([min([ax(1) ax(3)]) max([ax(2) ax(4)])], [min([ax(1) ax(3)]) max([ax(2) ax(4)])], '--k')
           legend('Horizontal','Vertical', 'r=1')