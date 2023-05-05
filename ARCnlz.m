function ARCnlz         

sn = 4; 
vs = 23;
ey = 1; % 1 for Right eye, 2 for Binocular ');
filePath = 'G:\My Drive\exp_bvams\code_repo\';

if strcmp(getenv('username'),'bankslab')
    % THIS JUST LOADS A FILE CONTAINING FILE NAMES OF .mat FILES CONTAINING
    % METADATA FOR EACH EXPERIMENT BLOCK    
    if ey(1)==2
        load([filePath 'ARC\AFCflsB.mat']); c1=2;
    elseif ey(1)==1
        load([filePath 'ARC\AFCflsR.mat']); c1=1;
    end
    % LOADS .mat FILE CONTAINING METADATA FOR EXPERIMENT BLOCK    
    fnm=AFCfls{sn, vs}; load(fnm);
    % LOADS FILE OF ACTUAL DATA    
    [jsonFile,jsonPath] = uigetfile('*.json','' , 'G:\My Drive\ARchromaVideoCapture\videos\processed\centralperipheral_real'); %stim conputer
else
    dataDirectory = '/Users/benchin/Documents/ARchroma/';
    % THIS JUST LOADS A FILE CONTAINING FILE NAMES OF .mat FILES CONTAINING
    % METADATA FOR EACH EXPERIMENT BLOCK
    if ey(1)==2
        load([dataDirectory 'AFCflsB.mat']); c1=2;
    elseif ey(1)==1
        load([dataDirectory 'AFCflsR.mat']); c1=1;
    end
    % LOADS .mat FILE CONTAINING METADATA FOR EXPERIMENT BLOCK
    fnmTmp=AFCfls{sn, vs}; load([dataDirectory fnmTmp(37:end)])
    % CONVERTING DATE OF .mat FILE TO JSON FILE NAME
    dateCode = fnmTmp((end-9):end);
    jsonFile = ['20' dateCode(1:2) '-' dateCode(3:4) '-' dateCode(5:6) ' ' dateCode(7:8) '.' dateCode(9:10) '.json'];
    jsonPath = dataDirectory;
end

% dt=jsondecode(jsonFile);
dt=jsondecode(fileread([jsonPath jsonFile]));

% GRABS RAW PIXEL SEPARATIONS BETWEEN AUTOREFRACTOR BARS
x=-1.*[(cell2mat(struct2cell(dt.ext_right_mu))-cell2mat(struct2cell(dt.ext_left_mu)))];
y=-1.*[(cell2mat(struct2cell(dt.ext_bottom_mu))-cell2mat(struct2cell(dt.ext_top_mu)))];
           
% THIS BLOCK SORTS THE DATA BY TRIAL
t3=cell2mat(struct2cell(dt.time_totalsecs));
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
    for k0=1:size(indCnd,1)
       % ANALYZING SUBJECT'S ACCOMMODATION
       x2{k0}=x0{indCnd(k0)}-mean(x1); % MEAN CENTERING
       y2{k0}=y0{indCnd(k0)}-mean(y1); % MEAN CENTERING
       x3=[x3 x2{k0}'];
       y3=[y3 y2{k0}'];
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
       meanChangeX(i,k0) = sum(diffVec.*x2{k0}')./xScale
       meanChangeY(i,k0) = sum(diffVec.*y2{k0}')./yScale
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
end

for i = 1:size(uniqueRGBvalues,1)
    indRGB = ismember(uniqueConditions(:,1:6),uniqueRGBvalues(i,:),'rows');
    stepSizes = uniqueConditions(indRGB,7);
    figure;
    set(gcf,'Position',[207 534 1240 420]);
    for j = 1:length(stepSizes)
        indUnq = ismember(uniqueConditions(:,1:6),uniqueRGBvalues(i,:),'rows') ...
                  & abs(uniqueConditions(:,7)-stepSizes(j))<0.001;        
        subplot(1,length(stepSizes)+1,j);
        set(gca,'FontSize',15);
        hold on;
        plot([1:length(timeSeries{indUnq,1})], [timeSeries{indUnq,1}; timeSeries{indUnq,2}])
        rgbValuesTmp = rgbValuesAll{indUnq};
        plot([1:length(timeSeries{indUnq,1})], [rgbValuesTmp(1,:)],'r')
        plot([1:length(timeSeries{indUnq,1})], [rgbValuesTmp(2,:)],'g')
        plot([1:length(timeSeries{indUnq,1})], [rgbValuesTmp(3,:)],'b')
        xlabel('Frame'); ylabel('Power (Diopters)'); title(['Step size = ' num2str(stepSizes(j)*optDistScale)]); legend('Horizontal', 'Vertical','R', 'G', 'B')        
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
        changeLabels{j} = ['H' stepString(int16(1+(1+sign(stepSizes(j)))/2))]
        changeLabels{j+length(stepSizes)} = ['V' stepString(int16(1+(1+sign(stepSizes(j)))/2))];
    end
    ylabel('Mean Accommodative Response (D)');
    set(gca,'FontSize',15);
    set(gca,'XTick',[1:length(stepSizes)*2]);
    set(gca,'XTickLabel',changeLabels);        
end

end