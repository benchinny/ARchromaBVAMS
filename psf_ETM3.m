%210707 add ANOVA to analysis
function [r00 r11 r10]=psf_ETM3(y0, y1, w2, d1);

y01=y1; y1(:,1:d1)=[];
w02=w2; w2(:,1:d1)=[];

r0=zeros(4,5); r1=r0; %output matrix 
s0=[]; s1=[]; %MAR standard deviation 
l0=[]; l1=[]; %LogMAR standard deviation
r10=[]; %MAR threshold
for k0=1:length(y0);
    r01=psfe2(y0(k0), y1(k0,:), w2(k0,:), 0, d1); r10=[r10 r01(1,4)];%210705
    if y0(k0)==0
        r0=r0+r01; s0=[s0 r01(1,4)]; l0=[l0 r01(1,5)]; 
    elseif y0(k0)==1
        r1=r1+r01; s1=[s1 r01(1,4)]; l1=[l1 r01(1,5)];
    end
end

r00=r0./sum(y0==0); r00(1,1)=0;
r00=[r00; [100 r00(1,5)-std(l0,0) r00(1,4)-std(s0,0) r00(1,4)+std(s0,0) r00(1,5)+std(l0,0)]];
r00(1,2)=numel(y01(y0==0,:)); r00(1,3)=numel(y1(y0==0,:));

r11=r1./sum(y0==1); r11(1,1)=1;
r11=[r11; [100 r11(1,5)-std(l1,0) r11(1,4)-std(s1,0) r11(1,4)+std(s1,0) r11(1,5)+std(l1,0)]];
r11(1,2)=numel(y01(y0==1,:)); r11(1,3)=numel(y1(y0==1,:));


% 
% 
% y11=y1(y0==1, :)'; y11=y11(:)';
% y10=y1(y0==0, :)'; y10=y10(:)';
% 
% w11=w2(y0==1, :)'; w11=w11(:)';
% w10=w2(y0==0, :)'; w10=w10(:)';
% 
% y22=[y11; y10];
% w22=[w11; w10];
% y00=[1 0];
% 
% 
% y22=[y10; y11];
% w22=[w10; w11];
% y00=[0 1];
% 
% 
% % [r00 r11]=psfe1(y00, y22, w22, 0, d1); %210521
% [r00 r11]=psfe2(y00, y22, w22, 0, d1); %210705
% 

r00(1,2)=numel(y01(y0==0,:));
r11(1,2)=numel(y01(y0==1,:));