%create crosses/dots code sparse/ randomly !
%3by3 pixel crosses
%position stimuli/stars at random spots in the image
function i2=strs(n, i1);

% k=[0 1 0 0; 1 1 1 0; 0 1 0 0; 0 0 0 0];
% sz = [1080, 1920]; % size of screen
% i0=zeros(sz);
% i1=embd(k,i0);
sz=size(i1);
rc=rand(n,2);
rc=round(sz.*rc);
i2=zeros(sz);
for k=1:n;
    i2=i2+circshift(i1, rc(k,:));
end
    
 
 %imshow(i2)
