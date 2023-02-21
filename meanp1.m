function p2=meanp1(p1)
for k0=1:3
           p2(k0,:)=mean(p1(p1(:,6)==k0,:),1) 
end