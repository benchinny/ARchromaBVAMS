function ARCnlz         
sn=input('Subject Number? '); sn=sn+1000;
vs=input('Visit Number? ');
ey=input('Eye? 1forRight 2forBinocular ');
filePath = 'G:\My Drive\exp_bvams\code_repo\';

if strcmp(getenv('username'),'benchin')
    % THIS JUST LOADS A FILE CONTAINING FILE NAMES OF .mat FILES CONTAINING
    % METADATA FOR EACH EXPERIMENT BLOCK
    if ey(1)==2
        load('/Users/benchin/Documents/ARchroma/AFCflsB.mat'); c1=2;
    elseif ey(1)==1
        load('/Users/benchin/Documents/ARchroma/AFCflsR.mat'); c1=1;
    end
    % LOADS .mat FILE CONTAINING METADATA FOR EXPERIMENT BLOCK
    fnmTmp=AFCfls{sn-1000, vs}; load(['/Users/benchin/Documents/ARchroma/' fnmTmp(37:end)])
    % LOADS FILE OF ACTUAL DATA
    [jsonFile,jsonPath] = uigetfile('*.json','' , '/Users/benchin/Documents/ARchroma/');
else
    if ey(1)==2
        load('G:\My Drive\exp_bvams\code_repo\ARC\AFCflsB.mat'); c1=2;
    elseif ey(1)==1
        load('G:\My Drive\exp_bvams\code_repo\ARC\AFCflsR.mat'); c1=1;
    end
    fnm=AFCfls{sn-1000, vs}; load(fnm);
    [jsonFile,jsonPath] = uigetfile('*.json','' , 'G:\My Drive\ARchromaVideoCapture\videos\processed\centralperipheral_real'); %stim conputer
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
uniqueRGBvalues = unique([AFCp.rgb100 AFCp.rgb200],'rows');
for i = 1:size(uniqueRGBvalues,1)
    % INDEX OF COLOR CONDITIONS
    indCnd = find(ismember([AFCp.rgb100 AFCp.rgb200],uniqueRGBvalues(i,:),'rows'));
    clear x2 y2 x3 y3;
    x3=[]; y3=[]; 
    v3=[]; 
    rgbValues = [];
    for k0=1:size(indCnd,1)
       x2{k0}=x0{indCnd(k0)}-mean(x1); % MEAN CENTERING
       y2{k0}=y0{indCnd(k0)}-mean(y1); % MEAN CENTERING
       x3=[x3 x2{k0}'];
       y3=[y3 y2{k0}'];
       sinValuesTmp = AFCp.sinValues(indCnd(k0),:); % ACCOMMODATIVE DEMAND FROM EXPERIMENT
       tSin = 0:(1/(length(sinValuesTmp)-1)):1;
       tSinInterp = 0:(1/(length(x2{k0})-1)):1;
       v3 = [v3 interp1(tSin,sinValuesTmp,tSinInterp)];
       rgbValues = [rgbValues imresize([AFCp.rgb100(indCnd(k0),:)' AFCp.rgb200(indCnd(k0),:)'],[3 length(tSinInterp)],'nearest')];
    end
    x3=x3./-2.87; y3=y3./-2.58;
    blinkCutoff = 3; % CUTOFF FOR REMOVING OUTLIERS
    x3(x3>blinkCutoff | x3<-blinkCutoff) = 0;
    y3(y3>blinkCutoff | y3<-blinkCutoff) = 0;
    figure;
    set(gcf,'Position',[429 518 956 420]);

    subplot(1,2,1);
    set(gca,'FontSize',15);
    hold on;
    plot([1:length(x3)], [x3; y3])
    plot([1:length(x3)], [rgbValues(1,:)],'r')
    plot([1:length(x3)], [rgbValues(2,:)],'g')
    plot([1:length(x3)], [rgbValues(3,:)],'b')
    xlabel('Frame'); ylabel('Power (Diopters)'); title('Autorefractor measurement'); legend('Horizontal', 'Vertical','R', 'G', 'B')
    indMean1 = abs(rgbValues(1,:)-uniqueRGBvalues(i,1))<0.001 & ...
               abs(rgbValues(2,:)-uniqueRGBvalues(i,2))<0.001 & ...
               abs(rgbValues(3,:)-uniqueRGBvalues(i,3))<0.001;
    indMean2 = abs(rgbValues(1,:)-uniqueRGBvalues(i,4))<0.001 & ...
               abs(rgbValues(2,:)-uniqueRGBvalues(i,5))<0.001 & ...
               abs(rgbValues(3,:)-uniqueRGBvalues(i,6))<0.001; 

    subplot(1,2,2);
    hold on;
    bar(1,mean(x3(indMean1)),'FaceColor',uniqueRGBvalues(i,1:3));
    bar(2,mean(x3(indMean2)),'FaceColor',uniqueRGBvalues(i,4:6));
    bar(3,mean(y3(indMean1)),'FaceColor',uniqueRGBvalues(i,1:3));
    bar(4,mean(y3(indMean2)),'FaceColor',uniqueRGBvalues(i,4:6));
    errorbar(1,mean(x3(indMean1)),std(x3(indMean1)),'.k');
    errorbar(2,mean(x3(indMean2)),std(x3(indMean2)),'.k');
    errorbar(3,mean(y3(indMean1)),std(y3(indMean1)),'.k');
    errorbar(4,mean(y3(indMean2)),std(y3(indMean2)),'.k');
    axis square;
    ylabel('Mean Accommodative Response (D)');
    set(gca,'FontSize',15);
    set(gca,'XTick',[1:4]);
    set(gca,'XTickLabel',{'Horz','Horz','Vert','Vert'});
end

end