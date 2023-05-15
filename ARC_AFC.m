%%220508 JnJ_AFC AFC9f include TCA correction. 
ex='AFC'; %ey=input('which eye? Right/Binc');
ey=input('which eye are we testing (type 1 for Right or 2 for Binocular)? ');
if ey==1; ey='Right'; elseif ey==2; ey='Binc'; end
filePath = 'G:\My Drive\exp_bvams\code_repo\ARC\';
vsIncrement = input(['Increment visit number? The current visit number is ' num2str(vs) ' (1 for yes, 0 for no)']);
vs = vs+vsIncrement;

% expSubType = 'OLD';
% expSubType = 'STP';
% expSubType = 'SIN';
% expSubType = 'STEP';
expSubType = 'RGB';

% focStmOptDst = [4.5; 4.5];
% meanFocstmOptDst = [2 2]';
% AFCv = [1]';
focStmOptDst = [-4.5];
meanFocstmOptDst = [6.5]';
AFCv = [1]';

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
   % im0 = imread('G:\My Drive\exp_bvams\code_repo\imgs\vrn10_R_sd1.png');
   % im1 = imread('G:\My Drive\exp_bvams\code_repo\imgs\vrn10_B_sd1.png');
   im0 = AFCwordStim('one',[500 500],[70 70; 160 70; 260 70]);
   im0(im0>1) = 255;
   im0 = flipud(im0);
   im1 = AFCwordStim('uno',[500 500],[70 70; 160 70; 260 70]);   
   im1(im1>0) = 255;
   im1 = flipud(im1);
   im2L0 = im0; im2R0 = im0; im2L1 = im1; im2R1 = im1;
   AFCp=AFCchangeImg(im2L0, im2L1, im2R0, im2R1, v00, meanv00, sr, window1, window2);    
end

AFCp.v0=v0;
AFCp.v00=v00;
AFCp.AFCv=AFCv;
AFCp.meanv00 = meanv00;
AFCp.imfnm=AFCfnm0;

if sv == 1
%             AFCfls0=['JnJ\S' num2str(sn) 'V' num2str(vs) '_AFC_' ey 'ACL' n2s(ACL) '_' tme];
    save(AFCfls0, 'AFCp'); 
    load([filePath 'AFCfls' ey(1) '.mat'], 'AFCfls'); AFCfls{sn-1000,vs}=AFCfls0; 
    save([filePath 'AFCfls' ey(1) '.mat'], 'AFCfls'); 
end
         
opto(name_map('l_disp')).control.setFocalPower(14+sr(1));
opto(name_map('r_disp')).control.setFocalPower(14.4+sr(2));
zaber(name_map('rotation')).move_deg(-3); %%-6400
[iLf iRf]=cwin3(imread('black.png'), imread('black.png') , cf, rc00, window2, window1);
clear LCAim;
sca;
