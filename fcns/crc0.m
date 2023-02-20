function i2=crc0(rd, sz);
%% works great for even number of rows/col screen. need to fix for odd numbers
% rd=108;
% sz = [1080, 1920]; % size of screen

sz2=sz./2; 
if rem(sz2(1), 1)==0; sz2(1)=sz2(1)+0.5; end
if rem(sz2(2), 1)==0; sz2(2)=sz2(2)+0.5; end
[r, c] = meshgrid([1:sz(2)], [1:sz(1)]);
i0=zeros(sz);
i1=sqrt((r-sz2(2)).^2 +(c-sz2(1)).^2);
i2=(i1<=rd);
%imshow(i2);