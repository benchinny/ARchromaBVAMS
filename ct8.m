%% concatenate and generate 8bit image
function i1=ct8(ir, ig, ib);

i1=uint8(255.*cat(3, ir, ig, ib));