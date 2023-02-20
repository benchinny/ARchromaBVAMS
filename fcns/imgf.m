function i1=imgf(i0, sg);
% gaussian filter a 2D image
if sg<=0
    i1=i0;
else
    i1=imgaussfilt(i0, sg);
end