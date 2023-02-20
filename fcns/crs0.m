function i2=crs0(i1, cw);
% generate black cross in the middle of a figure
% case for even number of pixels screen
sz=size(i1);

sz2=sz./2; l=sz2-cw./2; u=sz2+cw./2;

i2=i1;

i2(l(1)+1:u(1),:)=0; i2(:,l(2)+1:u(2))=0; %for even number of pixels
%i2(l(1):u(1),:)=0; i2(:,l(2):u(2))=0; %for uneven number of pixels
