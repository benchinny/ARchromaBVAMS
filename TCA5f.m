function xy4=TCA5f(fnm, xy0, rgb, p0, ppp, window1, window2);

%function xy4=TCA2f(fname, rkc, pp, ey ,window1, window2);
%think about making fname a variable instead of a file to load;

% function bxy=TCA2f(vd, lineWidthPix, pixelsPerPress, ey, vbl0, window1, window2);

% clear all
% close all
% clc
global snt sp kntr ifi cf sz rc00

% global ek uk dk lk rk snt sp black white grey screenXpixels screenYpixels xCenter yCenter ifi cf sz
%108 pix/degree
%display =10 degrees
%FOV=5degrees
%pp=[1 0.1];
p=ppp(1); chk=0;
load(fnm);
ms=p0(1); %antialiasing/supersamling factor
n0=p0(2); %repetitions

i0=uint8(zeros(sz));
i1=uint8(255.*ones(size(m_bkg)));
b=uint8(zeros([sz 3]));

for k0=1:n0;
    xy=round(rand(1,2).*xy0.*2)-xy0;
    im=m_bkg-circshift(m_crc{1,1}, xy); % background image;
    ic= circshift(m_crc{1,1}-(i1-m_crs{1,1}), xy);% center image
    %imshow(cat(3, im, i0, ic))
    %b=cat(3, embd(im, i0), i0, embd(ic, i0));
    b(:, :, rgb(1))=embd(ic, i0);
    b(:, :, rgb(2))=embd(im, i0);
    b1=b; b2=b; xy=[xy; xy];
    
    ext=false;
    while ext == false; %find(KeyCode)~=ek
        
        cwin1(b1, b2, cf, rc00, window1, window2);
%disp([x3r y3r x3l y3l; x2r y2r x2l y2l; x1r y1r x1l y1l]);
        [keyIsDown,secs, kc] = KbCheck;
        %[secs, kc, deltaSecs] = KbStrokeWait;
        kbcTCA; %adjust keyboard press
        
        xr=xy(1,1); yr=xy(1,2);
        xl=xy(2,1); yl=xy(2,2);
        % decimal integer correct
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
        
        
        disp(['EXP' n2s(k0) ' RIGHT X' n2s(x3r) ' Y' n2s(y3r) ' LEFT X' n2s(x3l) ' Y' n2s(y3l) ' RES' n2s(p)]);

        
        bcr=circshift(m_crc{x1r, y1r}, [x2r y2r]);
        bcl=circshift(m_crc{x1l, y1l}, [x2l y2l]);
        
        bsr=circshift(i1-m_crs{x1r, y1r}, [x2r y2r]);
        bsl=circshift(i1-m_crs{x1l, y1l}, [x2l y2l]);
        
        bgr= m_bkg-bcr;
        bgl= m_bkg-bcl;
        
        bcr=(bcr-bsr).*uint8(bcr~=0);
        bcl=(bcl-bsl).*uint8(bcl~=0);
        
        
        b1(:, :, rgb(1))=embd(bcr, i0); %right front circle
        b1(:, :, rgb(2))=embd(bgr, i0); %right background circle
        
        b2(:, :, rgb(1))=embd(bcl, i0); %left front circle
        b2(:, :, rgb(2))=embd(bgl, i0); %left background circle
        
    end
    
    xy4(k0, :)=[x3r y3r x3l y3l];
end


