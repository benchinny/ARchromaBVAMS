%%220508 JnJ_AFC AFC9f include TCA correction. 
ex='RGB'; %ey=input('which eye? Right/Binc');
ey=input('which eye are we testing (type 1 for Right or 2 for Binocular)? ');
if ey==1; ey='Right'; elseif ey==2; ey='Binc'; end
filePath = 'G:\My Drive\exp_bvams\code_repo\ARC\';
vsIncrement = input(['Increment visit number? The current visit number is ' num2str(vs) ' (1 for yes, 0 for no)']);
vsIncrement = input(['Asking again: increment visit number? The current visit number is ' num2str(vs) ' (1 for yes, 0 for no)']);

if vsIncrement>=1
   vs = vs+1;
end

% expSubType = 'OLD';
% expSubType = 'STP';
% expSubType = 'SIN';
% expSubType = 'STEP';
expSubType = 'RGB';
blockType = 'fixed';
focStmOptDst = 1;
meanFocstmOptDst = 3;

focStmOptDst = focStmOptDst*1.25;
meanFocstmOptDst = meanFocstmOptDst*1.25;

if strcmp(blockType,'fixed')
    rgb1 = [0.32 0.00 0.00; ...
            0.00 0.00 1.00; ...
            0.56 0.00 0.00; ...
            0.00 0.00 1.00; ...
            0.56 0.00 0.00; ...            
            0.00 0.00 1.00];
    rgb2 = [0.32 0.00 1.00; ...
            0.32 0.00 1.00; ...
            0.56 0.00 0.00; ...
            0.00 0.00 1.00; ...
            0.00 0.00 1.00; ...            
            0.56 0.00 0.00];

            nCnd = size(rgb1,1);
            % TRIALS
%            AFCv = [1:nCnd fliplr(1:nCnd) 1:nCnd fliplr(1:nCnd)]';
            AFCv = [1:nCnd fliplr(1:nCnd)]';
            focStmOptDst = focStmOptDst.*ones([nCnd 1]);
            meanFocstmOptDst = meanFocstmOptDst.*ones([nCnd 1]);    
end

if strcmp(blockType,'random')
    nCnd = 20; % NUMBER OF CONDITIONS
    rVals = [0.56 0.42 0.32 0.24]'; % POSSIBLE RED PRIMARY VALUES
    bVals = [1.00 0.73 0.53 0.39]'; % POSSIBLE BLUE PRIMARY VALUES
    stepVals = 1.25.*[1.25 0.75 -0.75 -1.25]'; % POSSIBLE STEP VALUES
    indCnd = reshape(randsample(1:length(rVals),nCnd*5,1),[nCnd 5]);
    rgb1 = [rVals(indCnd(:,1)) zeros([nCnd 1]) bVals(indCnd(:,2))];
    rgb2 = [rVals(indCnd(:,3)) zeros([nCnd 1]) bVals(indCnd(:,4))];
    meanFocstmOptDst = meanFocstmOptDst.*ones([nCnd 1]);
    focStmOptDst = stepVals(indCnd(:,5)).*ones([nCnd 1]);
    AFCv = 1:length(focStmOptDst);
end

if ~exist('sr')
   sr = [0 0]; 
end

% ----TURN IT OFF FOR NOW! ---
tcaCorrect = 0;
display('ARC_AFC: WARNING! For now, tcaCorrect has been manually set at 0');
% ----------------------------

if tcaCorrect==1
   load JnJ\TCAflsL; TCAfnmL=TCAfls{sn-1000,vs};
   load JnJ\TCAflsR; TCAfnmR=TCAfls{sn-1000,vs};
end

 if tcaCorrect==0; 
     LfarPower=opto(name_map('r_t_far')).control.getFocalPower.focal_power; 
     zL0=fnz0(LfarPower, double(ACL~=0)); zL=zL0(:,1:2);
 elseif tcaCorrect==1; 
     load(TCAfnmL, 'TCAp');
     zL=TCAp.sbjTCA; 
 end %zL=[0 0; 10 10; 20 20]; end; %TCAfnmL=TCAfnm; 
         
if tcaCorrect==0; 
    RfarPower=opto(name_map('r_t_far')).control.getFocalPower.focal_power; 
    zR0=fnz0(RfarPower, double(ACL~=0)); zR=zR0(:,3:4);
elseif tcaCorrect==1;
    load(TCAfnmR, 'TCAp'); 
    zR=TCAp.sbjTCA; 
end %zR=[0 0; 10 10; 20 20]; end; %TCAfnmR=TCAfnm; 
          
if exist('AFCim0')==0 | isempty(AFCim0)==1; AFCfnm0='G:\My Drive\exp_bvams\code_repo\AFCim220510.mat'; load(AFCfnm0);  end %E optotype base 3 17secs to load


