%%

function [defocusLCAmeasured, q1best, q2best, q3best,defocusLCAmeasuredBoots,Dgreen] = ARCacuAnalysisLCA(subj,bPLOT,nBoots)
% filePath = 'G:\My Drive\exp_bvams\code_repo\ARC\';
filePath = 'H:\Shared drives\CIVO_BVAMS\data\ARC\';

bSave = 0;

if strcmp(getenv('username'),'bankslab')
   dataDirectory = [filePath];
elseif strcmp(getenv("USER"),'benjaminchin')
   dataDirectory = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/CIVO_BVAMS/data/ARC/'; 
elseif strcmp(getenv("USER"),'emily')
   dataDirectory = '/Users/emily/Library/CloudStorage/GoogleDrive-emilyacooper@gmail.com/Shared drives/ARChroma/Analysis/';
end
if subj==1
    % filenames = {
    %              [dataDirectory 'S1001V12_AFC_RightACL0_2408161637.mat'] ...
    %              [dataDirectory 'S1001V12_AFC_RightACL0_2408191326.mat'] ...
    %              [dataDirectory 'S1001V12_AFC_RightACL0_2408191333.mat'] ...
    %              [dataDirectory 'S1001V12_AFC_RightACL0_2408191345.mat'] ...
    %              [dataDirectory 'S1001V12_AFC_RightACL0_2408191352.mat'] ...
    %              [dataDirectory 'S1001V12_AFC_RightACL0_2408191359.mat'] ...
    %              [dataDirectory 'S1001V12_AFC_RightACL0_2408191417.mat'] ...
    %              [dataDirectory 'S1001V12_AFC_RightACL0_2408191424.mat'] ...
    %              [dataDirectory 'S1001V12_AFC_RightACL0_2408191432.mat'] ...
    %              [dataDirectory 'S1001V12_AFC_RightACL0_2408191439.mat'] ...
    %              };
    % filenames = {
    %              [dataDirectory 'S1011V9_AFC_RightACL0_2408290924.mat'] ...
    %              [dataDirectory 'S1011V9_AFC_RightACL0_2408290931.mat'] ...
    %              [dataDirectory 'S1011V9_AFC_RightACL0_2408290938.mat'] ...
    %              [dataDirectory 'S1011V9_AFC_RightACL0_2408290951.mat'] ...
    %              [dataDirectory 'S1011V9_AFC_RightACL0_2408291006.mat'] ...
    %              [dataDirectory 'S1011V9_AFC_RightACL0_2408291021.mat'] ...           
    %              };    
    filenames = {
                 [dataDirectory 'S1011V18_AFC_RightACL0_2410290922.mat'] ...
                 [dataDirectory 'S1011V18_AFC_RightACL0_2410290936.mat'] ...
                 [dataDirectory 'S1011V18_AFC_RightACL0_2410290949.mat'] ...  
                 [dataDirectory 'S1011V18_AFC_RightACL0_2410291002.mat'] ...    
                 [dataDirectory 'S1011V18_AFC_RightACL0_2410291014.mat'] ...     
                 [dataDirectory 'S1011V18_AFC_RightACL0_2410291029.mat'] ...
                 [dataDirectory 'S1011V18_AFC_RightACL0_2411050914.mat'] ...
                 }; 
