function readDataFcn(src, ~)
disp("Data was received from the client.")
src.UserData = read(src,src.BytesAvailableFcnCount/8,"double");
reshapedServerData = reshape(src.UserData,31,31);
surf(reshapedServerData);
end