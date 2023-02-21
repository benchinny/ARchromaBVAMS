

 p1= [11.3000000000000,11.3000000000000,13.8190670000000,13.6242132615729,-3,2;11.2000000000000,11.2000000000000,13.8190670000000,13.6242132615729,-3,2;10.7000000000000,10.7000000000000,13.8190670000000,13.6242132615729,-3,3;11.8000000000000,11.8000000000000,13.8190670000000,13.6242132615729,-3,1;11.9000000000000,11.9000000000000,13.8190670000000,13.6242132615729,-3,1;10.8000000000000,10.8000000000000,13.8190670000000,13.6242132615729,-3,3];
   
for k0=1:3
        p2(k0,:)=mean(p1(p1(:,6)==k0,:),1);
        p3(k0,:)=std(p1(p1(:,6)==k0,:), 0, 1);%CAUTION:also p3 is being used further!!!
end
 fprintf('Mean focus for R,G,B');p2
 fprintf('Std Dev for focus for R,G,B');p3
 fprintf('System+Eye LCA');
 %Compute the LCA of the system+eye between the primaries using the defocus
    %measurments for the subject (when there is NO ACL)
    p4(1,:)=(p2(1,:)-p2(3,:)); % red-blue
    p4(2,:)=p2(2,:)-p2(3,:); % green-red
    p4(3,:)=p2(1,:)-p2(2,:) % red-green
    
    %Compute the LCA of the system with no ACL in place
    %note: important to use m=1 during subject's defocus adjustment
    %We will use same value of mag to compute system LCA
    p0(5)=1;
    fprintf('Eye LCA');
    %Compute the LCA of the eye by subtracting LCA of the systen
    p5(1,:)=p4(1,:)-(0.2174.*p0(5)+0.0818);
    p5(2,:)=p4(2,:)-(0.1231.*p0(5)+0.0297);
    p5(3,:)=p4(3,:)-(0.0943.*p0(5)+0.0521)
    fprintf('Trombone powers');
     p6(:,1)=([9.2813 7.1652 6.8831].*(p5(:,1)').^[-0.403 -0.414 -0.39])'; %left side
    p6(:,2)=([9.1613 7.2167 6.9543].*(p5(:,2)').^[-0.371 -0.382 -0.36])'%Right side
    
powerL_max=13.819067;   powerR_max=opR(0.8);
powerL_min=opL(1.3);   powerR_min=opR(1.3);
  fprintf('Mean Trombone powers');
p7=mean(p6,1)
% p7(1)=4;
%constrain trombone power
    p8(1)=bnd(p7(1), powerL_min, powerL_max)
%     p8(2)=bnd(p7(2), powerR_min, powerR_max);
    