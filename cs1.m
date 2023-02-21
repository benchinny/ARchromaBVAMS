% circshift multiple planes & add magnitude/amplitude
function i1=cs1(i0, bxy, a);
for k0=1:size(bxy,1) %i1=zeros([size(i0) size(bxy(1))]);
    i1(:,:,k0)=a(k0).*circshift(i0, bxy(k0,:));
end