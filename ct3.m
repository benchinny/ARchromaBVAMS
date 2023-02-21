%% concatenate the same matrix 3 times and generate 8bit image
function i1=ct3(ir);

i1=uint8(255.*cat(3, ir, ir, ir));







