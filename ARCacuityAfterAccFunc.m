function AFCp = ARCacuityAfterAccFunc(imPattern,rgb,meanFocstmOptDst,focStmOptDstIncr, window1, window2, trlPerLvl)

global cf rc00 name_map zaber opto log

if size(meanFocstmOptDst,1)~=size(focStmOptDstIncr,1)
    error('ARCacuityAfterAccFunc: meanFocstmOptDst and focStmOptDstIncr must have the same number of rows!');
end

rgbAll = [];
meanFocstmOptDstAll = [];
focStmOptDstIncrAll = [];

for i = 1:size(rgb,1)
   for j = 1:size(focStmOptDstIncr,2)
       for l = 1:length(meanFocstmOptDst)
           for k = 1:trlPerLvl
               rgbAll(end+1,:) = rgb(i,:);
               focStmOptDstIncrAll(end+1,:) = focStmOptDstIncr(j);
               meanFocstmOptDstAll(end+1,:) = meanFocstmOptDst(l);
           end
       end
   end
end

% 1 = 0°, 2 = 90°, 3 = 180°, 4 = 270° 
stimOrientation = ceil(rand(size(focStmOptDstIncrAll))*4);

power_dispR=14.4; %starting display power
power_dispL=14; %starting display power
opto(name_map('r_disp')).control.setFocalPower(power_dispR-meanFocstmOptDstAll(1));
opto(name_map('l_disp')).control.setFocalPower(power_dispL-meanFocstmOptDstAll(1));

if size(imPattern,3)>1
   indImPattern = randsample(1:size(imPattern,3),1);
else
   indImPattern = 1;
end
im2R0(:,:,1) = imPattern(:,:,indImPattern).*rgb(1,1);
im2R0(:,:,2) = imPattern(:,:,indImPattern).*rgb(1,2);
im2R0(:,:,3) = imPattern(:,:,indImPattern).*rgb(1,3);

acuStim = [];
acuStimTmp = AFCwordStimImproved('E',[320 320],'white');
acuStim(:,:,1) = acuStimTmp;
acuStim(:,:,2) = imrotate(acuStimTmp,90);
acuStim(:,:,3) = imrotate(acuStimTmp,180);
acuStim(:,:,4) = imrotate(acuStimTmp,270);

cwinARC(zeros(size(im2R0)), zeros(size(im2R0)), window1, window2);

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

rspAcu = [];
for k0=1:length(focStmOptDstIncrAll)
      if size(imPattern,3)>1
        indImPattern = randsample(1:size(imPattern,3),1);
      else
        indImPattern = 1;
      end
      im2R0(:,:,1) = imPattern(:,:,indImPattern).*rgb(k0,1);
      im2R0(:,:,2) = imPattern(:,:,indImPattern).*rgb(k0,2);
      im2R0(:,:,3) = imPattern(:,:,indImPattern).*rgb(k0,3);
      blackStim = zeros(size(im2R0));
      cwinARC(blackStim, blackStim, window1, window2);
      opto(name_map('l_disp')).control.setFocalPower(power_dispL);
      opto(name_map('r_disp')).control.setFocalPower(power_dispR);

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
                  if keyCode(KbName('RightArrow')) | keyCode(KbName('6'))
                      opt_chk = 1;
                      rspAcu(k0) = 1;
                  elseif keyCode(KbName('LeftArrow')) | keyCode(KbName('4'))
                      opt_chk = 1;
                      rspAcu(k0) = 3;
                  elseif keyCode(KbName('UpArrow')) | keyCode(KbName('8'))
                      opt_chk = 1;
                      rspAcu(k0) = 2;
                  elseif keyCode(KbName('DownArrow')) | keyCode(KbName('2'))
                      opt_chk = 1;
                      rspAcu(k0) = 4;                      
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
      opto(name_map('l_disp')).control.setFocalPower(power_dispL-meanFocstmOptDstAll(k0));
      opto(name_map('r_disp')).control.setFocalPower(power_dispR-meanFocstmOptDstAll(k0));
      cwinARC(im2R0, im2R0, window1, window2);
      pause(3);
      cwinARC(blackStim, blackStim, window1, window2);
      opto(name_map('l_disp')).control.setFocalPower(power_dispL-meanFocstmOptDstAll(k0)-focStmOptDstIncrAll(k0));
      opto(name_map('r_disp')).control.setFocalPower(power_dispR-meanFocstmOptDstAll(k0)-focStmOptDstIncrAll(k0));      
      pause(0.1);
      tChange1(k0,:) = clock;
      cwinARC(acuStim(:,:,stimOrientation(k0)), acuStim(:,:,stimOrientation(k0)), window1, window2);
      tChange2(k0,:) = clock;
      pause(0.15);
      cwinARC(blackStim, blackStim, window1, window2);
      if scene.enable_tcp; send_tcp0(scene, 0); end %stage) 0stop 1record
      tRealEnd(k0,:) = clock;
      opto(name_map('l_disp')).control.setFocalPower(power_dispL);
      opto(name_map('r_disp')).control.setFocalPower(power_dispR);

      t1(k0,:)=clock;

      %snd(2000, 0.25);  pause(2.75);
      pause(0.5);

      %if scene.enable_tcp; send_tcp0(scene, 0); end %stage) 0stop 1record
      t2(k0,:)=clock;

      scene.trial_num=k0;
end

if scene.enable_tcp; fclose(scene.tcp_socket); end
AFCp.v1=power_dispR;
AFCp.t3=cat(3, t0, t1, t2,tChange1,tChange2,tRealEnd);
AFCp.rgb = rgb;
AFCp.meanFocstmOptDst = meanFocstmOptDst;
AFCp.focStmOptDstIncr = focStmOptDstIncr;
AFCp.rspAcu = rspAcu;
AFCp.stimOrientation = stimOrientation;

