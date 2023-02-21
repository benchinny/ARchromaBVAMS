%% gamma correction
function [iL iR]=gc0(i0, n4)
%row1 left screen; row2 right screen
a=[58.05 174.8 17.47; 56.42 164.1 17.89];
n=[2.473 2.501 2.431; 2.458 2.611 2.482];

a0=a.*1.^n
a1=255.*((n./a).^(1./n))

if n4==1;
    a2=a0(:,1).*ones(2,3); %set equiluminance for RED-GREEN
    %cf(3,:)=0; %turn off primer 1RED 2GREEN 3BLUE
elseif n4==2;
    a2=a0(:,3).*ones(2,3); %set equiluminance  for RED-BLUE
    %cf(2,:)=0; %turn off primer 1RED 2GREEN 3BLUE
end


% %LEFT SCREEN
% l1=[58.05 174.8 17.47]; %a1 gamma coefficient
% l2=[2.473 2.501 2.431]; %n1 gamma power ones(1,3).*2.33;
% %RIGHT SCREEN
% r1=[56.42 164.1 17.89]; %a1 gamma coefficicient
% r2=[2.458 2.611 2.482]; %n1 gamma power ones(1,3).*2.33;
% 
% l3=(l1.*1.^l2); l4= 255.*((n2./a1).^(1./n1));

for k0=1:3; i3(:,:,k0)=255.*(i2(:,:,k0)./a1(k0)).^(1./n1(k0)); end ; %working
