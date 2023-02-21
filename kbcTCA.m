
if kc(KbName('RightArrow')); %kc(rk)
    xy(1,2)=xy(1,2)+p; chk=0;
elseif kc(KbName('s')); % kc(sk)
    xy(2,2)=xy(2,2)+p; chk=0;
elseif kc(KbName('LeftArrow')); %kc(lk);
    xy(1,2)=xy(1,2)-p; chk=0;
elseif kc(KbName('a')); %kc(ak);
    xy(2,2)=xy(2,2)-p; chk=0;
elseif kc(KbName('UpArrow')); %kc(uk)
    xy(1,1)=xy(1,1)+p; chk=0;
elseif kc(KbName('w')); %kc(wk)
    xy(2,1)=xy(2,1)+p; chk=0;
elseif kc(KbName('DownArrow'));%kc(dk);
    xy(1,1)=xy(1,1)-p; chk=0;
elseif kc(KbName('z')); %kc(zk);
    xy(2,1)=xy(2,1)-p; chk=0
    %     elseif  kc(sp) & chk == 0;
elseif kc(KbName('space')) & chk == 0;
    ppp=circshift(ppp,[0 1]); p=ppp(1); chk=1;
    %     elseif kc(ek) | kc(kntr); %find(KeyCode)==ek
%elseif kc(KbName('ESCAPE')) | kc(KbName('Return')); %find(KeyCode)==ek
    elseif kc(KbName('ESCAPE')); %find(KeyCode)==ek

    ext=true;
end