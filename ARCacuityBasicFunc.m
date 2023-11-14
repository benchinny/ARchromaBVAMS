function AFCp = ARCacuityBasicFunc(imPattern,rgb,meanFocstmOptDst,stimSizePix, window1, window2, trlPerLvl)

global cf rc00 name_map zaber opto log

rgbAll = [];
meanFocstmOptDstAll = [];
stimSizePixAll = [];

for i = 1:size(rgb,1)
   for j = 1:size(stimSizePix,2)
       for l = 1:length(meanFocstmOptDst)
           for k = 1:trlPerLvl
               rgbAll(end+1,:) = rgb(i,:);
               stimSizePixAll(end+1,:) = stimSizePix(j);
               meanFocstmOptDstAll(end+1,:) = meanFocstmOptDst(l);
           end
       end
   end
end
rgbAll(end+1,:) = [0 0 0];
stimSizePixAll(end+1,:) = 420;
meanFocstmOptDstAll(end+1,:) = 3;

% 1 = 0°, 2 = 90°, 3 = 180°, 4 = 270° 
stimOrientation = ceil(rand(size(stimSizePixAll))*4);

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
acuStimTmp = squeeze(acuStimTmp(:,:,2));
acuStim(:,:,1) = acuStimTmp;
acuStim(:,:,2) = imrotate(acuStimTmp,90);
acuStim(:,:,3) = imrotate(acuStimTmp,180);
acuStim(:,:,4) = imrotate(acuStimTmp,270);
noiseStim = 100.*rand([5 5 3]);
noiseStim = int16(round(imresize(noiseStim,[50 50])));

cwin3(im2R0, im2R0, cf, rc00, window1, window2);

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

t0=zeros(length(stimSizePixAll), 6); t1=t0; t2=t0; tChange1 = t0; tChange2 = t0; tRealEnd = t0;
% stage) 0stop 1record figure this out with Steve
disp('ready to start');  KbWait([], 2); 

rspAcu = [];
for k0=1:length(stimSizePixAll)
      if size(imPattern,3)>1
        indImPattern = randsample(1:size(imPattern,3),1);
      else
        indImPattern = 1;
      end
      imPatternTmp = squeeze(imPattern(:,:,indImPattern));
      im2R0 = [];
      im2R0(:,:,1) = imPatternTmp.*rgbAll(k0,1);
      im2R0(:,:,2) = imPatternTmp.*rgbAll(k0,2);
      im2R0(:,:,3) = imPatternTmp.*rgbAll(k0,3);
      blackStim = zeros(size(im2R0));
      acuStim = [];
      acuStimTmp = AFCwordStimImproved('E',[320 320],'white');
      acuStimTmp = squeeze(acuStimTmp(:,:,2));
      acuStimTmp = imresize(acuStimTmp,stimSizePixAll(k0).*[1 1]);
      acuStimTmpRGB = [];
      acuStimTmpRGB(:,:,1) = acuStimTmp.*rgbAll(k0,1);
      acuStimTmpRGB(:,:,2) = acuStimTmp.*rgbAll(k0,2);
      acuStimTmpRGB(:,:,3) = acuStimTmp.*rgbAll(k0,3);
      acuStim(:,:,:,1) = acuStimTmpRGB;
      acuStim(:,:,:,2) = imrotate(acuStimTmpRGB,90);
      acuStim(:,:,:,3) = imrotate(acuStimTmpRGB,180);
      acuStim(:,:,:,4) = imrotate(acuStimTmpRGB,270);      
      cwin3(im2R0, im2R0, cf, rc00, window1, window2);
      opto(name_map('l_disp')).control.setFocalPower(power_dispL-meanFocstmOptDstAll(k0));
      opto(name_map('r_disp')).control.setFocalPower(power_dispR-meanFocstmOptDstAll(k0));

      fprintf('TRL= %f, L = %f  , R = %f , DEG = %f, Demand = %f\n' ,k0, opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power, (zaber(name_map('rotation')).control.getposition)./2.1333E3, meanFocstmOptDstAll(k0) );

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
                      if k0>1 rspAcu(k0-1) = 1; end
                  elseif keyCode(KbName('LeftArrow')) | keyCode(KbName('4'))
                      opt_chk = 1;
                      if k0>1 rspAcu(k0-1) = 3; end
                  elseif keyCode(KbName('UpArrow')) | keyCode(KbName('8'))
                      opt_chk = 1;
                      if k0>1 rspAcu(k0-1) = 4; end
                  elseif keyCode(KbName('DownArrow')) | keyCode(KbName('2'))
                      opt_chk = 1;
                      if k0>1 rspAcu(k0-1) = 2; end                   
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
      if k0==length(stimSizePixAll)
          break;
      end      
      t0(k0,:)=clock;
      snd(1000, 0.2);
      % opto(name_map('l_disp')).control.setFocalPower(power_dispL-meanFocstmOptDstAll(k0));
      % opto(name_map('r_disp')).control.setFocalPower(power_dispR-meanFocstmOptDstAll(k0));
      cwin3(im2R0, im2R0, cf, rc00, window1, window2);
      pause(1);
      cwin3(blackStim, blackStim, cf, rc00, window1, window2);
      tChange1(k0,:) = clock;
      % opto(name_map('l_disp')).control.setFocalPower(power_dispL-meanFocstmOptDstAll(k0));
      % opto(name_map('r_disp')).control.setFocalPower(power_dispR-meanFocstmOptDstAll(k0));      
      if scene.enable_tcp; send_tcp0(scene, 1); end; t1(k0,:)=clock;
      pause(0.1);      
      cwin3(squeeze(acuStim(:,:,:,stimOrientation(k0))), squeeze(acuStim(:,:,:,stimOrientation(k0))), cf, rc00, window1, window2);
      tChange2(k0,:) = clock;
      pause(0.1);
      cwin3(noiseStim, noiseStim, cf, rc00, window1, window2);
      pause(0.15);
      cwin3(blackStim, blackStim, cf, rc00, window1, window2);
      if scene.enable_tcp; send_tcp0(scene, 0); end %stage) 0stop 1record
      t2(k0,:)=clock;
      % opto(name_map('l_disp')).control.setFocalPower(power_dispL);
      % opto(name_map('r_disp')).control.setFocalPower(power_dispR);

      pause(0.2);
      scene.trial_num=k0;
      tRealEnd(k0,:) = clock;
      display(['k0 = ' num2str(k0) ', rsp length = ' num2str(length(rspAcu))]);
end

if scene.enable_tcp; fclose(scene.tcp_socket); end
AFCp.v1=power_dispR;
t3=cat(3, t0, t1, t2,tChange1,tChange2,tRealEnd);
AFCp.t3 = t3(1:end-1,:,:);
AFCp.rgb = rgbAll(1:end-1,:);
AFCp.meanFocstmOptDst = meanFocstmOptDstAll(1:end-1);
AFCp.stimSizePix = stimSizePixAll(1:end-1);
AFCp.rspAcu = rspAcu;
AFCp.stimOrientation = stimOrientation(1:end-1);
AFCp.im2R0 = im2R0;
AFCp.acuStim = acuStim;