elseif subj==2
    % filenames = {
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101420.mat'] ...
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101425.mat'] ...
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101428.mat'] ...
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101432.mat'] ...
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101435.mat'] ... 
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101439.mat'] ... 
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101443.mat'] ...
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101446.mat'] ... 
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101449.mat'] ...
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101453.mat'] ... 
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101515.mat'] ... 
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101519.mat'] ... 
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101524.mat'] ... 
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101528.mat'] ... 
    %              [dataDirectory 'S1002V7_AFC_RightACL0_2406101535.mat'] ...
    %              };    
    filenames = {[dataDirectory 'S1012V10_AFC_RightACL0_2408231042.mat'] ...
                 [dataDirectory 'S1012V10_AFC_RightACL0_2408231049.mat'] ... 
                 [dataDirectory 'S1012V10_AFC_RightACL0_2408231054.mat'] ... 
                 [dataDirectory 'S1012V10_AFC_RightACL0_2408231100.mat'] ...
                 [dataDirectory 'S1012V10_AFC_RightACL0_2408231107.mat'] ... 
                 [dataDirectory 'S1012V10_AFC_RightACL0_2408231112.mat'] ...
                 [dataDirectory 'S1012V10_AFC_RightACL0_2408231118.mat'] ... 
                 [dataDirectory 'S1012V10_AFC_RightACL0_2408231124.mat'] ... 
                 [dataDirectory 'S1012V10_AFC_RightACL0_2408231132.mat'] ... 
                 [dataDirectory 'S1012V10_AFC_RightACL0_2408231137.mat'] ... 
                 [dataDirectory 'S1012V10_AFC_RightACL0_2408231151.mat'] ... 
                 [dataDirectory 'S1012V10_AFC_RightACL0_2408231142.mat'] ...
                 };    
elseif subj==3
    % filenames = {
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261612.mat'] ...
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261619.mat'] ...
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261627.mat'] ...
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261633.mat'] ...
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261640.mat'] ... 
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261646.mat'] ... 
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261652.mat'] ...
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261659.mat'] ... 
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261709.mat'] ... 
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261715.mat'] ... 
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261722.mat'] ...
    %              [dataDirectory 'S1013V11_AFC_RightACL0_2408261731.mat'] ...                  
    %              };        
    filenames = {
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409191523.mat'] ...
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409191540.mat'] ...
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409191547.mat'] ...
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409191554.mat'] ...
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409191609.mat'] ... 
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409191616.mat'] ... 
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409191631.mat'] ...
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409191640.mat'] ... 
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409191650.mat'] ...     
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409201521.mat'] ...
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409201515.mat'] ... 
                 [dataDirectory 'S1013V19_AFC_RightACL0_2409201508.mat'] ...                      
                 };            
elseif subj==10
    filenames = {
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171805.mat'] ...
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171756.mat'] ...
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171749.mat'] ...
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171741.mat'] ...
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171734.mat'] ... 
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171728.mat'] ... 
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171722.mat'] ...
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171715.mat'] ... 
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171707.mat'] ... 
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171701.mat'] ... 
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171654.mat'] ...
                 [dataDirectory 'S1020V11_AFC_RightACL0_2409171645.mat'] ...                  
                 };            
elseif subj==8
    filenames = {
                 [dataDirectory 'S1018V17_AFC_RightACL0_2409241724.mat'] ...
                 [dataDirectory 'S1018V17_AFC_RightACL0_2409241714.mat'] ...
                 [dataDirectory 'S1018V17_AFC_RightACL0_2409241707.mat'] ...
                 [dataDirectory 'S1018V17_AFC_RightACL0_2409241700.mat'] ...
                 [dataDirectory 'S1018V17_AFC_RightACL0_2409241653.mat'] ... 
                 [dataDirectory 'S1018V17_AFC_RightACL0_2409241646.mat'] ...                 
                 };                
elseif subj==16
    filenames = {
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409251353.mat'] ...
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409251346.mat'] ...
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409251339.mat'] ...
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409251331.mat'] ...
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409251322.mat'] ... 
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409251315.mat'] ...   
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409251308.mat'] ... 
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409251300.mat'] ...     
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409251253.mat'] ...     
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409251246.mat'] ...    
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409261655.mat'] ...     
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409261649.mat'] ...     
                 [dataDirectory 'S1026V9_AFC_RightACL0_2409261643.mat'] ...                     
                 }; 
