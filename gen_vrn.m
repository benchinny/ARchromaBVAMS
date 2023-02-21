%% generate Voronoi pattern
% x = gallery('uniformdata',[1 500],0);
% y = gallery('uniformdata',[1 500],1);
% voronoi(x,y)
% axis equal


i0=imread('vrn100.png');
i1=i0(:,:,1);
close all;
sz=size(i1);
i11=imgf(double(i1==0),1);i11=(i11~=0);
i22=flipud(i11);

%% gen RGB vrn
i33=fliplr(i11);

i2=i11+i22+i33; i3=(i2>1).*rand(size(i2));

i01=((0 < i3)&(i3 < 1./3));
i02=((1./3 <= i3)&(i3 < 2./3));
i03=(2./3 <= i3);

i11=i11-(i02+i03);
i22=i22-(i01+i03);
i33=i33-(i01+i02);

i4=uint8(255.*cat(3, i11, i22, i33));
imshow(i4)



%% gen RB vrn
i33=i11+i22; i33=(i33==2); i3=i33(:);
x=find(i3==1);
lr=length(x);
ii = randi(lr,round(lr./2),1);
i40=zeros(size(i3)); i40(x(ii))=1; i40=reshape(i40, sz);
i04=i33-i40;
i2=cat(3, i11-i40, zeros(sz), i22-i04);


imshow(i2);


% i0=imread('vrn.png');
% i1=i0(:,:,1);
% close all;
% sz=size(i1);
% i11=imgf(double(i1==0),1);i11=(i11~=0);
% i22=flipud(i11);
% i33=i11+i22; i33=(i33==2); i3=i33(:);
% x=find(i3==1);
% lr=length(x);
% ii = randi(lr,round(lr./2),1);
% i40=zeros(size(i3)); i40(x(ii))=1; i40=reshape(i40, sz);
% i04=i33-i40;
% i2=cat(3, i11-i40, zeros(sz), i22-i04);
% 
% 
% imshow(i2);


% i10=(i11~=0); i10(:, 1:sz(2)./2)=0;
% i01=(i11~=0); i01(:,sz(2)./2+1:end)=0;
% i2=cat(3,i10, zeros(sz), i01);
% imshow(i2)
