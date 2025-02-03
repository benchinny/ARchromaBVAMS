function RMSE = ARCtestWvInFocusMeanZspatFilterObjFunc(subjNum,defocus875,rgbAll,optDistAll,w)

rgbUnq = unique(rgbAll,'rows');
defocus875predTmp = zeros([length(optDistAll) 1]);
wvInFocus = zeros([size(rgbUnq,1) 1]);
for l = 1:size(rgbUnq,1)
    wvInFocus(l,:) = ARCwvInFocusConesMeanZspatFilter(subjNum,l,w);
    % display(['wL = ' num2str(wL) ' wM = ' num2str(wM) ' wS = ' num2str(wS) ' stim ' num2str(l)]);
end 
wvInFocusAll = zeros([length(optDistAll) 1]);
for l = 1:size(rgbUnq,1)
    indStiml = abs(rgbAll(:,1)-rgbUnq(l,1))<0.001 & ...
    abs(rgbAll(:,2)-rgbUnq(l,2))<0.001 & ...
    abs(rgbAll(:,3)-rgbUnq(l,3))<0.001;
    if subjNum==10
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS10(wvInFocus(l),875);
    end
    if subjNum==1
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS1(wvInFocus(l),875);
    end
    if subjNum==3
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS3(wvInFocus(l),875);
    end
    if subjNum==5
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS5(wvInFocus(l),875);
    end                
    if subjNum==9
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS9(wvInFocus(l),875);
    end
    if subjNum==16
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS16(wvInFocus(l),875);
    end
    if subjNum==17
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS17(wvInFocus(l),875);
    end
    if subjNum==18
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS18(wvInFocus(l),875);
    end                
    if subjNum==20
        defocus875predTmp(indStiml) = optDistAll(indStiml)-humanWaveDefocusS20(wvInFocus(l),875);
    end
    wvInFocusAll(indStiml) = wvInFocus(l);
end

RMSE = sqrt(mean((defocus875predTmp(:)-defocus875(:)).^2));

end
