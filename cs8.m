% circshift and 8bit transformation
function i1=cs8(ir, ig, ib, bxy);

i1=ct8(circshift(ir, bxy(1,:)), circshift(ig, bxy(2,:)), circshift(ib, bxy(3,:)));