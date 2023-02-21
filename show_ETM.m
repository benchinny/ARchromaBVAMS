cls
s=100; %upsample factor
sz=[1080 1920];    i1=embd(usz(binv(opt('E', s)), 100), ones(sz));
       cf=[0.6153 0.6153; 0.3982 0.3982; 1 1]; cg='p'; %gamma corrected/purple background
           cf=[0 0;  0.605 0.583;  0 0]; cg='g'; %green
      %cf=[0.538 0.525; 0.538 0.525; 0.538 0.525]; cg='w'; %white
        cf=[1 0;  1 0;  1 0]; %TURN ON RIGHT SCREEN
%xy=[-50 -50; 0 0; 50 50];
% xy=12.*[-1 -1; 0 0; 1 1];
xy=0.*[-1 -1; 0 0; 1 1];

n=1;
ir=cf(1,n).*circshift(i1, xy(1,:));
ig=cf(2,n).*circshift(i1, xy(2,:));
ib=cf(3,n).*circshift(i1, xy(3,:));

i11=ct8(ir, ig, ib);


imshow(i11)

%use existing series
%ETMfnm0='E_b2s5_p2_p14_o4_ms10_210320.mat'; load(ETMfnm0); e0=E10c; 

b=2; s=5; w=10;  L='E'; k1=4; 
i0=o2i(b, w, s, L, k1, [1080 1080]);
    im1=ones(sz);
sz=[1080 1920];    i1=embd(usz(binv(opt('E', 4)), 100), ones(sz));



sz=[1080 1920]; w1=13; r1=4; i1=ones(sz); ms=10;
bxz=zeros(3,4);

%  bxy=[        0         0         0         0
%     -0.9167    2.0500   -0.7856    1.3697
%     -1.2417    3.3000   -1.2141    1.4703];

%  bxy=[        0         0         0         0
%     50         50        50        50
%     100        100      100       100];

%  bxy=1.*[        0         0         0         0
%     1 1 1 1
%     2 2 2 2];

 bxy=[        -1 -1 -1 -1
     0 0 0 0
     1 1 1 1];


[j4 j3 j2 j1 j0]=d4i(bxy, ms); % system+subject TCA
[h4 h3 h2 h1 h0]=d4i(bxz, ms); % system TCA
    

     ir2= embd(circshift(e0{w1, r1, j3(1,1), j3(1,2)}    ,[j1(1,1)-j4(1,1) j1(1,2)-j4(1,2)] ),i1); %window2 LFT screen RED
     ir1= embd(circshift(e0{w1, r1, j3(1,3), j3(1,4)}    ,[j1(1,3)-j4(1,3) j1(1,4)-j4(1,4)] ),i1); %window1 RGT screen RED

     ig2= embd(circshift(e0{w1, r1, j3(2,1), j3(2,2)}    ,[j1(2,1)-j4(2,1) j1(2,2)-j4(2,2)] ),i1); %window2 LFT screen GREEN
     ig1= embd(circshift(e0{w1, r1, j3(2,3), j3(2,4)}    ,[j1(2,3)-j4(2,3) j1(2,4)-j4(2,4)] ),i1); %window1 RGT screen GREEN

     ib2= embd(circshift(e0{w1, r1, j3(3,1), j3(3,2)}    ,[j1(3,1)-j4(3,1) j1(3,2)-j4(3,2)] ),i1); %window2 LFT screen BLUE
     ib1= embd(circshift(e0{w1, r1, j3(3,3), j3(3,4)}    ,[j1(3,3)-j4(3,3) j1(3,4)-j4(3,4)] ),i1); %window1 RGT screen BLUE
     
     i31=ct8(ir1, ig1, ib1); %shift TCA right screen
     i41=ct8(ir2, ig2, ib2); %shift TCA left screen

     
      %% TCA UNcorrected 
     jr2= embd(circshift(e0{w1, r1, h3(1,1), h3(1,2)}    ,[h1(1,1)-h4(1,1) h1(1,2)-h4(1,2)] ),i1); %window2 LFT screen RED
     jr1= embd(circshift(e0{w1, r1, h3(1,3), h3(1,4)}    ,[h1(1,3)-h4(1,3) h1(1,4)-h4(1,4)] ),i1); %window1 RGT screen RED

     jg2= embd(circshift(e0{w1, r1, h3(2,1), h3(2,2)}    ,[h1(2,1)-h4(2,1) h1(2,2)-h4(2,2)] ),i1); %window2 LFT screen GREEN
     jg1= embd(circshift(e0{w1, r1, h3(2,3), h3(2,4)}    ,[h1(2,3)-h4(2,3) h1(2,4)-h4(2,4)] ),i1); %window1 RGT screen GREEN

     jb2= embd(circshift(e0{w1, r1, h3(3,1), j3(3,2)}    ,[h1(3,1)-j4(3,1) h1(3,2)-h4(3,2)] ),i1); %window2 LFT screen BLUE
     jb1= embd(circshift(e0{w1, r1, h3(3,3), j3(3,4)}    ,[h1(3,3)-j4(3,3) h1(3,4)-h4(3,4)] ),i1); %window1 RGT screen BLUE

     i30=ct8(jr1, jg1, jb1); %shift TCA right screen
     i40=ct8(jr2, jg2, jb2); %shift TCA left screen
     
     
     imshow(i31)
     
     
     