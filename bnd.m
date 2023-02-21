% bound a variable x between limits

function y=bnd(x, lw, hg);

if x<lw;
    
   y=lw;
elseif x > hg
    y=hg;
else
    
   y=x;
   
end
   
