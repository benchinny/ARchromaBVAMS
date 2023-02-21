% circshift multiple planes
function i1=cs0(i0, bxy);
for k0=1:size(bxy,1) %i1=zeros([size(i0) size(bxy(1))]);
    i1(:,:,k0)=circshift(i0, bxy(k0,:));
end