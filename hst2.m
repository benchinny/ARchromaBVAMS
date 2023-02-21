%%220102 calculate histogram for psignfit w/out drops
function data=hst2(wv, rv);
%figure; plot(wv)
bns=unique(wv); %[min(wv):max(wv)];
v0=zeros(1,length(bns));
v1=v0;
for k0=1:length(wv)
    k1=wv(k0);
    v0=v0+(k1==bns);
    v1=v1+rv(k0)*(k1==bns);
end

%figure; bar(bns, v1./v0)
data=[bns' v1' v0'];