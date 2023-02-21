%%210512 gen_frngs generate half screen stimuli for fringe experiment with
%%anti-aliasing


ms=10; sz=[1080 1080]; i0=zeros(sz); i00=zeros(ms.*sz); sz2=ms.*sz./2; sz22=sz./2;
clear im
im{1}=i00; im{2}=i00; im{3}=i00; im{4}=i00;

im{1}(1:sz2(1),:)=1; %up

im{3}(sz2(1)+1:end,:)=1; %down

im{4}(:, 1:sz2(2))=1; %left

im{2}(:, sz2(2)+1:end)=1; %right


clear im_frng; im_frng=im;
for k0=1:10
    for k1=1:4
   im_frng{k1,k0}=uint8(255.*dszf(circshift(im{k1},  [k0-1 k0-1]), ms));     
    end
end


%save('FRNGS_210512.mat', 'im_frng');
