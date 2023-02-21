%% power to magnification for each primer/color left and right eye
function [cL cR]=p2c(p)

cL(1)=0.02.*p.^2-0.6001.*p+4.8451; %red LEFT 
cL(2)=0.0106.*p.^2-0.3164.*p+2.5622; %green LEFT 
cL(3)=0.0095.*p.^2-0.2838.*p+2.2829; %blue LEFT 

cR(1)=0.0242.*p.^2-0.6966.*p+5.3467; %red LEFT 
cR(2)=0.0128.*p.^2-0.3673.*p+2.8267; %green LEFT 
cR(3)=0.0115.*p.^2-0.3294.*p+2.52; %blue LEFT 
