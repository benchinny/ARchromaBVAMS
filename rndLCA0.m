
%use inital conditions or randomize trombone/optotune settings

if power_dispL0==0
    power_dispL=(power_dispL_max-power_dispL_min).*rand+power_dispL_min;
else
    power_dispL=power_dispL0;
end

if power_dispR0==0
    power_dispR=(power_dispR_max-power_dispR_min).*rand+power_dispR_min;
else
    power_dispR=power_dispR0;
end

if powerL0==0
    powerL=(powerL_max-powerL_min).*rand+powerL_min;
elseif powerL0>13.819067
    powerL0=13.819067;
else
    powerL=powerL0;
end

if powerR0==0
    powerR=(powerR_max-powerR_min).*rand+powerR_min;
else
    powerR=powerR0;
end


