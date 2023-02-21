function m=gbr(f, s, sz);

%% generate gabor stimuli
%cls
%sz = [1080, 1920]; % size of screen
%f=50; %frequency/number of bands
%s=100; %gaussian sigma
%v=2.*pi.*[0:sz(1)]./sz(1)-pi
%v=2.*[0:(sz(1)-1)]./(sz(1)-1); 
%v=[ 0:sz(1)-1 ]./(sz(1)-1); 
t0=repmat(vct(sz(2)), [sz(1) 1]); t=sinpi(2.*f.*t0); %imshow(v0)
h=repmat(normpdf([1:sz(2)], round(sz(2)./2), s), [sz(1) 1]); h=h./mxa(h);
v=repmat(normpdf([1:sz(1)], round(sz(1)./2), s)', [1 sz(2)]); v=v./mxa(v);
m=t.*h.*v; %raise background to 0.5;


%m=0.5.*t.*h.*v+0.5; %raise background to 0.5;

% m0=h.*v; %raise background to 1;
% m1=0.5.*(1-m0); %0.5.*(m0<0.01); 
% m=t.*m0+m1; %imshow(m)


%m=t.*h.*v; %original version
%m=imrotate(t.*h.*v,-10); imshow(m)







% 
% v0=repmat(v, [sz(2), 1]);
% hg=normpdf([1:sz(2)], round(sz(2)./2), s); hf=repmat(fft(hg), [sz(1) 1]);
% vg=normpdf([1:sz(1)], round(sz(1)./2), s); vf=repmat(fft(vg)', [1 sz(2)]);
% 
% 
% 
% 
% %plot(v, sin(v))
% v=vct(sz(1));
% 
% [V,Y] = meshgrid(v,[1:sz(2)]);
% i0=sinpi(f.*V);
% imshow(i0)


% i1=ones(sz);
% i2=
% x = 1:3;
% y = 1:5;
% [X,Y] = meshgrid(x,y)


% 
% wavelength = 2;
% orientation = [0 45 90 135];
% g = gabor(wavelength,orientation);
% s=g.SpatialKernel;
% imshow(real(s))

% 
% g.SpatialFrequencyBandwidth
% g.SpatialAspectRatio