function out=dszf0(K, p);
%% FAST downsize image by a factor (mean of factor implementation)
%% resizem takes about 1 sec for a 10000 by 10000 to reduce to 1000 by 1000 too long for a 10 by 10 = 100 operations 

%% improved dsz function works for downsample/p=3
% clr
% n=2; p=7;
% i0=100.*rand(n);
% i1=usz(i0,p);
sz=size(K);
rc=sz./p; 
v=[1:p.^2]; m=reshape(v, p, p);

m0=repmat(m, [rc(1) rc(2)]);


m2=zeros(rc);
f=floor((p-1)./2);
for r=1:p
    for c=1:p
    m1=K.*(m0==m(r, c));
    %m2=resizem(m1, [n n])    
    m2=m2+resizem(circshift(m1, [p-r-f p-c-f]), [rc(1) rc(2)]);
    %m3=m3+m2;
    end
end

out=m2./(p.^2);







%%old
% rc=size(K)./ms;
% out=zeros(rc);
% for r=1:rc(1);
%     for c=1:rc(2);
%      out(r,c)= mne(K(r*ms-ms+1:r*ms, c*ms-ms+1:c*ms));         
%     end
% end
% 
% % out=uint8(out);