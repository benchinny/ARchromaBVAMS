%% create checkerboard pattern
function i1=chkb(rc);

%k0=1;
%n=3
%rc=n.*ones(1,2);
i1=zeros(rc);

 for k0=1:rc(1);
     p0=(1+(-1).^k0)./2;
     for k1=1:rc(2);
%       
       %i1(k0,k1)=(-1).^(k1+p0);
              p1=(-1).^(k1+p0);
              i1(k0, k1)=p1;

     end
end