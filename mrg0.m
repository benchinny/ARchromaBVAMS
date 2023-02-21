%210429 mrg & mrg0 merge top/bottom, left/right of two images

function c=mrg0(a, b, d);
%d direction 1up 2right 3down 4left

sz0=size(a); sz=sz0(1:2);
sz2=sz./2;
c=a;
if d==1 %up
    c(1:sz2(1),:,:)=a(1:sz2(1),:,:);
    c(sz2(1)+1: end,:,:)=b(sz2(1)+1:end,:,:);
    
elseif d==2; %right
    c(:,sz2(2)+1:end,:)=a(:,sz2(2)+1:end,:);
    c(:,1:sz2(2),:)=b(:,1:sz2(2),:);
    
elseif d==3 %down
     c(sz2(1)+1: end,:,:)=a(sz2(1)+1:end,:,:);
    c(1:sz2(1),:,:)=b(1:sz2(1),:,:);
   
elseif d==4; %left
    c(:,1:sz2(2),:)=a(:,1:sz2(2),:); 
    c(:,sz2(2)+1:end,:)=b(:,sz2(2)+1:end,:);
       
    
end