fprintf('Best shpere refraction: L = %f  , R = %f\n', sr(1), sr(2));
fprintf('Display power: L = %f  , R = %f\n',opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power);
fprintf('Trombone power: L = %f  , R = %f\n', opto(name_map('l_t_far')).control.getFocalPower.focal_power, opto(name_map('r_t_far')).control.getFocalPower.focal_power);
fprintf('Trombone position: L = %f  , R = %f\n',  zaber(name_map('l_trombone')).control.getposition,  zaber(name_map('r_trombone')).control.getposition);

disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);

[window1, window2, vbl0]=strt_psych0(screenNumber-2, screenNumber-1, 0);
        
cf=ones(3,2);
if ey(1)=='R'; cf(:,2)=0; elseif ey(1)=='L'; cf(:,1)=0; end

v0=focStmOptDst; 
v00=v0(AFCv,:); 
meanv00 = meanFocstmOptDst(AFCv);
rgb100 = rgb1(AFCv,:);
rgb200 = rgb2(AFCv,:);
% [im2L0, im2L1, im2R0, im2R1] = AFCtcaStmImg(AFCim0, AFCim1, zL, zR);
% im2 = 255.*insertText(zeros([500 500]),[125 75],'b','TextColor','green','BoxColor','black','FontSize',200);
% im2 = AFCwordStim('car',[500 500],[70 70; 160 70; 260 70]);
% im2(im2>0) = 255;
% im2 = flipud(im2);
AFCfls0=[filePath 'S' num2str(sn) 'V' num2str(vs) '_AFC_' ey 'ACL' n2s(ACL) '_' tme];
if strcmp(expSubType,'OLD')
   AFCp=AFC9f(AFCim0, AFCim1, zL, zR, v00, sr, window1, window2);
elseif strcmp(expSubType,'SIN')
   [im2L0, im2L1, im2R0, im2R1] = AFCtcaStmImg(AFCim0, AFCim1, zL, zR);
   AFCp=AFCsin(im2L0, im2L1, im2R0, im2R1, v00, meanv00, sr, window1, window2);
elseif strcmp(expSubType,'STEP')
   [im2L0, im2L1, im2R0, im2R1] = AFCtcaStmImg(AFCim0, AFCim1, zL, zR); 
   AFCp=AFCstep(im2L0, im2L1, im2R0, im2R1, v00, meanv00, sr, window1, window2); 
elseif strcmp(expSubType,'RGB')
   % imB = imread('G:\My Drive\exp_bvams\code_repo\imgs\vrn10_B_sd1.png');
   imB = AFCwordStimImproved('car',[320 320],'green');
   imB(imB>0) = 255;
   imB = flipud(imB);   
   imPattern = squeeze(imB(:,:,2));
   imC = AFCwordStimImproved('arc',[320 320],'green');
   imC(imC>0) = 255;
   imC = flipud(imC); 
   imPattern(:,:,2) = squeeze(imC(:,:,2));
   imD = AFCwordStimImproved('uno',[320 320],'green');
   imD(imD>0) = 255;
   imD = flipud(imD); 
   imPattern(:,:,3) = squeeze(imD(:,:,2));
   imE = AFCwordStimImproved('one',[320 320],'green');
   imE(imE>0) = 255;
   imE = flipud(imE); 
   imPattern(:,:,4) = squeeze(imE(:,:,2));   
   AFCp=AFCrgb(imPattern,rgb100,rgb200,v00, meanv00, sr, window1, window2);    
end

AFCp.v0=v0;
AFCp.v00=v00;
AFCp.AFCv=AFCv;
AFCp.meanv00 = meanv00;
AFCp.imfnm=AFCfnm0;
AFCp.rgb100 = rgb100;
AFCp.rgb200 = rgb200;

if sv == 1
%             AFCfls0=['JnJ\S' num2str(sn) 'V' num2str(vs) '_AFC_' ey 'ACL' n2s(ACL) '_' tme];
    save(AFCfls0, 'AFCp'); 
    load([filePath 'AFCfls' ey(1) '.mat'], 'AFCfls'); AFCfls{sn-1000,vs}=AFCfls0; 
    save([filePath 'AFCfls' ey(1) '.mat'], 'AFCfls'); 
end
         
opto(name_map('l_disp')).control.setFocalPower(14+sr(1));
opto(name_map('r_disp')).control.setFocalPower(14.4+sr(2));
% zaber(name_map('rotation')).move_deg(-3); %%-6400
[iLf iRf]=cwin3(imread('black.png'), imread('black.png') , cf, rc00, window2, window1);
clear LCAim;
sca;
