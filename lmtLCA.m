%% LCA limits

% Hard-coded limits for magnification
% Hard-coded limits for magnification
%variables are coming from rndLCA.m
if powerL>powerL_max;
    powerL=powerL_max;
    if powerL>13.819067
        powerL=13.819067;
    end
elseif powerL<powerL_min;
    powerL=powerL_min;
end


if powerR>powerR_max;
    powerR=powerR_max;
elseif powerR<powerR_min;
    powerR=powerR_min;
end

if power_dispL < power_dispL_min
    power_dispL = power_dispL_min;
elseif power_dispL > power_dispL_max;
    power_dispL = power_dispL_max;
end

if power_dispR < power_dispR_min
    power_dispR = power_dispR_min;
elseif power_dispR > power_dispR_max;
    power_dispR = power_dispR_max;
end