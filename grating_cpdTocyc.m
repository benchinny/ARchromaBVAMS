hor_px=1920;%screen horizontal pixels
minarc_perpix=0.23;% min of arc per pixel

cyc_perdeg= 20; %ENTER cycles per degree

deg_percyc=1/cyc_perdeg;  %degrees/cycle
px_perdeg=60/minarc_perpix; %pixels/degree
numpx_percyc=px_perdeg *deg_percyc %pixels/cycle =pixels/degree *degrees/cycle
num_cycles=hor_px/numpx_percyc;
fprintf('Cycles per degree: %d cpd\n',cyc_perdeg);
fprintf('Number of cycles across %d pixels is: %f cycles\n',hor_px,num_cycles);

