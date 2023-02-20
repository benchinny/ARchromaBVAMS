%% improved tumbling E function generator
function img=Eti(c, w, sz, L)
global ek uk dk lk rk st
%Lef<0.25 Left, Right <0.5, 0.5<D, 0.75<U  
% Clear the workspace and the screen
%close all;
%clearvars;
%sca
%sz = [1080, 1920];
%c=0.6
%w=11; space between black and white
d=floor(5*w/2); %% size of E = d*2 = 5*w
img=zeros(sz);
% E=[1 1 1 1 1; 1 0 0 0 0; 1 1 1 1 1; 1 0 0 0 0; 1 1 1 1 1];
E=optps(L);
B=ones(w);
K=kron(E,B);
%dv=[-d+1:d]

if c<0.5; st=rk; % vertical E R
    if c<0.25; K=fliplr(K); st=lk; end %   
elseif c>= 0.5; %Horizontal E
    K=K'; st=uk; % D on my screen U on JJVC 
    if c >= 0.75; K=flipud(K); st=dk; end % U on my screen 
end
dv=[-d+(rem(w,2)==0):d];
img(round(sz(1)/2)+dv, round(sz(2)/2)+dv)=K;
img=uint8(abs(255*img-255)); % convert img to black letter on white background

%imshow(img)







