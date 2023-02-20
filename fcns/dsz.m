function out=dsz(K, ms);

%% downsize image by a factor (mean of factor implementation)
rc=size(K)./ms;
out=zeros(rc);
for r=1:rc(1);
    for c=1:rc(2);
     out(r,c)= mne(K(r*ms-ms+1:r*ms, c*ms-ms+1:c*ms));         
    end
end

% out=uint8(out);