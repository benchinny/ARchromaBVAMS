function ARCnlz         

sn = 4; 
vs = 21:23;
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
for i = 1:size(uniqueConditions,1)
    % INDEX OF COLOR CONDITIONS
    indCnd = find(ismember([AFCp.rgb100 AFCp.rgb200 AFCp.v00],uniqueConditions(i,:),'rows'));
    clear x2 y2 x3 y3;
    x3=[]; y3=[]; 
    rgbValues = [];
    trialMarkerForPlot = [];
    for k0=1:size(indCnd,1)
       % ANALYZING SUBJECT'S ACCOMMODATION
       x2{k0}=x0{indCnd(k0)}-mean(x1); % MEAN CENTERING
       y2{k0}=y0{indCnd(k0)}-mean(y1); % MEAN CENTERING
       x3=[x3 x2{k0}'];
       y3=[y3 y2{k0}'];
       trialMarkerForPlot(k0) = length(x3);
       % ACCOMMODATIVE DEMAND FROM EXPERIMENT 
       sinValuesTmp = AFCp.sinValues(indCnd(k0),:);
       tSin = 0:(1/(length(sinValuesTmp)-1)):1;
       tSinInterp = 0:(1/(length(x2{k0})-1)):1;
       accContinuous = interp1(tSin,sinValuesTmp,tSinInterp); 
       % THIS IS AN OBNOXIOUS WAY OF COMPUTING THE AVERAGE CHANGE WITHIN A
       % TRIAL, BUT IT WORKS AND MAY BE A BIT MORE ROBUST
       diffVec = imresize([-2/length(accContinuous) 2/length(accContinuous)],size(accContinuous),'nearest');
       if abs(corr(accContinuous',diffVec'))<0.95
           error('ARCnlz: you may want to check whether the step change occurs halfway through the trial, or not!');
       end
       meanChangeX(i,k0) = sum(diffVec.*x2{k0}')./xScale;
       meanChangeY(i,k0) = sum(diffVec.*y2{k0}')./yScale;
       % VECTOR OF RGB VALUES FOR PLOTTING
       rgbValues = [rgbValues imresize([AFCp.rgb100(indCnd(k0),:)' AFCp.rgb200(indCnd(k0),:)'],[3 length(tSinInterp)],'nearest')];
    end
    x3=x3./xScale; y3=y3./yScale;
    blinkCutoff = 10; % CUTOFF FOR REMOVING OUTLIERS
    x3(x3>blinkCutoff | x3<-blinkCutoff) = 0;
    y3(y3>blinkCutoff | y3<-blinkCutoff) = 0;
    % STORE ACCOMMODATION AND COLOR VALUES FOR PLOTTING
    timeSeries{i,1} = x3;
    timeSeries{i,2} = y3;
    rgbValuesAll{i} = rgbValues;
    trialMarkerForPlotCell{i} = trialMarkerForPlot;
end

for i = 1:size(uniqueRGBvalues,1)
    indRGB = ismember(uniqueConditions(:,1:6),uniqueRGBvalues(i,:),'rows');
    stepSizes = uniqueConditions(indRGB,7);
    figure;
    set(gcf,'Position',[207 534 1240 420]);
    for j = 1:length(stepSizes)
        indUnq = ismember(uniqueConditions(:,1:6),uniqueRGBvalues(i,:),'rows') ...
                  & abs(uniqueConditions(:,7)-stepSizes(j))<0.001;     
        trialMarkers = trialMarkerForPlotCell{indUnq};
        subplot(1,length(stepSizes)+1,j);
        set(gca,'FontSize',15);
        hold on;
        plot([1:length(timeSeries{indUnq,1})], [timeSeries{indUnq,1}; timeSeries{indUnq,2}]);
        ylimTmp = ylim;
        for k = 1:length(trialMarkers)
            plot(trialMarkers(k).*[1 1],ylimTmp,'-','Color',[0.5 0.5 0.5],'LineWidth',1);
        end        
        xlabel('Frame'); ylabel('Power (Diopters)'); 
        title(['Step = ' num2str(stepSizes(j)*optDistScale) ...
              ', RGB = [' num2str(uniqueRGBvalues(i,1)) ' ' num2str(uniqueRGBvalues(i,2)) ' ' num2str(uniqueRGBvalues(i,3)) '] to ['...
              num2str(uniqueRGBvalues(i,4)) ' ' num2str(uniqueRGBvalues(i,5)) ' ' num2str(uniqueRGBvalues(i,6)) ']']); 
        legend('Horizontal', 'Vertical');
    end
    subplot(1,length(stepSizes)+1,length(stepSizes)+1);
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
end

end