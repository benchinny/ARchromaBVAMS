function ARCnlz         

sn = 17; % CURRENTLY HAVE SUBJECTS 11 THROUGH 17
bEXCLUDE = true; % EXCLUDE BLINKS AND BAD TRIALS? 
bSTACK = true; % STACK ACCOMMODATIVE TRACES IN FIGURES?
bLeaveOutTransitions = false; % LEAVE OUT FIRST 50 FRAMES AND TRANSITION PERIOD OF ACCOMMODATION?

gammaFactorR = 2.4; % GAMMA CORRECTION FOR MONITOR RGB PRIMARY VALUES

if sn==11 % 'VISIT' NUMBERS
   vs = [2 3 4 7];
   excludeTrials = [];
elseif sn==12
   vs = [3:7];
   excludeTrials = [87 7 3 4 5 90 91 10 6 86 88];
elseif sn==13
   vs = 1:4;
   excludeTrials = [59 39 38 58 77 56 60 74];
elseif sn==14
   vs = 1:4;
   excludeTrials = [];    
elseif sn==15
   vs = [7:10];
   excludeTrials = [49];  
elseif sn==16
   vs = 2:5;
   excludeTrials = [];     
elseif sn==17
   vs = 1:4;
   excludeTrials = [];        
else
   error('ARCnlz: unhandled subject number!');
end
ey = 1; % 1 for Right eye, 2 for Binocular ');
filePath = 'G:\My Drive\exp_bvams\code_repo\';


if strcmp(getenv('username'),'bankslab')
   dataDirectory = [filePath 'ARC\'];
else
   dataDirectory = '/Users/benchin/Documents/ARchroma/'; 
end
% THIS JUST LOADS A FILE CONTAINING FILE NAMES OF .mat FILES CONTAINING
% METADATA FOR EACH EXPERIMENT BLOCK
if ey(1)==2
    load([dataDirectory 'AFCflsB.mat']); c1=2;
elseif ey(1)==1
    load([dataDirectory 'AFCflsR.mat']); c1=1;
end
x = [];
y = [];
t3 = [];
for i = 1:length(vs)
    if strcmp(getenv('username'),'bankslab')
        fnm=AFCfls{sn, vs(i)};
        fnmTmp = fnm;
        load(fnm);
    else
        % LOADS .mat FILE CONTAINING METADATA FOR EXPERIMENT BLOCK
        fnmTmp=AFCfls{sn, vs(i)};         
        load([dataDirectory fnmTmp(37:end)]);
    end
    if i==1
       AFCpAll = AFCp;
    else
       AFCpAll = structmerge(AFCpAll,AFCp,length(AFCp.v00));
    end
    dateCodeAll = [];
    % CONVERTING DATE OF .mat FILE TO JSON FILE NAME
    dateCode = fnmTmp((end-9):end);
    dateCodeAll = [dateCodeAll; dateCode];
    dateCode(end) = dateCode(end)-1; % THE NEXT FEW LINES ARE FOR ADDING ROBUSTNESS
    dateCodeAll = [dateCodeAll; dateCode];
    dateCode(end) = dateCode(end)+2;
    dateCodeAll = [dateCodeAll; dateCode];
    if strcmp(getenv('username'),'bankslab')
        jsonDirectory = 'G:\My Drive\ARchromaVideoCapture\videos\processed\centralperipheral_real\';
    else
        jsonDirectory = dataDirectory;
    end    
    jsonFile = [];
    for j = 1:size(dateCodeAll,1) % FOR ROBUSTNESS: SOMETIMES THE FILENAMES DON'T MATCH EXACTLY
        jsonFileStr = ['20' dateCodeAll(j,1:2) '-' dateCodeAll(j,3:4) '-' dateCodeAll(j,5:6) ' ' dateCodeAll(j,7:8) '.' dateCodeAll(j,9:10) '.json'];
        if isfile([jsonDirectory jsonFileStr])
            jsonFile = jsonFileStr;
        end
    end
    jsonPath = jsonDirectory;
    dt=jsondecode(fileread([jsonPath jsonFile]));
    % GRABS RAW PIXEL SEPARATIONS BETWEEN AUTOREFRACTOR BARS
    x=[x; -1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))]];
    y=[y; -1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))]];

    % THIS BLOCK SORTS THE DATA BY TRIAL
    t3=[t3; cell2mat(struct2cell(dt.time_totalsecs))];           
