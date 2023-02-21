% circshift multiple planes & downsample by a factor
function i1=cs2(i0, bxy, ms);
for k0=1:size(bxy,1) %i1=zeros([size(i0) size(bxy(1))]);
    i1(:,:,k0)=dszf(circshift(i0, bxy(k0,:)), ms);
end