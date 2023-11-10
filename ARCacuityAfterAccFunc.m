function ARCacuityAfterAccFunc(imPattern,rgb,meanFocstmOptDst,focStmOptDstIncr, window1, window2)

global cf rc00 name_map zaber opto log

if size(meanFocstmOptDst,1)~=size(focStmOptDstIncr,1)
    error('ARCacuityAfterAccFunc: meanFocstmOptDst and focStmOptDstIncr must have the same number of rows!');
end

power_dispR=14.4; %starting display power
power_dispL=14; %starting display power
opto(name_map('r_disp')).control.setFocalPower(power_dispR-meanv0(1));
opto(name_map('l_disp')).control.setFocalPower(power_dispL-meanv0(1));

if size(imPattern,3)>1
   indImPattern = randsample(1:size(imPattern,3),1);
else
   indImPattern = 1;
end
im2R0(:,:,1) = imPattern(:,:,indImPattern).*rgb(1,1);
im2R0(:,:,2) = imPattern(:,:,indImPattern).*rgb(1,2);
im2R0(:,:,3) = imPattern(:,:,indImPattern).*rgb(1,3);

[iLf0 iRf0]=cwin3(im2R0, im2R0, cf, rc00, window1, window2);

%tcpip
log.CRITICAL = 5;
log.ERROR = 4;
log.WARNING = 3;
log.INFO = 2;
log.DEBUG = 1;
log.LEVEL = log.DEBUG;
scene.enable_tcp=1;
scene.trial_num=1;

if scene.enable_tcp
    cmsg('TCP enabled', log.INFO, log.LEVEL);
    scene.tcp_socket = tcpip('169.229.228.75', 31000, 'NetworkRole', 'server');
    cmsg('Waiting for TCP socket connection...', log.INFO, log.LEVEL);
    fopen(scene.tcp_socket);
    cmsg('TCP connected!', log.INFO, log.LEVEL);
end

t0=zeros(length(v0), 6); t1=t0; t2=t0; tChange1 = t0; tChange2 = t0; tRealEnd = t0;
% stage) 0stop 1record figure this out with Steve
disp('ready to start');  KbWait([], 2); 
for k0=1:size(v0,1)
      if size(imPattern,3)>1
        indImPattern = randsample(1:size(imPattern,3),1);
      else
        indImPattern = 1;
      end
      im2R0(:,:,1) = imPattern(:,:,indImPattern).*rgb0(k0,1);
      im2R0(:,:,2) = imPattern(:,:,indImPattern).*rgb0(k0,2);
      im2R0(:,:,3) = imPattern(:,:,indImPattern).*rgb0(k0,3);
      im2R1(:,:,1) = imPattern(:,:,indImPattern).*rgb1(k0,1);
      im2R1(:,:,2) = imPattern(:,:,indImPattern).*rgb1(k0,2);
      im2R1(:,:,3) = imPattern(:,:,indImPattern).*rgb1(k0,3);
      [iLf0 iRf0]=cwin3(im2R0, im2R0, cf, rc00, window1, window2);
      opto(name_map('l_disp')).control.setFocalPower(power_dispL-meanv0(k0));
      opto(name_map('r_disp')).control.setFocalPower(power_dispR-meanv0(k0));

      fprintf('TRL= %f, L = %f  , R = %f , DEG = %f, Demand = %f\n' ,k0, opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power, (zaber(name_map('rotation')).control.getposition)./2.1333E3, v0(k0) );

      snd(250, 0.25); %pause(2.75);
      
      KbName('UnifyKeyNames');
 %     KbWait([], 2); 
      exitLoop = 0;
      % Control loop
      ListenChar(2);
      try
          opt_chk=0;
          while opt_chk==0
              [ keyIsDown, keyTime, keyCode ] = KbCheck;
              if keyIsDown
                  if keyCode(KbName('RightArrow')) | keyCode(KbName('5'))
                      opt_chk = 1;
                      %end
                  elseif keyCode(KbName('Return')) %| keyCode(KbName('Return'))
                      exitLoop = 1;
                      opt_chk = 1;
                  else
                      disp('WRONG KEY'); snd(100, 0.25);
                  end     
              end
              % Key debounce routine, which waits for key to be released
              while keyIsDown
                  [ keyIsDown, keyTime, keyCode ] = KbCheck;
              end
          end
      catch ERROR
          if enable_optotunes
              for p = 1:6
                  opto(p).control.Close();
              end
          end
          if enable_trombones
              fclose(port);
              delete(port);
          end
          a = instrfind();
          if ~isempty(a) %isempty(Obj) returns logical 1 (true) if Obj is an empty ExptData object. Otherwise, it returns logical 0 (false). An empty ExptData object contains no data elements.
              fclose(a);
              delete(a)
              clear a
          end
          rethrow(ERROR)
      end
      ListenChar(0);
%      KbWait([], 2);      
      if exitLoop
         break; 
      end
      
      if scene.enable_tcp; send_tcp0(scene, 1); end; t0(k0,:)=clock;
      
      snd(1000, 0.2); pause(0.5);
      for i = 1:floor(length(sinValues)/2)
         opto(name_map('l_disp')).control.setFocalPower(power_dispL-sinValues(i));
         opto(name_map('r_disp')).control.setFocalPower(power_dispR-sinValues(i));
         pause(tIntervalStm);
      end
      tChange1(k0,:) = clock;
      [iLf1 iRf1]=cwin3(im2R1, im2R1, cf, rc00, window1, window2);
      tChange2(k0,:) = clock;
      for i = (floor(length(sinValues)/2)+1):length(sinValues)
         opto(name_map('l_disp')).control.setFocalPower(power_dispL-sinValues(i));
         opto(name_map('r_disp')).control.setFocalPower(power_dispR-sinValues(i));
         pause(tIntervalStm);
      end      
      snd(1000, 0.1); pause(0.2);
      snd(1000, 0.1); pause(0.1);
     
      if scene.enable_tcp; send_tcp0(scene, 0); end %stage) 0stop 1record
      tRealEnd(k0,:) = clock;
      %pause(3);
      %wn=cwin0(img0, 'Stereo', cf, rc00, window1, window2);
      [iLf0 iRf0]=cwin3(im2R0, im2R0, cf, rc00, window1, window2);
      opto(name_map('l_disp')).control.setFocalPower(power_dispL-meanv0(k0));
      opto(name_map('r_disp')).control.setFocalPower(power_dispR-meanv0(k0));
    %           zaber(name_map('rotation')).move_deg(-3); %%-6400

      t1(k0,:)=clock;

      %snd(2000, 0.25);  pause(2.75);
      pause(2);

      %if scene.enable_tcp; send_tcp0(scene, 0); end %stage) 0stop 1record
      t2(k0,:)=clock;

    scene.trial_num=k0;
end

if scene.enable_tcp; fclose(scene.tcp_socket); end
AFCp.v1=power_dispR;
AFCp.t3=cat(3, t0, t1, t2,tChange1,tChange2,tRealEnd);
