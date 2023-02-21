%power to magnification Left trombone

function m=p2mL(p);


m=(p./11.32).^(-1./1.039);
%opto_powerL=11.32.*((magL).^(-1.039));
%opto_powerR=@(magR) 11.002.*((magR)^(-0.958));