function i1=strk(i0, v1)
if rem(v1, 1)~=0
    v2=round(5*v1);    
    i1=udsz(i0, v2, 5); % up down sample    
else   
    i1=usz(i0, v1); %upsample   
end