%upsize an image/matrix

function i1=usz(i0, ms);

% B=uint8(ones(ms));
 B=ones(ms);
%B=ones(gpuArray(ms));
 i1=kron(i0,B);
%i1=kron(gpuArray(B),i0);