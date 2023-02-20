%embed a in b (center)
function c=embd(a,b)

% a=i1;
% sz = [1080, 1920]; % size of screen
% b=ones(sz);
sz=size(b);
w=size(a, 1);
d=floor(w/2); 
dv=[-d+(rem(w,2)==0):d];
b(round(sz(1)/2)+dv, round(sz(2)/2)+dv)=a;
c=b;
% imshow(b)