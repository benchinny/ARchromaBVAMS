data=xlsread('acuity_AR_Oct132020.xlsx','Sheet2');
%DATA with ACL
mag=data(:,1)
flag=data(:,3)
score=data(:,5)

plot(mag(1:6),score(1:6),'ro','MarkerFaceColor','r');hold on;
plot(mag(7:12),score(7:12),'go','MarkerFaceColor','g'); 
plot(mag(13:end),score(13:end),'bo','MarkerFaceColor','b');


%DATA withOUT ACL
score_wo=data(:,6);
plot(mag(3:4),score_wo(3:4),'ro');
plot(mag(9:10),score_wo(9:10),'go'); 
plot(mag(15:16),score_wo(15:16),'bo');
xlim([ 0.5 1.5])
xlabel('Trombone magnification');
ylabel('Score');

 legend('With ACL- Red','With ACL- Green','With ACL- Blue','W/o ACL- Red','W/o ACL- Green','W/o ACL- Blue');


