function i3=imcal(i0, cf);
%210621
%i0=imread(LCAim);
%imshow(i0)
%sca
i1=double(i0); i2=i1;
i2(:,:,1)=i1(:,:,1).*cf(1); %red
i2(:,:,2)=i1(:,:,2).*cf(2); %green
i2(:,:,3)=i1(:,:,3).*cf(3); %blue
i3=uint8(i2);
%imshow(i0)






%
% %i0=imread(LCAim);
% %imshow(i0)
% %sca
% i1=double(i0);
% i0(:,:,1)=uint8(i1(:,:,1).*cf(1)); %red
% i0(:,:,2)=uint8(i1(:,:,2).*cf(2)); %green
% i0(:,:,3)=uint8(i1(:,:,3).*cf(3)); %blue
% i2=i0;
% %imshow(i0)
% 

