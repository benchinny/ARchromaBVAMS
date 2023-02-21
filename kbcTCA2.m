KbName('UnifyKeyNames');
if kc(KbName('6')); %kc(rk)
    xy(1,2)=xy(1,2)+p4;
    xy(2,2)=xy(2,2)+p4;
    chk=0;
elseif kc(KbName('4')); %kc(lk);
    xy(1,2)=xy(1,2)-p4;
    xy(2,2)=xy(2,2)-p4;
    chk=0;
elseif kc(KbName('8')); %kc(uk)
    xy(1,1)=xy(1,1)+p4;
    xy(2,1)=xy(2,1)+p4;
    chk=0;
elseif kc(KbName('2'));%kc(dk);
    xy(1,1)=xy(1,1)-p4;
    xy(2,1)=xy(2,1)-p4;
    chk=0;
% elseif kc(KbName('space')) & chk == 0;
%     p5=circshift(p5,[0 1]); p4=p5(1); chk=1;
elseif kc(KbName('5')) & chk == 0;
    p5=circshift(p5,[0 1]); p4=p5(1); chk=1;
    snd(350, 0.2);
% elseif kc(KbName('0')) & chk == 0;
%     p5=circshift(p5,[0 1]); p4=p5(1); chk=1;
elseif kc(KbName('ESCAPE')) & chk == 0; %find(KeyCode)==ek
    ext=true; chk=1;
elseif kc(KbName('Return')) & chk == 0; %find(KeyCode)==ek
    ext=true; chk=1;
% else
%     disp('WRONG KEY'); snd(100, 0.25);
end