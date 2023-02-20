% choose window from gui to show stimuli
%[RR RG RB] =1.4010    4.1090    0.4064

%[LR LG LB]= 1.3480    3.9330    0.3604

function wn=cwin(img, ey, cf, window1, window2);
switch ey
    case 'Stereo'
        tex_1 = Screen('MakeTexture', window1, imcal(img, cf(:,1)));
        Screen('DrawTexture', window1, tex_1);
        tex_2 = Screen('MakeTexture', window2, imcal(img, cf(:,2)));
        Screen('DrawTexture', window2, tex_2);
        Screen('Flip', window1);
        Screen('Flip', window2);
        wn='B';
        Screen('Close', tex_1); Screen('Close', tex_2)
        %%
    case 'Right'
        tex_1 = Screen('MakeTexture', window1, imcal(img, cf(:,1)));
        Screen('DrawTexture', window1, tex_1);
        Screen('Flip', window1);
        wn='R';
        Screen('Close', tex_1);
    case 'Left'
        tex_2 = Screen('MakeTexture', window2, imcal(img, cf(:,2)));
        Screen('DrawTexture', window2, tex_2);
        Screen('Flip', window2);
        wn='L';
        Screen('Close', tex_2);
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