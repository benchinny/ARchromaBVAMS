if kc(KbName('RightArrow')) %kc(rk)
    if s1==1
        xy(1,2)=xy(1,2)+p4; chk=0;
    elseif s1==2
        xy(2,2)=xy(2,2)+p4; chk=0;
    end
    % elseif kc(KbName('s')); % kc(sk)
    %     if s1==1;
    %     xy(2,2)=xy(2,2)+p; chk=0;
    %     elseif s1==2;
    
elseif kc(KbName('LeftArrow')) %kc(lk);
    if s1==1
        xy(1,2)=xy(1,2)-p4; chk=0;
    elseif s1==2
        xy(2,2)=xy(2,2)-p4; chk=0;
    end
    % elseif kc(KbName('a')); %kc(ak);
    %     xy(2,2)=xy(2,2)-p; chk=0;
elseif kc(KbName('UpArrow')) %kc(uk)
    if s1==1
        xy(1,1)=xy(1,1)+p4; chk=0;
    elseif s1==2
        xy(2,1)=xy(2,1)+p4; chk=0;
    end
    % elseif kc(KbName('w')); %kc(wk)
    %     xy(2,1)=xy(2,1)+p; chk=0;
elseif kc(KbName('DownArrow'))%kc(dk);
    if s1==1
        xy(1,1)=xy(1,1)-p4; chk=0;
    elseif s1==2
        xy(2,1)=xy(2,1)-p4; chk=0;
    end
    % elseif kc(KbName('z')); %kc(zk);
    %     xy(2,1)=xy(2,1)-p; chk=0
    %     elseif  kc(sp) & chk == 0;
elseif kc(KbName('space')) & chk == 0
    p5=circshift(p5,[0 1]); p4=p5(1); chk=1;
elseif kc(KbName('tab')) & chk == 0
    s0=circshift(s0,[0 1]); s1=s0(1); chk=1;
    %     elseif kc(ek) | kc(kntr); %find(KeyCode)==ek
    %elseif kc(KbName('ESCAPE')) | kc(KbName('Return')); %find(KeyCode)==ek
elseif kc(KbName('ESCAPE')) & chk == 0 %find(KeyCode)==ek
    
    ext=1; chk=1;
    %WaitSecs(1);
end


%
%
% if kc(KbName('RightArrow')); %kc(rk)
%     xy(1,2)=xy(1,2)+p; chk=0;
% elseif kc(KbName('s')); % kc(sk)
%     xy(2,2)=xy(2,2)+p; chk=0;
% elseif kc(KbName('LeftArrow')); %kc(lk);
%     xy(1,2)=xy(1,2)-p; chk=0;
% elseif kc(KbName('a')); %kc(ak);
%     xy(2,2)=xy(2,2)-p; chk=0;
% elseif kc(KbName('UpArrow')); %kc(uk)
%     xy(1,1)=xy(1,1)+p; chk=0;
% elseif kc(KbName('w')); %kc(wk)
%     xy(2,1)=xy(2,1)+p; chk=0;
% elseif kc(KbName('DownArrow'));%kc(dk);
%     xy(1,1)=xy(1,1)-p; chk=0;
% elseif kc(KbName('z')); %kc(zk);
%     xy(2,1)=xy(2,1)-p; chk=0
%     %     elseif  kc(sp) & chk == 0;
% elseif kc(KbName('space')) & chk == 0;
%     p1=circshift(p1,[0 1]); p=p1(1); chk=1;
%     %     elseif kc(ek) | kc(kntr); %find(KeyCode)==ek
% %elseif kc(KbName('ESCAPE')) | kc(KbName('Return')); %find(KeyCode)==ek
%     elseif kc(KbName('ESCAPE')); %find(KeyCode)==ek
%
%     ext=true;
% end