function connectionFcn(src, ~)
if src.Connected
    disp("Client connection accepted by server.")
    data = membrane(1);
    write(src,data(:),"double");
end
end