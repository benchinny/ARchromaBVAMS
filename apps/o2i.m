%optotype to image
function img=o2i(b, w, bw, L, p, sz);
global ek uk dk lk rk st
if p==0; st=rk; elseif p==1; st=dk; elseif p==2; st=lk; elseif p==3; st=uk; end 
    %im0=sqrs(b, w, L, p); % square steps
    
    
    im0=sqrs0(b, w, bw, L, p); % square steps
    im1=ones(sz);
    img=embd(im0, im1);
    %img=uint8(im3*255);