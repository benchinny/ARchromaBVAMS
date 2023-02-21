%% V201123 trying 2.^(n/3)
clr
ms=10;
%wv=[1:13]+9; %JOL
wv=[1:13]+4; %210621 20%contrast

c0=0.00384; %deg/pixels
c1=1./(c0.*60);

b=2; s=5; %10; %8
L='E';
sz = [1080, 1080]; % size of screen
STK=b.^(wv./s);
c2=20.*STK./c1
STK00=round(5.*STK)./5;
20.*round(5.*STK)./(5.*c1)
E10c=cell(length(wv), 4, ms, ms);
tic
parfor k0=1:length(wv);
    w=wv(k0);
    for k1=1:4;
        i0=usz(o2i(b, w, s, L, k1, sz), ms);
        for r0=1:ms
            for c0=1:ms
            
                 E10c(k0, k1, r0, c0)= {uint8(255.*dszf(circshift(i0, [r0-1 c0-1]),ms))};

%                 E10c(k0, r0, c0)= {uint8(255.*i6./mxa(i6))};

                disp([k0 k1 r0 c0]);
                
            
            end
        end
                %i4=usz(i0, ms); % i4=imgaussfilt(i4,3);

    end 
        
        %Ev{k0, k1+1}=uint8(255.*i0);        
end
toc %60.43minutes 84.23minutes
% save('E_b3_p1_p13_o4_ms10_201123.mat', 'E10c', 'STK', '-v7.3');
%save('E_b2s4_p1_p13_o4_ms10_201130.mat', 'E10c', 'STK', '-v7.3');
%save('E_b2s10_p1_p13_o4_ms10_201207.mat', 'E10c', 'STK', '-v7.3');
%save('E_b2s8_p1_p13_o4_ms10_201207.mat', 'E10c', 'STK', '-v7.3'); %55minutes
%save('E_b2s10_p1_p13_o4_ms10_210316.mat', 'E10c', 'STK', '-v7.3'); %65minutes
%save('E_b2s6_p2_p14_o4_ms10_210318.mat', 'E10c', 'STK', '-v7.3'); %65minutes
%save('E_b2s2_p1_p11_o4_ms10_210319.mat', 'E10c', 'STK', '-v7.3'); %65minutes
%save('E_b2s5_p2_p14_o4_ms10_210320.mat', 'E10c', 'STK', '-v7.3'); %65minutes
%save('E_b2s4_p1_p13_o4_ms10_210415.mat', 'E10c', 'STK', '-v7.3');
% save('E_b2s5_p10_p22_o4_ms10_210608.mat', 'E10c', 'STK', 'STK00', '-v7.3'); %31minutes
save('E_b2s5_p5_p17_o4_ms10_210621.mat', 'E10c', 'STK', 'STK00', '-v7.3'); %31minutes




% %% V200909 add 4 orientations until I figure out how to calculate the transformation numerically
% clr
% ms=10;
% wv=[-2:10];
% 
% b=2
% L='E';
% sz = [1080, 1080]; % size of screen
% STK=b.^(wv./2);
% E10c=cell(length(wv), 4, ms, ms);
% tic
% parfor k0=1:length(wv);
%     w=wv(k0);
%     for k1=1:4;
%         i0=usz(o2i(b, w, L, k1, sz), ms);
%         for r0=1:ms
%             for c0=1:ms
%             
%                  E10c(k0, k1, r0, c0)= {uint8(255.*dsz(circshift(i0, [r0-1 c0-1]),ms))};
% 
% %                 E10c(k0, r0, c0)= {uint8(255.*i6./mxa(i6))};
% 
%                 disp([k0 k1 r0 c0]);
%                 
%             
%             end
%         end
%                 %i4=usz(i0, ms); % i4=imgaussfilt(i4,3);
% 
%     end 
%         
%         %Ev{k0, k1+1}=uint8(255.*i0);        
% end
% toc
% save('E_b2_m2_p10_o4_ms10.mat', 'E10c', 'STK', '-v7.3');



%% V200908
% 
% clr
% ms=10;
% wv=[-2:10];
% 
% b=2
% L='E';
% sz = [1080, 1080]; % size of screen
% sk=b.^(wv./2);
% E10c=cell(length(wv), ms, ms);
% tic
% for k0=1:length(wv);
%     w=wv(k0);
%         i0=usz(o2i(b, w, L, 0, sz), ms);
%         for r0=1:ms
%             for c0=1:ms
%             
%                  E10c(k0, r0, c0)= {uint8(255.*dsz(circshift(i0, [r0-1 c0-1]),ms))};
% 
% %                 E10c(k0, r0, c0)= {uint8(255.*i6./mxa(i6))};
% 
%                 disp([k0 r0 c0]);
%                 
%             
%             end
%         end
%                 %i4=usz(i0, ms); % i4=imgaussfilt(i4,3);
% 
%         
%         
%         %Ev{k0, k1+1}=uint8(255.*i0);        
% end
% toc
% save('E_b2_m2_p10_ms10.mat', 'E10c', 'sk', '-v7.3');


%imshow(i0)


% clear all
% close all
% clc
% wv=[-16:15];
% 
% b=2
% L='E';
% sz = [1080, 1920]; % size of screen
% 
% for k0=1:length(wv);
%     w=wv(k0);
%     for k1=0:3;        
%         i0=o2i(b, w, L, k1, sz);
%         Ev{k0, k1+1}=uint8(255.*i0);
%         
%     end
% end
% %imshow(i0)