function i1=rct0(vh, sz)
% create rectangle
%input sz2 for computaional simplicity
%vh vertical horizontal half width
i0=zeros(2.*sz); i1=i0;

i1(sz(1)-vh(1)+1: sz(1)+vh(1), sz(2)-vh(2)+1: sz(2)+vh(2))=1;






