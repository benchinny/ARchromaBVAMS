clear all
close all
clc

global ek uk dk lk rk st snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi zbr cf Ec sz E10c
addpath([pwd '\fcns']); addpath([pwd '\imgs']); addpath([pwd '\apps']); addpath([pwd '\toolboxes']); addpath([pwd '\data'])
addpath([pwd '\psignifit-master']); 
load S10009_ETM_R_2008241551.mat
wv(1:5)=[];
bns=[min(wv):max(wv)];
v0=zeros(1,length(bns));
v1=v0;
for k0=1:length(wv)
    k1=wv(k0);
    v0=v0+(k1==bns);
    v1=v1+rv(k0)*(k1==bns);
end

bar(bns, v1./v0)
data=[bns' v1' v0'];
options = struct; 
options.sigmoidName = 'norm';   % choose a cumulative Gaussian as the sigmoid
options.expType     = '4AFC';   % choose 2-AFC as the paradigm of the experiment
result = psignifit(data,options);
plotPsych(result);
