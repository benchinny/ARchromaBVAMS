%210505 export data to JJVC

if exist('E10c')==0 | isempty(E10c)==1; ETMfnm0='E_b2s5_p2_p14_o4_ms10_210320.mat'; load(ETMfnm0);  end %E optotype base 3 17secs to load



c0=0.00384; %deg/pixels
c1=1./(c0.*60);
s0=20.*STK./c1;

%y0=zeros(size(y0)); %only for green

clear y1_n w2_n dn
d0=zeros(13,3);
n=0; %tca0 vs tca1
y1_n=y1(y0==n,:);
w2_n=w2(y0==n,:);
dn=hst0(w2_n,y1_n, 0);
dn=[dn(:,1) dn]; dn(:,2)=s0(dn(:,1));
d0=flipud(dn)


clear y1_n w2_n dn
n=1; %tca0 vs tca1
y1_n=y1(y0==n,:);
w2_n=w2(y0==n,:);
dn=hst0(w2_n,y1_n, 0);
dn=[dn(:,1) dn]; dn(:,2)=s0(dn(:,1));
d1=flipud(dn)





%
[r00 r11]=psfa(y0, y1, w2, 5, STK);




MSB210505_ACL1_TCA0_white=d1
MSB210505_ACL1_TCA1_white=d1
MSB210505_ACL1_TCA1_prpl=d1
MSB210505_ACL1_TCA0_prpl=d0
MSB210505_ACL1_grn=d0
MSB210505_ACL0_grn=d0
MSB210505_ACL0_TCA1_prpl=d1
MSB210505_ACL0_TCA0_prpl=d0
MSB210505_ACL0_TCA1_white=d1
MSB210505_ACL0_TCA0_white=d0
AJR210430_ACL1_grn=d0
AJR210430_ACL0_grn=d0
AJR210430_ACL0_TCA1_prpl=d1
AJR210430_ACL0_TCA0_prpl=d0
AJR210430_ACL1_TCA1_prpl=d1
AJR210430_ACL1_TCA0_prpl=d0
AJR210430_ACL0_TCA1_white=d1
AJR210430_ACL0_TCA0_white=d0
AJR210430_ACL1_TCA1_white=d1
AJR210430_ACL1_TCA0_white=d0
MSB210504_ACL1_grn=d0
MSB210504_ACL1_TCA1_prpl=d1
MSB210504_ACL1_TCA0_prpl=d0
MSB210504_ACL1_TCA1_white=d1
MSB210504_ACL1_TCA0_white=d0
MSB210414_ACL1_grn=d0
MSB210414_ACL1_TCA1_prpl=d1
MSB210414_ACL1_TCA0_prpl=d0
MSB210414_ACL1_TCA1_white=d1
MSB210414_ACL1_TCA0_white=d0
MSB_ACL1_grn=d0
MSB_ACL1_TCA1_prpl=d1
MSB_ACL1_TCA0_prpl=d0
MSB_ACL1_TCA1_white=d1
MSB_ACL1_TCA0_white=d0



%y0=zeros(size(y0)); %only for green

y00=y0;
y11=y1;
w22=w2;


y00=[y00 y0];
y11=[y11; y1];
w22=[w22; w2];

y0=y00;
y1=y11;
w2=w22;

clear w22 y11 y00


w1a1s=[]; %white tca1 acl1 stimulus 
w1a1r=[]; %white tca1 acl1 stimulus 

w1a0s=[]; %white tca1 acl0 stimulus  
w1a0r=[]; %white tca1 acl0 respnse

w0a1=[]; 
w0a0=[]; 
g1a1=[]; 
g1a0=[]; 
g0a1=[]; 
g0a0=[]; 
p1a1=[]; 
p1a0=[]; 
p0a1=[]; 
p0a0=[]; 
d0(dn(:,1),:)=dn(dn(:,1),:);
d0(:,1)=s0(d0(:,1))




y1_1=y1(y0==1,:)
w2_1=w2(y0==1,:)
d_1=hst0(w2_1,y1_1, 0);



y1_0=y1(y0==0,:)
w2_0=w2(y0==0,:)
d_0=hst0(w2_0,y1_0, 0);



data=hst0(w2,y1, 0);



