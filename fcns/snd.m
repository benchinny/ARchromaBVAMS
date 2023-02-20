function snd(freq, duration);
% generate sinusoidal beep/sound
amp=10 ;
fs=200000; % sampling frequency
%duration=0.1
%freq=250; %500; %1000
values=0:1/fs:duration;
a=amp*sin(2*pi* freq*values);
soundsc(a, fs);