clr
TCAfnm='c65_b75to540_w10_ms10_sd1_6';
load(TCAfnm)
ms=10; p4=1;
n4=1; k0=1; rgb=[3 1]; xy=[6 0; 0 0]
sz=[1080 1920];
i0=uint8(zeros(sz));
i1=uint8(255.*ones(size(m_bkg)));
s0=[1 2]; s1=1; % [right left] screen keyboard control starting with the right screen 


        
    b=uint8(zeros([sz 3]));
    %xy=round(rand(1,2).*xy0.*2)-xy0;
    im=m_bkg-circshift(m_crc{1,1}, xy(1,:)); % background image;
    ic= circshift(m_crc{1,1}-(i1-m_crs{1,1}), xy(1,:));% center image
    %imshow(cat(3, im, i0, ic))
    %b=cat(3, embd(im, i0), i0, embd(ic, i0));
    b(:, :, rgb(n4(k0),1))=embd(ic, i0);
    b(:, :, rgb(n4(k0),2))=embd(im, i0);
%    b(:,:,3)=embd(b_bkg, i0);
    b1=b; b2=b; xy=[xy; xy];

        xr=xy(1,1); yr=xy(1,2);
        xl=xy(2,1); yl=xy(2,2);
%         % decimal integer correct
        [x1r x2r x3r]=d2i(xr, ms);
        [y1r y2r y3r]=d2i(yr, ms);
        
        [x1l x2l x3l]=d2i(xl, ms);
        [y1l y2l y3l]=d2i(yl, ms);
        
                
        
        %correct decimal for negative values
        %v0=[1 10 9 8 7 6 5 4 3 2];
        v0=[10:-1:1];
        
        x1r=x1r+1; if x3r<0; x1r=v0(x1r); end
        y1r=y1r+1; if y3r<0; y1r=v0(y1r); end
        
        x1l=x1l+1; if x3l<0; x1l=v0(x1l); end
        y1l=y1l+1; if y3l<0; y1l=v0(y1l); end
        
        xy(1,1)=x3r; xy(1,2)=y3r;
        xy(2,1)=x3l; xy(2,2)=y3l;
        
        s2=['R' 'L'];
        disp(['EXP' n2s(k0) ' L_EYE DOWN' n2s(x3l) ' RIGHT' n2s(y3l) ' R_EYE DOWN' n2s(x3r) ' RIGHT' n2s(y3r) ' RES' n2s(p4)  ' ' s2(s1)]);
        disp(['EXP' n2s(k0) ' L_EYE DOWN' n2s(x3l) ' RIGHT' n2s(y3l) ' R_EYE DOWN' n2s(x3r) ' RIGHT' n2s(y3r) ' RES' n2s(p4)  ' ' s2(s1)]);

        
        bcr=circshift(m_crc{x1r, y1r}, [x2r y2r]);
        bcl=circshift(m_crc{x1l, y1l}, [x2l y2l]);
        
        bsr=circshift(i1-m_crs{x1r, y1r}, [x2r y2r]);
        bsl=circshift(i1-m_crs{x1l, y1l}, [x2l y2l]);
        
        bgr= m_bkg-(bcr+b_bkg);
        bgl= m_bkg-(bcl+b_bkg);
        
        bcr=(bcr-bsr).*uint8(bcr~=0);
        bcl=(bcl-bsl).*uint8(bcl~=0);
        clear bsr bsl;
        
        b1(:, :, rgb(n4(k0), 1))=embd(bcr, i0); %right front circle
        b1(:, :, rgb(n4(k0), 2))=embd(bgr, i0); %right background circle
        
        b2(:, :, rgb(n4(k0), 1))=embd(bcl, i0); %left front circle
        b2(:, :, rgb(n4(k0), 2))=embd(bgl, i0); %left background circle
        
        b1(:,:,3)=b1(:,:,3)+embd(b_bkg,i0); b2(:,:,3)=b2(:,:,3)+embd(b_bkg,i0);
        
        
        clear bcl bcr bgl bgr;
        
        imshow(b1)