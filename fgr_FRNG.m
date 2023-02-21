%210709 FRNG after correcting TCA0

%NHI
load S10007Right_FRNGE_ACL0_2107081346
for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
load S10007Right_FRNGE_ACL1_2107081545
for k0=1:4; A1(k0)=sum(n0(n1==k0)); end 


load S10003Right_FRNGE_ACL0_2107091126
for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
load S10003Right_FRNGE_ACL1_2107091204
for k0=1:4; A1(k0)=sum(n0(n1==k0)); end 


load S10003Right_FRNGE_ACL0_2107131612
for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
load S10003Right_FRNGE_ACL1_2107131547
for k0=1:4; A1(k0)=sum(n0(n1==k0)); end


load S10004Left_FRNGE_ACL1_2107141007
for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
load S10004Left_FRNGE_ACL1_2107141029
for k0=1:4; A1(k0)=sum(n0(n1==k0)); end


load S10004Left_FRNGE_ACL0_2107141254
for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
load S10004Left_FRNGE_ACL1_2107141029
for k0=1:4; A1(k0)=sum(n0(n1==k0)); end



load S10004Left_FRNGE_ACL0_2107141327
for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
load S10004Left_FRNGE_ACL1_2107141405
for k0=1:4; A1(k0)=sum(n0(n1==k0)); end

load S10003Right_FRNGE_ACL0_2107141531
for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
load S10003Right_FRNGE_ACL1_2107141559
for k0=1:4; A1(k0)=sum(n0(n1==k0)); end

load S10007Right_FRNGE_ACL0_2107151638
for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
load S10007Right_FRNGE_ACL1_2107151547
for k0=1:4; A1(k0)=sum(n0(n1==k0)); end


load S10007Right_FRNGE_ACL0_2107211252
for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
load S10007Right_FRNGE_ACL1_2107211443
for k0=1:4; A1(k0)=sum(n0(n1==k0)); end


load S10003Right_FRNGE_ACL0_2107211614
for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
load S10003Right_FRNGE_ACL1_2107211544
for k0=1:4; A1(k0)=sum(n0(n1==k0)); end


%for k0=1:8; n1(k0)=sum(n0(m0==k0)); n2(k0)=sum(m0==k0);  end; [1:8; n1; n2]
direction={'UP', 'RIGHT', 'DOWN', 'LEFT'}
ACL={0, 1}
T = table([0; 1],[A0(1);A1(1)], ...
          [A0(2);A1(2)],[A0(3);A1(3)],[A0(4);A1(4)], 100.*[sum(A0); sum(A1)]./20)

T.Properties.VariableNames = {'A','U','R','D','L', 'P'} 
% 
% %JOL ACL0
% load('S10005Right_FRNG_ACL1_2106081520.mat')
% %new optotype
% S10003Right_FRNGE_ACL1_2106251346
% 
% 
% %AJR ACL0
% S10003Right_FRNG_ACL0_2106111439
% S10003Right_FRNG_ACL0_2106111615
% load S10003Right_FRNGE_ACL0_2106251454 % 2 Es side by side
% 
% %AJR ACL1
% S10003Right_FRNG_ACL1_2106111510
% load S10003Right_FRNG_ACL1_2106111641
% load S10003Right_FRNGE_ACL1_2106251346 % 2 Es side by side
% 
% %MSB ACL0
% S10004Left_FRNG_ACL0_2106101315
% S10004Left_FRNGE_ACL0_2106301056 %correct
% %MSB ACL1
% load S10004Left_FRNGE_ACL1_2106211641 %new E URDL paradigm
% load S10004Left_FRNGE_ACL1_2106241516
% 
% 
% load S10004Left_FRNGE_ACL0_2106301056
% for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
% load S10004Left_FRNGE_ACL1_2106301420
% for k0=1:4; A1(k0)=sum(n0(n1==k0)); end 
% 
% 
% 
% load S10007Right_FRNGE_ACL0_2107081346
% for k0=1:4; A0(k0)=sum(n0(n1==k0)); end
% load S10007Right_FRNGE_ACL1_2107081545
% for k0=1:4; A1(k0)=sum(n0(n1==k0)); end 
% 
% %for k0=1:8; n1(k0)=sum(n0(m0==k0)); n2(k0)=sum(m0==k0);  end; [1:8; n1; n2]
% direction={'UP', 'RIGHT', 'DOWN', 'LEFT'}
% ACL={0, 1}
% T = table([0; 1],[A0(1);A1(1)], ...
%           [A0(2);A1(2)],[A0(3);A1(3)],[A0(4);A1(4)], 100.*[sum(A0); sum(A1)]./20)
% 
% T.Properties.VariableNames = {'A','U','R','D','L', 'P'}