elseif subj==5
    filenames = {
                 [dataDirectory 'S1015V10_AFC_RightACL0_2409261217.mat'] ...
                 [dataDirectory 'S1015V10_AFC_RightACL0_2409261208.mat'] ...
                 [dataDirectory 'S1015V10_AFC_RightACL0_2409261202.mat'] ...
                 [dataDirectory 'S1015V10_AFC_RightACL0_2409261155.mat'] ...
                 [dataDirectory 'S1015V10_AFC_RightACL0_2409261149.mat'] ... 
                 [dataDirectory 'S1015V10_AFC_RightACL0_2409261143.mat'] ...   
                 [dataDirectory 'S1015V10_AFC_RightACL0_2409261136.mat'] ... 
                 [dataDirectory 'S1015V10_AFC_RightACL0_2409261130.mat'] ...     
                 [dataDirectory 'S1015V10_AFC_RightACL0_2409261122.mat'] ...     
                 [dataDirectory 'S1015V10_AFC_RightACL0_2410031542.mat'] ... 
                 [dataDirectory 'S1015V10_AFC_RightACL0_2410031551.mat'] ...     
                 [dataDirectory 'S1015V10_AFC_RightACL0_2410031559.mat'] ...                      
                 };     
elseif subj==9
    filenames = {
                 [dataDirectory 'S1019V9_AFC_RightACL0_2409301015.mat'] ...
                 [dataDirectory 'S1019V9_AFC_RightACL0_2409301009.mat'] ...
                 [dataDirectory 'S1019V9_AFC_RightACL0_2409301002.mat'] ...
                 [dataDirectory 'S1019V9_AFC_RightACL0_2409300956.mat'] ...
                 [dataDirectory 'S1019V9_AFC_RightACL0_2409300949.mat'] ... 
                 [dataDirectory 'S1019V9_AFC_RightACL0_2409300942.mat'] ...   
                 [dataDirectory 'S1019V9_AFC_RightACL0_2409300935.mat'] ... 
                 [dataDirectory 'S1019V9_AFC_RightACL0_2409300929.mat'] ...     
                 [dataDirectory 'S1019V9_AFC_RightACL0_2409300921.mat'] ...     
                 [dataDirectory 'S1019V9_AFC_RightACL0_2410041214.mat'] ... 
                 [dataDirectory 'S1019V9_AFC_RightACL0_2410041221.mat'] ...     
                 [dataDirectory 'S1019V9_AFC_RightACL0_2410041229.mat'] ...                      
                 };         
elseif subj==17
    filenames = {
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410031133.mat'] ...
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410031126.mat'] ...
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410031110.mat'] ...
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410031102.mat'] ...
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410031049.mat'] ... 
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410031041.mat'] ...   
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410031033.mat'] ... 
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410031023.mat'] ... 
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410081020.mat'] ... 
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410081027.mat'] ... 
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410081033.mat'] ... 
                 [dataDirectory 'S1027V9_AFC_RightACL0_2410081045.mat'] ... 
                 };             
elseif subj==18
    filenames = {
                 [dataDirectory 'S1028V9_AFC_RightACL0_2411011027.mat'] ...
                 [dataDirectory 'S1028V9_AFC_RightACL0_2411011020.mat'] ...
                 [dataDirectory 'S1028V9_AFC_RightACL0_2411011011.mat'] ...
                 [dataDirectory 'S1028V9_AFC_RightACL0_2411011035.mat'] ...
                 [dataDirectory 'S1028V9_AFC_RightACL0_2411011043.mat'] ...
                 [dataDirectory 'S1028V9_AFC_RightACL0_2411011050.mat'] ...
                 [dataDirectory 'S1028V9_AFC_RightACL0_2411011107.mat'] ...
                 [dataDirectory 'S1028V9_AFC_RightACL0_2411011114.mat'] ...
                 [dataDirectory 'S1028V9_AFC_RightACL0_2411051339.mat'] ...
                 [dataDirectory 'S1028V9_AFC_RightACL0_2411051327.mat'] ...
                 [dataDirectory 'S1028V9_AFC_RightACL0_2411051313.mat'] ...
                 };                 
