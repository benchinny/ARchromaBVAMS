clear all
close all
clc

ms=7
%sz = [1080, 1920]./ms;
sz = [1080, 1920];
i0=usz(chkb(sz), ms);
%i00=chkb(sz); i0=i00;
%i0=aaf(i00, 10, [2 2], 0); 
i10=uint8(255.*repmat((i0==1), [1 1 3]));
i01=uint8(255.*repmat((i0==-1), [1 1 3]));
imshow(i01)






k0=1;
n=3
rc=n.*ones(1,2);
i1=zeros(rc);

 for k0=1:rc(1);
     p0=(1+(-1).^k0)./2;
     for k1=1:rc(2);
%       
       %i1(k0,k1)=(-1).^(k1+p0);
              p1=(-1).^(k1+p0);
              i1(k0, k1)=p1;

     end
end



% 
% 
% 
% global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
% addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
% %108 pix/degree
% %0.0093 visual degrees/pixel
% %0.5556 arcmin/pixel
% %3.333 arcsec/pixel
% %display =10 degrees
% %FOV=5degrees
% 
% ey='Right'; ex='LCA';
% 
% 
% % L='E';
% % Esz=22; %% size of E
% %LCAim=['/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_br'];
% %im_path=['texture1_nrm_br.png'; 'lprd1.png'];
% % b=cellstr(["texture1_nrm_br.png", "lprd0.png", "texture2_nrm_br.png", "texture3_nrm_br.png", "texture0_nrm_br.png"]);
% % b=cellstr(["texture1_nrm_br.png", "lprd0.png", "lprd_blk1.png", "lprd_blk2.png", "lprd_blk3.png", "texture0_inv_bgr.png", "texture0_inv_br.png","texture0_nrm_bgr.png","texture0_nrm_br.png"]);
% b=cellstr(["lprd0.png", "lprd_blk1.png", "lprd_blk2.png", "lprd_blk3.png","lprd_blk5.png","lprd_blk6.png","lprd_blk7.png","lprd_blk10.png","pst0.png","pst1.png","rce0.png","rce1.png","thrd0.png","thrd1.png", "texture0_inv_bgr.png", "texture0_inv_br.png","texture0_nrm_bgr.png","texture0_nrm_br.png","texture1_inv_bgr.png", "texture1_inv_br.png","texture1_nrm_bgr.png","texture1_nrm_br.png","texture2_inv_bgr.png", "texture2_inv_br.png","texture2_nrm_bgr.png","texture2_nrm_br.png","texture3_inv_bgr.png", "texture3_inv_br.png","texture3_nrm_bgr.png","texture3_nrm_br.png","strs_crc21.png","strs_crc21_sd1.png","strs_crs3.png","strs_crs12.png","strs_crs24.png"]);
%  
% screens = Screen('Screens');
% screenNumber = max(screens);
% load cal_val; cf=[1 1]; %cf=[RB./RR LB./LR];
% 
% [window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
% ext=false;     chk=0;
% %KeyCode=zeros(256,1); KeyCode(100)=1;
% % for k0=1:length(b)
% while ext == false; %find(KeyCode)~=ek
%     sz0=[screenYpixels,  screenXpixels]
%     ms=4;
%     sz0=[1080, 1920]; sz2=sz0./ms;
%     i0=zeros(sz0);
%     i1=i0;
%     for k0=1:sz2(1);
%         i1(k0.*ms,:)=255;
%     end
%     i2=i0;
%     for k1=1:sz2(2)
%         i2(:, k1.*ms)=255;
%     end
%     i1=i1+circshift(i1, [1 0]); i2=i2+circshift(i2, [0 1]);
%     i3=i1; i3(:, sz0(2)/2:end)=i2(:, sz0(2)/2:end);
%     
%     i3=uint8(255.*i3./mxa(i1));
% i2=cat(3, i3, i3, i3);
% imshow(i2);
%     
%     
%     
%     
%     
% for k0=1:screenYpixels;
%     p0=1+(-1).^k0;
%     for k1=1:screenXpixels;
%       
%       i1(k0,k1)=1+(-1).^(k1+p0);           
%     end
% end
% i1=uint8(255.*i1./mxa(i1));
% i2=cat(3, i1, i1, i1);
% imshow(i2);
% 
%     img=uint8(255.*cat(3, i1, i1, i1));
%     
%     %img=imread(b,'png'); %% image to show
%     
%     wn=cwin(img, ey, cf, window1, window2);
%     
%     %[keyIsDown,secs, kc] = KbCheck;
%     [secs, kc, deltaSecs] = KbStrokeWait;
%     if kc(ek); %find(KeyCode)==ek
%         ext=true;
%     end
%     %KbWait; %% wait for keystroke
% end
% 
% sca
