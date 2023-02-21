%% concatenate the same matrix 3 times and generate 8bit image
function i1=ct4(ir, c);

if c==0
i1=uint8(255.*cat(3, ir, ir, ir));

else
   i1=zeros([size(ir) 3]);
   i1(:, :, c)=ir;
   i1=uint8(255.*i1);
end