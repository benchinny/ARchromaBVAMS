clear all
close all
clc

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
%108 pix/degree
%display =10 degrees
%FOV=5degrees

ey='Right'; ex='LCA';


% L='E';
% Esz=22; %% size of E
%LCAim=['/Users/nadavivzan/Dropbox/Berkeley/code_repo/exp_bvams/textures/split/texture0_nrm_br'];
%im_path=['texture1_nrm_br.png'; 'lprd1.png'];
% b=cellstr(["texture1_nrm_br.png", "lprd0.png", "lprd_blk1.png", "lprd_blk2.png", "lprd_blk3.png"]);

b=cellstr(["lprd0.png", "lprd_blk1.png", "lprd_blk2.png", "lprd_blk3.png","lprd_blk5.png","lprd_blk6.png","lprd_blk7.png","lprd_blk10.png","pst0.png","pst1.png","rce0.png","rce1.png","thrd0.png","thrd1.png", "texture0_inv_bgr.png", "texture0_inv_br.png","texture0_nrm_bgr.png","texture0_nrm_br.png","texture1_inv_bgr.png", "texture1_inv_br.png","texture1_nrm_bgr.png","texture1_nrm_br.png","texture2_inv_bgr.png", "texture2_inv_br.png","texture2_nrm_bgr.png","texture2_nrm_br.png","texture3_inv_bgr.png", "texture3_inv_br.png","texture3_nrm_bgr.png","texture3_nrm_br.png","strs_crc21.png","strs_crc21_sd1.png","strs_crs3.png","strs_crs12.png","strs_crs24.png"]);
 
%  LCAim='lprd0'; %1 
%  LCAim='lprd_blk1';%2
%  LCAim='lprd_blk2'; %3
%  LCAim='lprd_blk3' %4
%  LCAim='lprd_blk5' %5
%  LCAim='lprd_blk6' %6
%  LCAim='lprd_blk7' %7
%  LCAim='lprd_blk10' %8

%  LCAim='pst0' %9
%  LCAim='pst1' %10
%  LCAim='rce0' %11
%  LCAim='rce1' %12
%  LCAim='thrd0' %13
%  LCAim='thrd1' %14

%  LCAim='texture0_inv_bgr.png'; %15 black background, with blue red texture on top, green-black maltese cross in between
%  LCAim='texture0_inv_br.png';  %16 black background, with blue red texture on top, blue-red maltese cross
%  LCAim='texture0_nrm_bgr.png'; %17 blue-red background, with black texture on top,green in middle
%  LCAim='texture0_nrm_br.png';   %18 blue-red background, with black texture on top

% LCAim='texture1_inv_bgr';  %19 black background 
% LCAim='texture1_inv_br';  %20 black background
% LCAim='texture1_nrm_bgr';  %21  blue-red background
% LCAim='texture1_nrm_br';   %22 blue-red background
% 
% LCAim='texture2_inv_rgb'; %23 black background
% LCAim='texture2_inv_rb';  %24 black background
% LCAim='texture2_nrm_rgb';  %25 red-blue background
% LCAim='texture2_nrm_rb';   %26 red-blue background
% 
% LCAim='texture3_inv_rgb'; %27 black background
% LCAim='texture3_inv_rb';  %28 black background %28
% LCAim='texture3_nrm_rgb'; %29 red-blue background
% LCAim='texture3_nrm_rb';  % 30 red-blue background
% 


screens = Screen('Screens');
screenNumber = max(screens);
load cal_val; cf=[RB./RR LB./LR];

[window1, window2, vbl0]=strt_psych(screenNumber-1, screenNumber, ex);
ext=false;
%KeyCode=zeros(256,1); KeyCode(100)=1;
% for k0=1:length(b)
while ext == false; %find(KeyCode)~=ek
    disp(b{1});
    img=imread(b{1},'png'); %% image to show
    
    wn=cwin(img, ey, cf, window1, window2);
    
    %[keyIsDown,secs, kc] = KbCheck;
    [secs, kc, deltaSecs] = KbStrokeWait;
    
    if kc(rk)
        b=circshift(b,[0 1]);
    elseif kc(lk);  %find(KeyCode)==lk
        b=circshift(b,[0 -1]);
    elseif kc(ek); %find(KeyCode)==ek
        ext=true;
    end
     KbWait([],2); %% wait for keystroke
    %KbWait; %% wait for keystroke
end

sca