elseif subj==20
    filenames = {
                 [dataDirectory 'S1030V8_AFC_RightACL0_2411041452.mat'] ...
                 [dataDirectory 'S1030V8_AFC_RightACL0_2411041441.mat'] ...
                 [dataDirectory 'S1030V8_AFC_RightACL0_2411041426.mat'] ...
                 [dataDirectory 'S1030V8_AFC_RightACL0_2411041416.mat'] ...
                 [dataDirectory 'S1030V8_AFC_RightACL0_2411151008.mat'] ...
                 [dataDirectory 'S1030V8_AFC_RightACL0_2411151021.mat'] ...
                 [dataDirectory 'S1030V8_AFC_RightACL0_2411151031.mat'] ...
                 [dataDirectory 'S1030V8_AFC_RightACL0_2411151041.mat'] ...
                 [dataDirectory 'S1030V8_AFC_RightACL0_2411151052.mat'] ...
                 [dataDirectory 'S1030V8_AFC_RightACL0_2411151102.mat'] ...
                 [dataDirectory 'S1030V8_AFC_RightACL0_2411151112.mat'] ...
                 };                     
end

rgb = [];
meanFocstmOptDst = [];
focStmOptDstIncr = [];
rspAcu = [];
stimOrientation = [];
indAcuRB = [];
defocusLCAmeasuredBoots = [];

