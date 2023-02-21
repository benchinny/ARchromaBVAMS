%adjust image to specific contrast
%adjc adjust for contrast
function i1=idj(i0, c);
c0=mne(i0);

i1=c.*(i0-c0)+c0;