end
AFCp = AFCpAll;

v0=[find(diff(t3)>1); length(t3)];
i0=1;
for k0=1:length(v0);
   v1=i0:v0(k0);
   x0{k0}=x(v1);
   y0{k0}=y(v1);
   i0=v0(k0)+1;
end

% FINDS AUTOREFRACTOR VALUES FOR 'REFERENCE' ACCOMMODATION (SOME
% FLEXIBILITY HERE ABOUT HOW TO DEFINE THE REFERENCE)
i0=find(AFCp.v00(:,1)==0);
i0 = 1;
x1=[]; y1=[];
for k0=1:length(i0)
 x1=[x1 x0{i0(k0)}'];
 y1=[y1 y0{i0(k0)}'];  
end
x1 = x1(1:10);
y1 = y1(1:10);

% MAIN ANALYSIS
uniqueConditions = unique([AFCp.rgb100 AFCp.rgb200 AFCp.v00],'rows');
uniqueRGBvalues = unique([AFCp.rgb100 AFCp.rgb200],'rows');
xScale = -2.87; % SCALE FACTOR CONVERTING PIXELS TO DIOPTERS
yScale = -2.58; % SCALE FACTOR CONVERTING PIXELS TO DIOPTERS
optDistScale = 0.8;
timeSeries = {};
rgbValuesAll = {};
x3stack = zeros([length(AFCp.AFCv) 400]);
y3stack = zeros([length(AFCp.AFCv) 400]);

for i = 1:size(uniqueConditions,1)
    % INDEX OF COLOR CONDITIONS
    indCnd = find(ismember([AFCp.rgb100 AFCp.rgb200 AFCp.v00],uniqueConditions(i,:),'rows'));
    if bEXCLUDE
       indCnd = indCnd(~ismember(indCnd,excludeTrials));
    end
    clear x2 y2 x3 y3;
    x3=[]; y3=[]; 
    rgbValues = [];
    trialMarkerForPlot = [];
    for k0=1:size(indCnd,1)
       % ANALYZING SUBJECT'S ACCOMMODATION
       x2{k0}=x0{indCnd(k0)}-mean(x1); % MEAN CENTERING
       y2{k0}=y0{indCnd(k0)}-mean(y1); % MEAN CENTERING
       x3tmp = (x2{k0}')./xScale;
       y3tmp = (y2{k0}')./yScale;
       % REMOVING OUTLIERS
       x3diff = [0 diff(x3tmp)];
       y3diff = [0 diff(y3tmp)];
       x3outliers = abs(x3diff)>1 | abs(x3tmp)>5;
       y3outliers = abs(y3diff)>1 | abs(y3tmp)>5;
       meanx3 = mean(x3tmp(~x3outliers));
       meany3 = mean(y3tmp(~y3outliers));
       if bEXCLUDE
           x3tmp(x3outliers) = meanx3;
           y3tmp(y3outliers) = meany3;
       end       
       x3=[x3 x3tmp];
       y3=[y3 y3tmp];
       x3stack(indCnd(k0),1:length(x3tmp)) = x3tmp;
       y3stack(indCnd(k0),1:length(y3tmp)) = y3tmp;
       trialMarkerForPlot(k0) = length(x3);
       % ACCOMMODATIVE DEMAND FROM EXPERIMENT 
       sinValuesTmp = AFCp.sinValues(indCnd(k0),:);
       tSin = 0:(1/(length(sinValuesTmp)-1)):1;
       tSinInterp = 0:(1/(length(x2{k0})-1)):1;
       accContinuous = interp1(tSin,sinValuesTmp,tSinInterp); 
       % THIS IS AN OBNOXIOUS WAY OF COMPUTING THE AVERAGE CHANGE WITHIN A
       % TRIAL, BUT IT WORKS AND MAY BE A BIT MORE ROBUST
       if bLeaveOutTransitions
          diffVec = imresize([0 -4/length(accContinuous) 0 4/length(accContinuous)],size(accContinuous),'nearest');
       else
           diffVec = imresize([-2/length(accContinuous) 2/length(accContinuous)],size(accContinuous),'nearest');
           if abs(corr(accContinuous',diffVec'))<0.95
               error('ARCnlz: you may want to check whether the step change occurs halfway through the trial, or not!');
           end
       end
       meanChangeX(i,k0) = sum(diffVec.*x2{k0}')./xScale;
       meanChangeY(i,k0) = sum(diffVec.*y2{k0}')./yScale;
       % VECTOR OF RGB VALUES FOR PLOTTING
       rgbValues = [rgbValues imresize([AFCp.rgb100(indCnd(k0),:)' AFCp.rgb200(indCnd(k0),:)'],[3 length(tSinInterp)],'nearest')];
    end

    % STORE ACCOMMODATION AND COLOR VALUES FOR PLOTTING
    timeSeries{i,1} = x3;
    timeSeries{i,2} = y3;
    rgbValuesAll{i} = rgbValues;
    trialMarkerForPlotCell{i} = trialMarkerForPlot;
    indCndCell{i} = indCnd;
end

figSize = 3;

% SCRAMBLING CONDITIONS FOR ORGANIZING PLOTS LATER
indB2mixed = uniqueRGBvalues(:,1)<0.0001 & uniqueRGBvalues(:,2)<0.0001 ...
           & uniqueRGBvalues(:,3)>0.0001 & uniqueRGBvalues(:,4)>0.0001 ...
           & uniqueRGBvalues(:,5)<0.0001 & uniqueRGBvalues(:,6)>0.0001;

indR2mixed = uniqueRGBvalues(:,1)>0.0001 & uniqueRGBvalues(:,2)<0.0001 ...
           & uniqueRGBvalues(:,3)<0.0001 & uniqueRGBvalues(:,4)>0.0001 ...
           & uniqueRGBvalues(:,5)<0.0001 & uniqueRGBvalues(:,6)>0.0001;

indSame = (uniqueRGBvalues(:,1)>0.0001 & uniqueRGBvalues(:,2)<0.0001 ...
        & uniqueRGBvalues(:,3)<0.0001 & uniqueRGBvalues(:,4)>0.0001 ...
        & uniqueRGBvalues(:,5)<0.0001 & uniqueRGBvalues(:,6)<0.0001) ...
        | (uniqueRGBvalues(:,1)<0.0001 & uniqueRGBvalues(:,2)<0.0001 ...
        & uniqueRGBvalues(:,3)>0.0001 & uniqueRGBvalues(:,4)<0.0001 ...
        & uniqueRGBvalues(:,5)<0.0001 & uniqueRGBvalues(:,6)>0.0001);

indR2BorB2R = (uniqueRGBvalues(:,1)>0.0001 & uniqueRGBvalues(:,2)<0.0001 ...
             & uniqueRGBvalues(:,3)<0.0001 & uniqueRGBvalues(:,4)<0.0001 ...
             & uniqueRGBvalues(:,5)<0.0001 & uniqueRGBvalues(:,6)>0.0001) ...
            | (uniqueRGBvalues(:,1)<0.0001 & uniqueRGBvalues(:,2)<0.0001 ...
             & uniqueRGBvalues(:,3)>0.0001 & uniqueRGBvalues(:,4)>0.0001 ...
             & uniqueRGBvalues(:,5)<0.0001 & uniqueRGBvalues(:,6)<0.0001);

uniqueRGBvalues = [uniqueRGBvalues(indSame,:); uniqueRGBvalues(indR2BorB2R,:); uniqueRGBvalues(indB2mixed,:); uniqueRGBvalues(indR2mixed,:)];
biasPlotTags = cumsum([sum(indSame) sum(indR2BorB2R) sum(indB2mixed) sum(indR2mixed)]);

biasX = [];
biasY = [];

for i = 1:size(uniqueRGBvalues,1)
    indRGB = ismember(uniqueConditions(:,1:6),uniqueRGBvalues(i,:),'rows');
    stepSizes = uniqueConditions(indRGB,7);
    biasX(i,:) = mean(meanChangeX(indRGB,:),1);
    biasY(i,:) = mean(meanChangeY(indRGB,:),1);
    rowNum = mod(i,figSize);
    if rowNum==0
       rowNum = figSize;
    end
    if rowNum==1
        figNum = floor(i/figSize)+1;
        figure(figNum);
        set(gcf,'Position',[207 189 1240 765]);
    end
    for j = 1:length(stepSizes)
        colNum = length(stepSizes)+1;
        indUnq = ismember(uniqueConditions(:,1:6),uniqueRGBvalues(i,:),'rows') ...
                  & abs(uniqueConditions(:,7)-stepSizes(j))<0.001;     
        trialMarkers = trialMarkerForPlotCell{indUnq};
        indCndMarkers = indCndCell{indUnq};
        subplot(figSize,colNum,j+(rowNum-1)*colNum);
        set(gca,'FontSize',15);
        if bSTACK
            hold on;
            plot(x3stack(indCndMarkers,:)','-','Color',[0 0.45 0.74]);
            plot(y3stack(indCndMarkers,:)','-','Color',[0.85 0.33 0.1]);
            plot(mean(x3stack(indCndMarkers,:),1),'-','Color',[0 0.45 0.74],'LineWidth',2);
            plot(mean(y3stack(indCndMarkers,:),1),'-','Color',[0.85 0.33 0.1],'LineWidth',2);
            xlim([0 220]);
            ylim([-3 3]);
        else
            hold on;
            plot([1:length(timeSeries{indUnq,1})], [timeSeries{indUnq,1}; timeSeries{indUnq,2}]);
            ylimTmp = ylim;
            for k = 1:length(trialMarkers)
                plot(trialMarkers(k).*[1 1],ylimTmp,'-','Color',[0.5 0.5 0.5],'LineWidth',1);
                text(trialMarkers(k)-length(timeSeries{indUnq,1})./(2*length(trialMarkers)),ylimTmp(2)/2,num2str(indCndMarkers(k)));
            end
            ylim([-3 3]);
        end
        xlabel('Frame'); ylabel('Power (Diopters)'); 
        title(['Step = ' num2str(stepSizes(j)*optDistScale) ...
              ', RGB = [' num2str(uniqueRGBvalues(i,1)) ' ' num2str(uniqueRGBvalues(i,2)) ' ' num2str(uniqueRGBvalues(i,3)) '] to ['...
              num2str(uniqueRGBvalues(i,4)) ' ' num2str(uniqueRGBvalues(i,5)) ' ' num2str(uniqueRGBvalues(i,6)) ']']); 
        if ~bSTACK
           legend('Horizontal', 'Vertical');
        end
    end
    subplot(figSize,length(stepSizes)+1,colNum+colNum*(rowNum-1));
    hold on;
    changeLabels = {};
    for j = 1:length(stepSizes)
        indUnq = ismember(uniqueConditions(:,1:6),uniqueRGBvalues(i,:),'rows') ...
                  & abs(uniqueConditions(:,7)-stepSizes(j))<0.001;   
        bar(j,mean(meanChangeX(indUnq,:)),'FaceColor','w');
        bar(j+length(stepSizes),mean(meanChangeY(indUnq,:)),'FaceColor','w');
        errorbar(j,mean(meanChangeX(indUnq,:)),std(meanChangeX(indUnq,:)),'k');
        errorbar(j+length(stepSizes),mean(meanChangeY(indUnq,:)),std(meanChangeY(indUnq,:)),'k');
        stepString = '-+';
        changeLabels{j} = ['H' stepString(int16(1+(1+sign(stepSizes(j)))/2))];
        changeLabels{j+length(stepSizes)} = ['V' stepString(int16(1+(1+sign(stepSizes(j)))/2))];
    end
    ylabel('Mean Accommodative Response (D)');
    set(gca,'FontSize',15);
    set(gca,'XTick',[1:length(stepSizes)*2]);
    set(gca,'XTickLabel',changeLabels);        
    ylim([-2 2]);
end

figure;
set(gcf,'Position',[207 189 1240 765]);
subplot(2,2,1);
hold on;
for i = 1:biasPlotTags(1)
    errorbar(i,mean(biasX(i,:)),std(biasX(i,:)),'.','LineWidth',2,'MarkerSize',15,'Color',uniqueRGBvalues(i,1:3));
    plot(i,mean(biasX(i,:)),'o','LineWidth',2,'MarkerSize',15,'MarkerFaceColor','w','Color',uniqueRGBvalues(i,1:3));
end
axis square;
set(gca,'FontSize',15);
set(gca,'XTick',1:biasPlotTags(1));
xlabel('Condition');
ylabel('Accommodative Bias (D)');
xlim([0 biasPlotTags(1)+1]);
ylim([-2 2]);
title('Narrowband no change');

subplot(2,2,2);
hold on;
for i = (biasPlotTags(1)+1):biasPlotTags(2)
    errorbar(i-biasPlotTags(1),mean(biasX(i,:)),std(biasX(i,:)),'.','LineWidth',2,'MarkerSize',15,'Color',uniqueRGBvalues(i,1:3));
    plot(i-biasPlotTags(1),mean(biasX(i,:)),'o','LineWidth',2,'MarkerSize',15,'MarkerFaceColor','w','Color',uniqueRGBvalues(i,1:3));
end
axis square;
set(gca,'FontSize',15);
set(gca,'XTick',1:(biasPlotTags(2)-biasPlotTags(1)));
xlabel('Condition');
ylabel('Accommodative Bias (D)');
xlim([0 biasPlotTags(2)-biasPlotTags(1)+1]);
ylim([-2 2]);
title('Narrowband with change');

subplot(2,2,3);
hold on;
for i = (biasPlotTags(2)+1):biasPlotTags(3)
    errorbar(uniqueRGBvalues(i,4).^gammaFactorR,mean(biasX(i,:)),std(biasX(i,:)),'.','LineWidth',2,'MarkerSize',15,'Color',uniqueRGBvalues(i,1:3));
    plot(uniqueRGBvalues(i,4).^gammaFactorR,mean(biasX(i,:)),'o','LineWidth',2,'MarkerSize',15,'MarkerFaceColor','w','Color',uniqueRGBvalues(i,1:3));
end
axis square;
set(gca,'FontSize',15);
xlabel('Amount of red (% max)');
ylabel('Accommodative Bias (D)');
xlim([-0.1 0.4]);
ylim([-1 1]);
title('Blue to mixed');

subplot(2,2,4);
hold on;
for i = (biasPlotTags(3)+1):biasPlotTags(4)
    errorbar(uniqueRGBvalues(i,1).^gammaFactorR,mean(biasX(i,:)),std(biasX(i,:)),'.','LineWidth',2,'MarkerSize',15,'Color',uniqueRGBvalues(i,1:3));
    plot(uniqueRGBvalues(i,1).^gammaFactorR,mean(biasX(i,:)),'o','LineWidth',2,'MarkerSize',15,'MarkerFaceColor','w','Color',uniqueRGBvalues(i,1:3));
end
axis square;
set(gca,'FontSize',15);
xlabel('Amount of red (% max)');
ylabel('Accommodative Bias (D)');
xlim([-0.1 0.4]);
ylim([-1 1]);
title('Red to mixed');

if bSTACK
    for i = 1:size(uniqueRGBvalues,1)
        indRGB = ismember(uniqueConditions(:,1:6),uniqueRGBvalues(i,:),'rows');
        stepSizes = uniqueConditions(indRGB,7);    
        for j = 1:length(stepSizes)
            indUnq = ismember(uniqueConditions(:,1:6),uniqueRGBvalues(i,:),'rows') ...
                      & abs(uniqueConditions(:,7)-stepSizes(j))<0.001;    
            indCndMarkers = indCndCell{indUnq};        
        end
    end
end

end