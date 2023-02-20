function If=imgaussflt(I, sig, sz, p)

hg=normpdf([1:sz(2)], round(sz(2)./2), sig); hf=repmat(fft(hg), [sz(1) 1]);
vg=normpdf([1:sz(1)], round(sz(1)./2), sig); vf=repmat(fft(vg)', [1 sz(2)]);

If=ifftshift(ifft2(fft2(I).*hf.*vf));
if nargin==4; If(If<=mxa(If)./p)=0; end; %% p= percent cut off



% 
% 
% 
% sz0=size(I);
% I1=ones(sz0); I45=imrotate(I1,-45); I0=imrotate(I45,45); [r1,c1] = find(I0>0); 
% r0=min(r1)+[1:sz0(1)]-1; c0=min(c1)+[1:sz0(2)]-1;
% %[prod(sz0) length(r1)]
% 
% A45=imrotate(I,-45); A1=imgaussfilt(A45, sig); A0=imrotate(A1, 45); %imshow(A1);
% A=A0(r0,c0); %figure; imshow(A) figure; imshow(I)
