function [RMSE, defocus550, defocus550predTmp, rbRatio, optDistUnq] = ARCtestWvInFocusMeanZspatFilterFinchPlotHelper(subjNum,defocus550,rbRatio,optDistUnq,w)

wvInFocus = zeros([length(rbRatio) 1]);
for l = 1:length(rbRatio)
    wvInFocus(l,:) = ARCwvInFocusConesMeanZspatFilterFinch(subjNum,l,w);
    if wvInFocus(l,:)<400 || wvInFocus(l,:)>720
        wvInFocus(l,:) = NaN;
    end
    display(['stim ' num2str(l)]);
end 

defocus550predTmp = zeros([size(rbRatio,1) length(optDistUnq)]);
for l = 1:size(rbRatio,2)
    if subjNum==10
        defocus550predTmp(l) = optDistUnq-humanWaveDefocusS10(wvInFocus(l),550);
    end
    if subjNum==1
        defocus550predTmp(l) = optDistUnq-humanWaveDefocusS1(wvInFocus(l),550);
    end
    if subjNum==3
        defocus550predTmp(l) = optDistUnq-humanWaveDefocusS3(wvInFocus(l),550);
    end
    if subjNum==5
        defocus550predTmp(l) = optDistUnq-humanWaveDefocusS5(wvInFocus(l),550);
    end
    if subjNum==9
        defocus550predTmp(l) = optDistUnq-humanWaveDefocusS9(wvInFocus(l),550);
    end
    if subjNum==16
        defocus550predTmp(l) = optDistUnq-humanWaveDefocusS16(wvInFocus(l),550);
    end
    if subjNum==17
        defocus550predTmp(l) = optDistUnq-humanWaveDefocusS17(wvInFocus(l),550);
    end
    if subjNum==18
        defocus550predTmp(l) = optDistUnq-humanWaveDefocusS18(wvInFocus(l),550);
    end
    if subjNum==20
        defocus550predTmp(l) = optDistUnq-humanWaveDefocusS20(wvInFocus(l),550);
    end
end
RMSE = sqrt(mean((defocus550predTmp(:)-defocus550(:)).^2));

end
