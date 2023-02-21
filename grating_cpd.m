hor_px=1920;%screen horizontal pixels
cycles=50;
minarc_perpix=0.23;% min of arc per pixel
deg_perpix=minarc_perpix/60 ;%degree per pixel

numpx_percyc=hor_px/cycles % pixels per cycle
deg_percyc=deg_perpix*numpx_percyc%degree per pixel* pixels per cycle = degree per cycle
cyc_perdeg= 1/deg_percyc
