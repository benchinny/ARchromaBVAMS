%% merge two matricx halfs into one

function [c1 c0]=mrg(a, b, d);
%d direction 1up 2right 3down 4left

sz0=size(a); sz=sz0(1:2);
sz2=sz./2;
c1=a; c0=c1;
if d==1 %up/down
    c1(1:sz2(1),:,:)=a(1:sz2(1),:,:);
    c1(sz2(1)+1: end,:,:)=b(sz2(1)+1:end,:,:);
    c0=flipud(c1);
elseif d==2; %left/right
    c1(:,1:sz2(2),:)=a(:,1:sz2(2),:);
    c1(:,sz2(2)+1:end,:)=b(:,sz2(2)+1:end,:);
    c0=fliplr(c1);
end