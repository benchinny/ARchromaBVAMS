%%

wave = round(Finchetalprimaries.VarName1,1);

power = round(Finchetalprimaries.VarName2,3);

waveBlueP = wave(1:122);
waveRedP = wave(123:end);
powerBlueP = power(1:122);
powerRedP = power(123:end);

%%

waveBluePunq = unique(waveBlueP);
waveRedPunq = unique(waveRedP(1:end-1));
powerBluePunq = [];
powerRedPunq = [];

for i = 1:length(waveBluePunq)
    ind = waveBlueP==waveBluePunq(i);
    powerBluePunq(i) = mean(powerBlueP(ind));
end

for i = 1:length(waveRedPunq)
    ind = waveRedP==waveRedPunq(i);
    powerRedPunq(i) = mean(powerRedP(ind));
end

waveBluePunq = waveBluePunq';
waveRedPunq = waveRedPunq';

waveBluePunq = [380 waveBluePunq 780];
waveRedPunq = [380 waveRedPunq 780];
powerBluePunq = [0 powerBluePunq 0];
powerRedPunq = [0 powerRedPunq 0];
wave = 380:4:780;
d = struct;
d.wave = wave;
d.spd(:,1) = interp1(waveRedPunq,powerRedPunq,wave,'linear');
d.spd(:,3) = interp1(waveBluePunq,powerBluePunq,wave,'linear');
d.spd(:,2) = zeros(size(wave));
