%%220508 JnJ_AFC AFC9f include TCA correction. 
ex='ACU'; %ey=input('which eye? Right/Binc');
ey=1;
if ey==1; ey='Right'; elseif ey==2; ey='Binc'; end
filePath = 'H:\Shared drives\CIVO_BVAMS\data\ARC\';
vsIncrement = input(['Increment visit number? The current visit number is ' num2str(vs) ' (1 for yes, 0 for no)']);
vsIncrement = input(['Asking again: increment visit number? The current visit number is ' num2str(vs) ' (1 for yes, 0 for no)']);

if vsIncrement>=1
   vs = vs+1;
end

meanFocstmOptDst = [2.5]*1.25;

rgb  = [0.555 0.00 1.00];

frqCpd = 15;
contrast = [0.1 0.2 0.3 0.4 0.5];
trlPerLvl = 20;

% DEFAULT NO TCA CORRECTION
LfarPower=opto(name_map('r_t_far')).control.getFocalPower.focal_power; 
zL0=fnz0(LfarPower, double(ACL~=0)); zL=zL0(:,1:2);
% DEFAULT NO TCA CORRECTION
RfarPower=opto(name_map('r_t_far')).control.getFocalPower.focal_power; 
zR0=fnz0(RfarPower, double(ACL~=0)); zR=zR0(:,3:4);

fprintf('Display power: L = %f  , R = %f\n',opto(name_map('l_disp')).control.getFocalPower.focal_power, opto(name_map('r_disp')).control.getFocalPower.focal_power);
fprintf('Trombone power: L = %f  , R = %f\n', opto(name_map('l_t_far')).control.getFocalPower.focal_power, opto(name_map('r_t_far')).control.getFocalPower.focal_power);
fprintf('Trombone position: L = %f  , R = %f\n',  zaber(name_map('l_trombone')).control.getposition,  zaber(name_map('r_trombone')).control.getposition);

disp(['Subject #' n2s(sn) ey ' EYE ACL' n2s(ACL) ' EXPERIMENT ' ex ' PRESS CTRL+C TO ABORT OR ANY OTHER KEY TO START']); KbWait([], 2);

[window1, window2, vbl0]=strt_psych0(screenNumber-2, screenNumber-1, 0);

cf=ones(3,2);
if ey(1)=='R'; cf(:,2)=0; elseif ey(1)=='L'; cf(:,1)=0; end

AFCfls0=[filePath 'S' num2str(sn) 'V' num2str(vs) '_AFC_' ey 'ACL' n2s(ACL) '_' tme];

imPattern = {};
im1 = imread('H:\Shared drives\CIVO_BVAMS\stimuli\word_image_01.png');
im1(im1>0) = 255;
im1 = flipud(im1);   
imPatternTmp = squeeze(im1(:,:,3));
imPatternTmp = [zeros([30 size(imPatternTmp,2)]); imPatternTmp; zeros([30 size(imPatternTmp,2)])];
imPatternTmp = [zeros([size(imPatternTmp,1) 30]) imPatternTmp zeros([size(imPatternTmp,1) 30])];
imPattern{1} = imPatternTmp;
im2 = imread('H:\Shared drives\CIVO_BVAMS\stimuli\word_image_02.png');
im2(im2>0) = 255;
im2 = flipud(im2); 
imPatternTmp = squeeze(im2(:,:,3));
imPatternTmp = [zeros([30 size(imPatternTmp,2)]); imPatternTmp; zeros([30 size(imPatternTmp,2)])];
imPatternTmp = [zeros([size(imPatternTmp,1) 30]) imPatternTmp zeros([size(imPatternTmp,1) 30])];
imPattern{2} = imPatternTmp;
im3 = imread('H:\Shared drives\CIVO_BVAMS\stimuli\word_image_03.png');
im3(im3>0) = 255;
im3 = flipud(im3); 
imPatternTmp = squeeze(im3(:,:,3));
imPatternTmp = [zeros([30 size(imPatternTmp,2)]); imPatternTmp; zeros([30 size(imPatternTmp,2)])];
imPatternTmp = [zeros([size(imPatternTmp,1) 30]) imPatternTmp zeros([size(imPatternTmp,1) 30])];
imPattern{3} = imPatternTmp;
im4 = imread('H:\Shared drives\CIVO_BVAMS\stimuli\word_image_04.png');
im4(im4>0) = 255;
im4 = flipud(im4); 
imPatternTmp = squeeze(im4(:,:,3));
imPatternTmp = [zeros([30 size(imPatternTmp,2)]); imPatternTmp; zeros([30 size(imPatternTmp,2)])];
imPatternTmp = [zeros([size(imPatternTmp,1) 30]) imPatternTmp zeros([size(imPatternTmp,1) 30])];
imPattern{4} = imPatternTmp;
AFCp=ARCacuitySquareBasicFunc(imPattern,rgb,meanFocstmOptDst,frqCpd, contrast, window1, window2, trlPerLvl);    

if sv == 1
    save(AFCfls0, 'AFCp'); 
    load([filePath 'AFCfls' ey(1) '.mat'], 'AFCfls'); AFCfls{sn-1000,vs}=AFCfls0; 
    save([filePath 'AFCfls' ey(1) '.mat'], 'AFCfls'); 
end

opto(name_map('l_disp')).control.setFocalPower(14);
opto(name_map('r_disp')).control.setFocalPower(14.3);
% zaber(name_map('rotation')).move_deg(-3); %%-6400
[iLf iRf]=cwin3(imread('black.png'), imread('black.png') , cf, rc00, window2, window1);
clear LCAim;
sca;

psyfitgengauss(zeros(size(AFCp.frqCpd)),AFCp.contrast,AFCp.rspAcu'==AFCp.stimOrientation,[],[],[],1,2,1);