for i = 1:length(filenames)
    load(filenames{i});
    rgb = [rgb; AFCp.rgb];
    meanFocstmOptDst = [meanFocstmOptDst; AFCp.meanFocstmOptDst];
    focStmOptDstIncr = [focStmOptDstIncr; AFCp.focStmOptDstIncr];
    rspAcu = [rspAcu; AFCp.rspAcu'];
    stimOrientation = [stimOrientation; AFCp.stimOrientation];
    indAcuRB = [indAcuRB; AFCp.indAcuRGBall(1:end-1)];
end

if size(unique(rgb,'rows'),1)>1
   error('ARCacuAnalysisPilot: code does not handle multiple colors yet!');
else
   rgbUnq = unique(rgb,'rows');
   rgbUnq = [1 0 0; 0 1 0; 0 0 1];
   figPositions = [62 488 560 420; ...
                   623 488 560 420; ...
                   1111 493 560 420];
end

unqFocDst = unique(focStmOptDstIncr);
scaleFac = 0.816;
% meanFocInt = 5;
defocusLCAmeasured = [];

if bPLOT
    figure;
    set(gcf,'Position',[149 495 1277 420]);
end
for rgbAcuCnd = 1:3
    for i = 1:length(unqFocDst)
        indAnalysis = focStmOptDstIncr==unqFocDst(i) & indAcuRB==rgbAcuCnd;
    %    PC(i) = sum(rspAcu(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt)==stimOrientation(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt))./sum(focStmOptDstIncr==unqFocDst(i) & meanFocstmOptDst==meanFocInt); 
         PC(i) = sum(rspAcu(indAnalysis)==stimOrientation(indAnalysis))./sum(indAnalysis);
         PCci(:,i) = binoinv([0.16 0.84],sum(focStmOptDstIncr==unqFocDst(i)),PC(i))./sum(focStmOptDstIncr==unqFocDst(i));
    end
    
    if nBoots>0
        for j = 1:nBoots
            for i = 1:length(unqFocDst)
                indAnalysis = focStmOptDstIncr==unqFocDst(i) & indAcuRB==rgbAcuCnd;
                indBoots = randsample(find(indAnalysis),sum(indAnalysis),'true');
                PCboots(i,j) = sum(rspAcu(indBoots)==stimOrientation(indBoots))./length(indBoots);
            end
            PCfitSupportBoots = min(unqFocDst.*scaleFac):0.01:max(unqFocDst.*scaleFac);
            PCfitBoots = spline(unqFocDst.*scaleFac,PCboots(:,j),PCfitSupportBoots);
            if subj==5 && (rgbAcuCnd==2 || rgbAcuCnd==1)
                PCfitBoots(PCfitSupportBoots>0.6) = 0;
            elseif subj==5 && rgbAcuCnd==3
                PCfitBoots(PCfitSupportBoots<0.6) = 0;
            elseif subj==18 && rgbAcuCnd==2
                PCfitBoots(PCfitSupportBoots<-0.5) = 0;
            end
            [~,indLCAboots] = max(PCfitBoots);
            defocusLCAmeasuredBoots(rgbAcuCnd,j) = PCfitSupportBoots(indLCAboots);
        end
    end

    PCfitSupport = min(unqFocDst.*scaleFac):0.01:max(unqFocDst.*scaleFac);
    PCfit = spline(unqFocDst.*scaleFac,PC,PCfitSupport);
    [~,indLCA] = max(PCfit);
    defocusLCAmeasured(rgbAcuCnd) = PCfitSupport(indLCA);
    if subj==5 && rgbAcuCnd==2
        PCfit(PCfitSupport>0.6) = 0;
        [~,indLCA] = max(PCfit);
        defocusLCAmeasured(rgbAcuCnd) = PCfitSupport(indLCA);
    end
    if bPLOT
        subplot(1,3,rgbAcuCnd);
        % set(gcf,'Position',figPositions(rgbAcuCnd,:));
        hold on;
        plot(unqFocDst.*scaleFac,PC,'o','Color',rgbUnq(rgbAcuCnd,:),'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
        errorbar(unqFocDst.*scaleFac,PC,PC-PCci(1,:),PCci(2,:)-PC,'o','Color',rgbUnq(rgbAcuCnd,:),'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
        plot(PCfitSupport,PCfit,'-','Color',rgbUnq(rgbAcuCnd,:),'MarkerFaceColor','w','LineWidth',1.5,'MarkerSize',10);
        axis square;
        ylim([0.4 1]);
        if rgbAcuCnd==1
           formatFigure('Relative optical distance (D)','Proportion Correct',['Subject ' num2str(subj)]);
        else
           formatFigure('Relative optical distance (D)','Proportion Correct'); 
        end
    end
end

filePathSave = '/Users/benjaminchin/Library/CloudStorage/GoogleDrive-bechin@berkeley.edu/Shared drives/ARChroma/Meetings/meeting_Sept25/';
if bSave
   saveas(gcf,[filePathSave 'LCA/S' num2str(subj) 'LCA'],'epsc');
end

wavePlotLCA = 380:875;
wavePlotPrimaries = [616 533 468];
nRepeatFit = 100;
q1all = [];
q2all = [];
q3all = [];
errAll = [];
for i = 1:nRepeatFit
   [q1,q2,q3,err] = ARC_LCAfit(wavePlotPrimaries,-defocusLCAmeasured);
   q1all(i) = q1;
   q2all(i) = q2;
   q3all(i) = q3;
   errAll(i) = err;
   if mod(i,1000)==0
       display(['Iteration ' num2str(i)]);
   end
end
[~,indBestFit] = min(errAll);
q1best = q1all(indBestFit);
q2best = q2all(indBestFit);
q3best = q3all(indBestFit);
Dgreen = humanWaveDefocusParameterized(532,q1best,q2best,q3best);

if bPLOT
    figure; 
    hold on;
    plot(wavePlotLCA,humanWaveDefocusParameterized(wavePlotLCA,q1best,q2best,q3best),'k-','LineWidth',1); 
    plot(wavePlotPrimaries,-defocusLCAmeasured,'ko','MarkerSize',15,'MarkerFaceColor','w');
    axis square; 
    set(gca,'FontSize',15); 
    xlabel('Wavelength (\lambda)'); 
    ylabel('Relative Defocus (D)');
    xlim([400 875]);
end

if bSave
   saveas(gcf,[filePathSave 'LCA/S' num2str(subj) 'LCAfit'],'epsc');
end

end
