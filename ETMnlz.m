function ETMnlz


sn=input('Subject Number? '); sn=sn+1000;
vs=input('Visit Number? ')
ey=input('Eye? 1forRight 2forBinocular ');
load('JnJrand211130', 'TCAm')
c0=TCAm(sn-1000, vs-1);
if ey(1)==2
    load JnJ\ETMflsB.mat; c1=2;
elseif ey(1)==1
    load JnJ\ETMflsR.mat; c1=1;
end
fnm=ETMfls{sn-1000, vs}; load(fnm)


drp=5; w2=ETMp.w2; y0=ETMp.y0; 
y1=ETMp.y1; sz=size(w2)
w2(:,1:drp)=[]; y1(:,1:drp)=[];
v=[]; vL=[]; vH=[];

for k0=1:length(y0)
  d1=hst2(w2(k0,:), y1(k0,:));
  r01=psfe3(y0(k0), y1(k0,:), w2(k0,:));
  r01(1,2)=sz(2); disp(r01)
  v=[v r01(1,4)]; vL=[vL r01(3,3)]; vH=[vH r01(3,4)];
end
%plot(y0, v, '*')
errorbar(y0, v, v-vL, vH-v, '*')
xlabel('Demand')
ylabel('VA (MAR)')
title(fnm)

m=[repmat([sn-1000 vs c0 c1], [8 1]) [1:8]' y0' v' vL' vH']
a=repmat(uint32(str2num(fnm(end-9:end))), [8 1])


[etmFile,etmPath] = uigetfile('*.xlsx','' , 'G:\.shortcut-targets-by-id\17-MjlIMJ6eySxBl-1ikM1jyh1UQiX26y\code_repo\JnJ')
m0=xlsread([etmPath etmFile]); ETMflnm=['JnJ\ETMxls' fnm(end-9:end) '.xlsx'];

xlswrite(ETMflnm, m0);
xlswrite(ETMflnm, m, ['A' n2s(size(m0,1)+2) ':I' n2s(size(m0,1)+9)])
xlswrite(ETMflnm, a, ['J' n2s(size(m0,1)+2) ':J' n2s(size(m0,1)+9)])

