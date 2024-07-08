%%211102 DSP_IMG

ey = 'R';
[window1, window2, vbl0]=strt_psych0(screenNumber-2, screenNumber-1, 0);
power_dispL_min = 7;
power_dispL_max = 16;
power_dispR_min = 7;
power_dispR_max = 16.4;
adjustIncrement = 0.1;
stimColor = [0.555 0.418 1.00];

%%input a output b
cf=ones(3,2);

%initial  power=13.5 AR    
%LCAim='texture0_1080_newfill_malt.png';    
%im2R='black.png';       
% im2L='texture0_1080_newfill_malt.png';
% im2L = 'G:\My Drive\exp_bvams\code_repo\imgs\TCA_r540_k120_b108_cw5_sbm7.png';  
%im2L='vrn10_G_sd1.png';

deg=-3;            
zaber(name_map('rotation')).move_deg(deg); %%-6400            
zaber(name_map('rotation')).control.getposition  

if exist('sr') ~=  1; sr=[0 0]; end
%         dmnd=[-0.5:0.5:3]
opto(name_map('r_disp')).control.setFocalPower(13.9+sr(2));% -dmnd(k0));
opto(name_map('r_disp')).control.getFocalPower.focal_power

opto(name_map('l_disp')).control.setFocalPower(14+sr(1));%-dmnd(k0));
opto(name_map('l_disp')).control.getFocalPower.focal_power

bTexture = true;
if bTexture
    % ----LOADING IMAGE----------
    % im2L='texture0_nrm_rgb.png';
    im2L='H:\Shared drives\CIVO_BVAMS\stimuli\Bronco_the_Beagle.jpg';
    % im2L = 'TCA_r540_k120_b120_cw5.png';
    % im2L = 'testEresized.png';
    im2R=im2L;
    testim = imread(im2R);
    testim = imresize(testim,[floor(size(testim,1)/2) floor(size(testim,2)/2)]);
%    testim = 255.*ones(size(testim));
    % ---------------------------
    % ----MAKING GABOR-----------
    % testim = ARC2Dgabor(smpPos(512,512),[],0,0,30,1,-45,0,0.16,0.5,[0.25 0 0],1,1,0,0);
    % testim(:,:,1) = testim(:,:,1).^(1/2.4);
    % testim(:,:,3) = testim(:,:,3).^(1/2.2);    
    % testim = testim.*255;
    % ---------------------------
    % ----MAKING TUMBLING E------
%     acuStimOrig = imread('testEresized.png');
%     indGdAcu = acuStimOrig>0;
%     acuStimOrig(indGdAcu) = 255;
%     acuStimOrig(~indGdAcu) = 0;
%     acuStim = [];
%     acuStimTmp = imresize(acuStimOrig,200.*[1 1]);
%     acuStimTmpRGB = [];
%     acuStimTmpRGB(:,:,1) = acuStimTmp.*0.56;
%     acuStimTmpRGB(:,:,2) = acuStimTmp.*0;
%     acuStimTmpRGB(:,:,3) = acuStimTmp.*0;   
%     testim = acuStimTmpRGB;
    % ---------------------------
else
    wordInd = randsample(1:4,1);
    imB = imread(['H:\Shared drives\CIVO_BVAMS\stimuli\word_image_0' num2str(wordInd) '.png']);
    imB(imB>0) = 255;
    clrInd = 1;
    imBpad = [zeros([30 size(imB,2)]); imB(:,:,clrInd); zeros([30 size(imB,2)])];
    imBpad = [zeros([size(imBpad,1) 30]) imBpad zeros([size(imBpad,1) 30])];
    imB = zeros([size(imBpad,1) size(imBpad,2) 3]);
    imB(:,:,1) = imBpad.*stimColor(1);
    imB(:,:,2) = imBpad.*stimColor(2);
    imB(:,:,3) = imBpad.*stimColor(3);
    testim = flipud(imB);   
end
[iLf iRf]=cwin3(imread("black.png"), testim , cf, rc00, window2, window1);

power_dispL = 14;
power_dispR = 13.9;
power_dispRoriginal = 13.9;

rightTrombonePowerNear = opto(name_map('r_t_near')).control.getFocalPower.focal_power;
rightTrombonePowerFar = opto(name_map('r_t_far')).control.getFocalPower.focal_power;
rightTrombonePosition = zaber(name_map('r_trombone')).control.getposition;

fprintf('Trombone Near R = %f  , Trombone Far R = %f\n',rightTrombonePowerNear, rightTrombonePowerFar);

fprintf('\n');

addpath(genpath(fullfile('toolboxes')));
KbName('UnifyKeyNames');
KbWait([], 2); 

timeStartInit = clock;
timeStart = timeStartInit(4)*3600 + timeStartInit(5)*60 + timeStartInit(6);

%% Control loop
ListenChar(2);
try
    opt_chk=0;
    while opt_chk==0
        timeCurrentInit = clock;
        timeCurrent = timeCurrentInit(4)*3600 + timeCurrentInit(5)*60 + timeCurrentInit(6);
        timeDiff = timeCurrent-timeStart;
        if timeDiff>20
            opt_chk = 1;
        end
        incr = 2.*(sin(2*pi.*1.*timeDiff)+1);
        power_dispR=power_dispRoriginal-incr;
        opto(name_map('r_disp')).control.setFocalPower(power_dispR);   
        timeWaitRsp = clock;
        timeWaitRsp = timeWaitRsp(4)*3600 + timeWaitRsp(5)*60 + timeWaitRsp(6);
        opt_rsp = 0;
        counter = 0;
        while opt_rsp==0
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown
                opt_rsp = 1;
                opt_chk = 1;
            end
            timeRsp = clock;
            timeRsp = timeRsp(4)*3600 + timeRsp(5)*60 + timeRsp(6);
            timeRsp-timeWaitRsp
            if timeRsp-timeWaitRsp>2
                opt_rsp = 1;
                opt_chk = 1;
            else
                opt_rsp = 0;
            end                
            counter = counter+1;
            % % Key debounce routine, which waits for key to be released
            % while keyIsDown
            %     [ keyIsDown, keyTime, keyCode ] = KbCheck;
            % end            
        end
        fprintf('Display power: L = %f  , R = %f , Optical Distance R = %f D, time = %f \n',power_dispL, power_dispR, 1.*(14.4-power_dispR), timeDiff);
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

KbWait([], 2);
[iLf iRf]=cwin3(imread("black.png"), imread("black.png") , cf, rc00, window2, window1);

sca   
