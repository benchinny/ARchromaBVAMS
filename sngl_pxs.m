% clear all
close all
clc

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
%108 pix/degree
%0.0093 visual degrees/pixel
%0.5556 arcmin/pixel
%3.333 arcsec/pixel
%display =10 degrees
%FOV=5degrees

ey='Right'; ex='LCA';


% L='E';
% Esz=22; %% size of E
%LCAim=['/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_br'];
%im_path=['texture1_nrm_br.png'; 'lprd1.png'];
% b=cellstr(["texture1_nrm_br.png", "lprd0.png", "texture2_nrm_br.png", "texture3_nrm_br.png", "texture0_nrm_br.png"]);
% b=cellstr(["texture1_nrm_br.png", "lprd0.png", "lprd_blk1.png", "lprd_blk2.png", "lprd_blk3.png", "texture0_inv_bgr.png", "texture0_inv_br.png","texture0_nrm_bgr.png","texture0_nrm_br.png"]);
b=cellstr(["lprd0.png", "lprd_blk1.png", "lprd_blk2.png", "lprd_blk3.png","lprd_blk5.png","lprd_blk6.png","lprd_blk7.png","lprd_blk10.png","pst0.png","pst1.png","rce0.png","rce1.png","thrd0.png","thrd1.png", "texture0_inv_bgr.png", "texture0_inv_br.png","texture0_nrm_bgr.png","texture0_nrm_br.png","texture1_inv_bgr.png", "texture1_inv_br.png","texture1_nrm_bgr.png","texture1_nrm_br.png","texture2_inv_bgr.png", "texture2_inv_br.png","texture2_nrm_bgr.png","texture2_nrm_br.png","texture3_inv_bgr.png", "texture3_inv_br.png","texture3_nrm_bgr.png","texture3_nrm_br.png","strs_crc21.png","strs_crc21_sd1.png","strs_crs3.png","strs_crs12.png","strs_crs24.png"]);
 
screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; cf=[1 1]; %cf=[RB./RR LB./LR];

[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
ext=false;     chk=0;
%KeyCode=zeros(256,1); KeyCode(100)=1;
% for k0=1:length(b)
while ext == false; %find(KeyCode)~=ek
    sz0=[screenYpixels,  screenXpixels]
    i0=zeros(sz0);
    i0=i0(:); i0(round(rand(10000,1).*length(i0)))=1;
    i1=reshape(i0, sz0); %imshow(i1)
    img=uint8(255.*cat(3, i1, i1, i1));
    
    %img=imread(b,'png'); %% image to show
    
    wn=cwin(img, ey, cf, window1, window2);
    
    %[keyIsDown,secs, kc] = KbCheck;
    [secs, kc, deltaSecs] = KbStrokeWait;
    if kc(ek); %find(KeyCode)==ek
        ext=true;
    end
    %KbWait; %% wait for keystroke
end

sca
