% present 2 stimuli on 2 screens 
%[RR RG RB] =1.4010    4.1090    0.4064

%[LR LG LB]= 1.3480    3.9330    0.3604

function [i1 i2]=cwin3(img1, img2, cf, rc, window1, window2);
        i1=imcal(circshift(img1, rc(1,:)), cf(:,1));
        tex_1 = Screen('MakeTexture', window1, i1);
        Screen('DrawTexture', window1, tex_1);
        i2= imcal(circshift(img2, rc(2,:)), cf(:,2));
        tex_2 = Screen('MakeTexture', window2, i2);
        Screen('DrawTexture', window2, tex_2);
        Screen('Flip', window1);
        Screen('Flip', window2);
        Screen('Close', tex_1); Screen('Close', tex_2);


        %%
