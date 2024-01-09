function smpPerUnit = smpPos2smpPerUnit(posSmps)
% function [smpPerUnit] = smpPos2smpPerUnit(posSmps)
%
% Determine sampling rate from positional samples
%
% Example call : bStartAtZero = 1; smpPerUnit =  smpPos2smpPerUnit(smpPos(12,27,bStartAtZero));
%
% posSmps    : position samples assumed to be generated by smpPos.m
% smpPerUnit : number of samples per unit

% THROW ERROR IF SAMPLES ARE NONUNIFORMLY SPACED
tol = 0.0001;
if length(unique(roundDec(diff(posSmps),tol))) > 1
    error('smpPos2smpPerUnit.m : ERROR! Code requires uniformly spaced samples as input');
end

%IF POSITIONS START AT ZERO, THEN CENTER
if posSmps(1) == 0 
    ctrInd  = floor(length(posSmps)/2 + 1);
    posSmps = posSmps - posSmps(ctrInd);
end

% FOR CENTERED POSITIONS...
if mod(length(posSmps),2) == 0 % Even number of samples

    smpPerUnit = -0.5*max(length(posSmps))./min(posSmps);

elseif mod(length(posSmps),2) == 1 % Odd number of samples

    smpPerUnit =  0.5*(length(posSmps)-1)./max(posSmps);

end