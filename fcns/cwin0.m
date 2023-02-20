% choose window from gui to show stimuli
%[RR RG RB] =1.4010    4.1090    0.4064

%[LR LG LB]= 1.3480    3.9330    0.3604

function wn=cwin0(img, ey, cf, rc, window1, window2);
switch ey
    case 'Stereo'

        tex_1 = Screen('MakeTexture', window1, imcal(circshift(img, rc(1,:)), cf(:,1)));
        Screen('DrawTexture', window1, tex_1);
        tex_2 = Screen('MakeTexture', window2, imcal(circshift(img, rc(2,:)), cf(:,2)));
        Screen('DrawTexture', window2, tex_2);
        Screen('Flip', window1);
        Screen('Flip', window2);
        wn='B';
        %%
    case 'Right'
        tex_1 = Screen('MakeTexture', window1, imcal(circshift(img, rc(1,:)), cf(:,1)));
        Screen('DrawTexture', window1, tex_1);
        Screen('Flip', window1);
        wn='R';
    case 'Left'
        tex_2 = Screen('MakeTexture', window2, imcal(circshift(img, rc(2,:)), cf(:,2)));
        Screen('DrawTexture', window2, tex_2);
        Screen('Flip', window2);
        wn='L';
%     case 'Random'
%         if rand<0.5
%             window =window1; wn='R'; cf0=cf(1);
%         else
%             window=window2; wn='L', cf0=cf(2);
%         end
%         tex = Screen('MakeTexture', window, imcal(img, cf0));
%         Screen('DrawTexture', window, tex);
%         Screen('Flip', window);       
end