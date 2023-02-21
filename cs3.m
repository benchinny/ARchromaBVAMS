% circshift and 8bit transformation
function i1=cs3(i0, bxy);

i1=ct8(circshift(i0, bxy(1,:)), circshift(i0, bxy(2,:)), circshift(i0, bxy(3,:)));