function im_out=imf(im)
%% show scaled image
global sz rot ump

figure; 
if size(im,2)==1
    im_out=rot90(reshape(im, sz(1), sz(2)),rot);
imagesc(ump.*[0:sz(2)-1]./1000, ump.*[0:sz(1)-1]./1000, im_out); 
else
    im_out=rot90(im ,rot);
imagesc(ump.*[0:sz(2)-1]./1000, ump.*[0:sz(1)-1]./1000, im_out); 
end
